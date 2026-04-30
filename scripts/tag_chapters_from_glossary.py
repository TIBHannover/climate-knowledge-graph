"""
For AR6.csv rows where CHAPTER > 0, select up to 3 glossary terms (Term column,
≤ 3 words) that best match the chapter's full-text page content from
KEWL-20260322093018.xml, using word-frequency analysis.

Matching strategy:
  - Extract the XML page whose title = WIKI URL path (after /wiki/)
  - Build a word-frequency map from the cleaned page text
  - Score each short glossary term as:
      mean_freq  = average frequency of each content word in the term
      min_freq   = minimum frequency of each content word in the term
      score      = min_freq * 0.6 + mean_freq * 0.4
    (min_freq ensures *all* content words are present; mean_freq rewards
     terms whose words are all high-frequency)
  - Exact phrase bonus: if the full term appears verbatim in the page text,
    add a large bonus to the score.
  - Take the top 3 unique terms (by lower-cased value) that are not in the
    exclusion set built from CHAPTER == 0 rows.

Short terms: ≤ 3 words.
Tags from CHAPTER == 0 rows are never reused.
"""

import csv
import re
import xml.etree.ElementTree as ET
from collections import Counter

GLOSSARY_FILE = "data/glossary/Glossary.csv"
AR6_FILE      = "data-import/XML-DTD/input/AR6.csv"
XML_FILE      = "mediawiki-text/KEWL-20260322093018.xml"
XML_NS        = "http://www.mediawiki.org/xml/export-0.11/"

CHAPTER_COL  = 3
WIKI_COL     = 0     # "WIKI" 'URL' column
OPENALEX_COL = 9
TAGLIST_COL  = 10

MAX_TERM_WORDS = 3

STOP_WORDS = {
    "a", "an", "the", "and", "or", "of", "in", "on", "to", "for",
    "with", "by", "at", "from", "is", "are", "be", "as", "its",
    "their", "other", "that", "this", "these", "into", "has", "have",
    "been", "was", "were", "it", "not", "but", "which", "who", "they",
}


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def clean_text(raw: str) -> str:
    """Strip MediaWiki / HTML markup, return plain text."""
    t = re.sub(r"<[^>]+>", " ", raw)          # HTML tags
    t = re.sub(r"\[\[[^\]]*\|([^\]]+)\]\]", r"\1", t)  # [[link|label]]
    t = re.sub(r"\[\[|\]\]|\{\{|\}\}|==+|''", " ", t)   # wiki syntax
    t = re.sub(r"https?://\S+", " ", t)        # URLs
    return t


def word_freq(text: str) -> Counter:
    """Lower-case word frequencies, excluding very short words."""
    words = re.findall(r"[a-zA-Z\u00C0-\u024F]+", text.lower())
    return Counter(w for w in words if len(w) >= 3)


def content_words(term: str) -> list[str]:
    """Words of a glossary term, excluding stop words, lower-cased."""
    return [w.lower() for w in re.findall(r"[a-zA-Z\u00C0-\u024F]+", term)
            if w.lower() not in STOP_WORDS]


def score_term(term: str, freq: Counter, page_text_lower: str) -> tuple[float, bool]:
    """Score a glossary term against a page's word-frequency counter.

    Returns (score, full_match) where full_match=True means every content
    word was found in the page.  Partial matches (at least one word found)
    get a coverage penalty so they only fill slots when full matches run out.
    """
    cw = content_words(term)
    if not cw:
        return 0.0, False

    freqs = [freq.get(w, 0) for w in cw]
    present = [f for f in freqs if f > 0]

    if not present:        # no content word found at all → discard
        return 0.0, False

    full_match = len(present) == len(freqs)
    coverage   = len(present) / len(freqs)

    mean_f = sum(present) / len(present)
    min_f  = min(present)
    base   = min_f * 0.6 + mean_f * 0.4

    # Phrase bonus: verbatim term present in page
    phrase = term.lower()
    bonus = base * 0.5 if phrase in page_text_lower else 0.0

    # Partial matches are heavily penalised so they only fill when needed
    score = (base + bonus) * (coverage ** 2)
    return score, full_match


# ---------------------------------------------------------------------------
# Load XML pages: title → (freq_counter, page_text_lower)
# ---------------------------------------------------------------------------

def load_xml_pages(path: str) -> dict:
    tree = ET.parse(path)
    root = tree.getroot()
    pages = {}
    for page in root.findall(f"{{{XML_NS}}}page"):
        title = page.findtext(f"{{{XML_NS}}}title") or ""
        text_el = page.find(f".//{{{XML_NS}}}text")
        raw = text_el.text if text_el is not None and text_el.text else ""
        cleaned = clean_text(raw)
        pages[title] = (word_freq(cleaned), cleaned.lower())
    return pages


# ---------------------------------------------------------------------------
# Load glossary: short terms only
# ---------------------------------------------------------------------------

def load_short_glossary(path: str, max_words: int = MAX_TERM_WORDS) -> list[str]:
    terms = []
    with open(path, encoding="utf-8-sig", newline="") as fh:
        reader = csv.DictReader(fh)
        for row in reader:
            term = row.get("Term", "").strip()
            if term and len(term.split()) <= max_words:
                terms.append(term)
    return terms


# ---------------------------------------------------------------------------
# Collect excluded tags from CHAPTER == 0 rows
# ---------------------------------------------------------------------------

def excluded_tags(rows: list, taglist_col: int, chapter_col: int) -> set[str]:
    excl = set()
    for row in rows:
        if len(row) <= taglist_col:
            continue
        try:
            if int(row[chapter_col].strip()) == 0:
                for tag in row[taglist_col].split(";"):
                    t = tag.strip().lower()
                    if t:
                        excl.add(t)
        except ValueError:
            pass
    return excl


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    print("Loading XML pages …")
    pages = load_xml_pages(XML_FILE)
    print(f"  {len(pages)} pages loaded.")

    print("Loading glossary …")
    glossary = load_short_glossary(GLOSSARY_FILE)
    print(f"  {len(glossary)} short terms (≤{MAX_TERM_WORDS} words).")

    with open(AR6_FILE, encoding="utf-8", newline="") as fh:
        reader = csv.reader(fh)
        header = next(reader)
        rows   = list(reader)

    excl = excluded_tags(rows, TAGLIST_COL, CHAPTER_COL)
    # Also permanently exclude these ubiquitous terms
    excl |= {"climate", "climate change", "global change"}
    print(f"  Excluded tags: {sorted(excl)}")

    updated = no_page = 0

    for row in rows:
        if len(row) <= TAGLIST_COL:
            continue
        try:
            chapter_val = int(row[CHAPTER_COL].strip())
        except ValueError:
            continue

        if chapter_val == 0:
            continue

        # Derive XML page title from WIKI URL (everything after /wiki/)
        wiki_url = row[WIKI_COL].strip().rstrip()
        if not wiki_url:
            continue

        m = re.search(r"/wiki/(.+)", wiki_url)
        if not m:
            continue
        page_title = m.group(1).strip()

        if page_title not in pages:
            print(f"  [no page] {page_title}")
            no_page += 1
            continue

        freq, page_text_lower = pages[page_title]

        # Score every glossary term
        scored = []
        for term in glossary:
            if term.lower() in excl:
                continue
            s, full = score_term(term, freq, page_text_lower)
            if s > 0:
                scored.append((full, s, term))

        # Full matches first (True > False), then score desc, then shorter/alpha
        scored.sort(key=lambda x: (not x[0], -x[1], len(x[2]), x[2]))

        # Pick top 3 unique (by lower-case); partial matches fill remaining slots
        seen = set()
        tags = []
        for _, _, term in scored:
            tl = term.lower()
            if tl not in seen:
                seen.add(tl)
                tags.append(term)
            if len(tags) == 3:
                break

        if tags:
            row[TAGLIST_COL] = "; ".join(tags)
            updated += 1
            print(f"  {page_title:55s} → {row[TAGLIST_COL]}")
        else:
            print(f"  {page_title:55s} → (no match)")

    with open(AR6_FILE, "w", encoding="utf-8", newline="") as fh:
        writer = csv.writer(fh, quoting=csv.QUOTE_MINIMAL)
        writer.writerow(header)
        writer.writerows(rows)

    print(f"\nDone — updated {updated} rows, {no_page} rows had no XML page.")


if __name__ == "__main__":
    main()

