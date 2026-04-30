# Tagging Approach for AR6.csv

## Overview

The `TAGLIST` column in [`data-import/XML-DTD/input/AR6.csv`](../data-import/XML-DTD/input/AR6.csv) is populated by two separate scripts, each targeting a different class of row. Tags are separated by semicolons (`;`).

---

## Row classes

AR6.csv has a `CHAPTER` column (index 3) with integer values:

| `CHAPTER` value | Meaning | Tag source |
|---|---|---|
| `0` | Top-level report object (series/book) | OpenAlex API |
| `> 0` | Chapter, summary, or cross-chapter item | Glossary + full-text analysis |

---

## 1. Top-level rows (`CHAPTER = 0`) — OpenAlex tags

**Script:** [`scripts/update_tags_from_openalex.py`](../scripts/update_tags_from_openalex.py)

### Method

Each top-level row carries an OpenAlex work ID in the `OPENALEX` column (e.g. `W4382363623`). The script calls the OpenAlex API:

```
GET https://api.openalex.org/works/{id}?select=id,topics,sustainable_development_goals
```

Tags are constructed from the response as follows:

- **Domain** — the domain name of the primary topic (e.g. `Physical Sciences`, `Social Sciences`)
- **Sustainable Development Goal** — the display name of each matched SDG (e.g. `Climate action`, `No poverty`)

Rows without an OpenAlex ID are left unchanged.

### Examples

| Report | Tags |
|---|---|
| SR15 | `Social Sciences; No poverty` |
| SRCCL | `Physical Sciences` |
| SROCC | `Physical Sciences; Climate action` |
| WG1 | `Physical Sciences; Climate action` |
| WG2 | `Life Sciences; Climate action` |
| WG3 | `Social Sciences; No poverty` |
| SYR | `Social Sciences; No poverty` |

---

## 2. Chapter-level rows (`CHAPTER > 0`) — Glossary + full-text tags

**Script:** [`scripts/tag_chapters_from_glossary.py`](../scripts/tag_chapters_from_glossary.py)

### Source data

| Input | Path |
|---|---|
| Term list | [`data/glossary/Glossary.csv`](../data/glossary/Glossary.csv) — 920 entries, `Term` column |
| Full text | [`mediawiki-text/KEWL-20260322093018.xml`](../mediawiki-text/KEWL-20260322093018.xml) — MediaWiki export, 89 pages |

### Method

#### Step 1 — Load XML pages

The MediaWiki XML export is parsed. For each page, markup is stripped (HTML tags, `[[ ]]`, `{{ }}`, wiki syntax, URLs) to produce clean plain text. A case-insensitive word-frequency `Counter` and a lowercased full-text string are stored, keyed by page title.

Page titles in the XML match the path segment of the WIKI URL column exactly: for a row with `https://test.kewl.org/wiki/IPCC:Wg3:Chapter:Chapter-6`, the lookup key is `IPCC:Wg3:Chapter:Chapter-6`.

#### Step 2 — Filter glossary terms

Only terms with **≤ 3 words** are used (829 of 920 terms). This keeps tags concise and avoids long definitional phrases.

#### Step 3 — Build exclusion set

Tags already used on `CHAPTER = 0` rows are collected into an exclusion set (lowercased) so chapter tags never duplicate the top-level report tags. The following ubiquitous terms are also permanently excluded regardless of frequency:

- `Climate`
- `Climate change`
- `Global change`

#### Step 4 — Score each glossary term

For every candidate term, *content words* are extracted by removing stop words (`a`, `the`, `and`, `of`, etc.). The term is then scored against the chapter's word-frequency counter:

```
freqs     = frequency of each content word in the page
mean_f    = mean(freqs of words that are present)
min_f     = min(freqs of words that are present)
coverage  = (number of words present) / (total content words)
base      = min_f × 0.6 + mean_f × 0.4
bonus     = base × 0.5   if the exact phrase appears verbatim in the page
score     = (base + bonus) × coverage²
```

Key properties of this formula:

- `min_f` ensures terms whose key words barely appear are ranked low.
- `mean_f` rewards terms whose words all appear frequently.
- The **verbatim phrase bonus** (+50 %) promotes exact glossary matches over reconstructed word-level matches.
- The **coverage² penalty** heavily demotes partial matches (where some content words are absent), so they only fill tag slots when full matches are exhausted. This guarantees every row receives exactly 3 tags.

#### Step 5 — Rank and select

Scored terms are sorted by:

1. Full match first (all content words present in page)
2. Score descending
3. Term length ascending (shorter terms preferred on ties)
4. Alphabetical (tie-break)

The top 3 unique terms (deduplicated by lowercase value, excluding the exclusion set) become the row's tags.

### Examples

| Chapter | Tags |
|---|---|
| WG3 Ch.6 — Energy Systems | `Wind energy; Energy system; Solar energy` |
| WG3 Ch.8 — Urban Systems | `Urban; Cities; Urban Systems` |
| WG3 Ch.9 — Buildings | `Energy efficiency; Renewable energy; Energy system` |
| SROCC Ch.3-2 — Polar Regions | `Sea ice; Ocean; Confidence` |
| SROCC Ch.4 — Sea Level Rise | `Sea level change; Sea ice; Sea level rise` |
| SRCCL Ch.3 — Desertification | `Land; Desertification; Land degradation` |
| WG2 Ch.3 — Oceans | `Ocean; Confidence; Ocean acidification` |
| WG2 Ccp1 — Biodiversity | `Biodiversity; Biodiversity hotspots; Confidence` |

---

## File column reference

`AR6.csv` columns (0-indexed):

| Index | Header | Notes |
|---|---|---|
| 0 | `WIKI` URL | Used to look up XML page title |
| 1 | `SERIES` OBJECT | |
| 2 | `BOOK` OBJECT | |
| 3 | `CHAPTER` OBJECT | `0` = top-level; `>0` = chapter/summary |
| 4 | `TITLE` | |
| 5 | `DESCRIPTION` | |
| 6 | `SOURCE` URL | |
| 7 | `PDF` URL | |
| 8 | `DOI` | |
| 9 | `OPENALEX` | OpenAlex work ID (e.g. `W4382363623`) |
| 10 | `TAGLIST` | Semicolon-separated tags — populated by both scripts |
| 11 | `LICENSE` | |
| 12 | `DATE` | |

---

## Running the scripts

Both scripts must be run from the repository root with the project virtual environment active.

```bash
# 1. Populate CHAPTER=0 rows from OpenAlex
python scripts/update_tags_from_openalex.py

# 2. Populate CHAPTER>0 rows from glossary + XML full text
python scripts/tag_chapters_from_glossary.py
```

The second script overwrites only the `TAGLIST` cells of `CHAPTER > 0` rows; all other columns and rows are preserved.
