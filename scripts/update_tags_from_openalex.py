"""
Update TAGLIST column in AR6.csv using OpenAlex API properties.

For rows where CHAPTER == 0: use Domain (from primary topic) + Sustainable Development Goal names.
For rows where CHAPTER  > 0: use Topic + Subfield + Field names (from primary topic).

Rows without an OpenAlex ID are left unchanged.
"""

import csv
import json
import urllib.request
import urllib.error
import time

INPUT_FILE  = "data-import/XML-DTD/input/AR6.csv"
OUTPUT_FILE = "data-import/XML-DTD/input/AR6.csv"

CHAPTER_COL  = 3
OPENALEX_COL = 9
TAGLIST_COL  = 10

API_BASE = "https://api.openalex.org/works"
HEADERS  = {"User-Agent": "ckg-bot/1.0 (mailto:info@tibhannover.de)"}


def fetch_tags(openalex_id: str, chapter_is_zero: bool) -> str | None:
    """Return a '; '-joined tag string, or None on error."""
    url = f"{API_BASE}/{openalex_id}?select=id,topics,sustainable_development_goals"
    req = urllib.request.Request(url, headers=HEADERS)
    try:
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as exc:
        print(f"  HTTP {exc.code} for {openalex_id} — skipping")
        return None
    except Exception as exc:
        print(f"  Error for {openalex_id}: {exc} — skipping")
        return None

    topics = data.get("topics", [])
    sdgs   = data.get("sustainable_development_goals", [])

    if chapter_is_zero:
        # Domain from the primary topic  +  all SDG names
        parts = []
        if topics:
            domain = topics[0].get("domain", {}).get("display_name", "")
            if domain:
                parts.append(domain)
        for sdg in sdgs:
            name = sdg.get("display_name", "")
            if name:
                parts.append(name)
        return "; ".join(parts)
    else:
        # Topic / Subfield / Field from the primary topic
        if not topics:
            return ""
        t = topics[0]
        parts = []
        for key in ("display_name",):          # Topic
            val = t.get(key, "")
            if val:
                parts.append(val)
        for nested in ("subfield", "field"):
            val = t.get(nested, {}).get("display_name", "")
            if val:
                parts.append(val)
        return "; ".join(parts)


def main() -> None:
    # Read all rows
    with open(INPUT_FILE, encoding="utf-8", newline="") as fh:
        reader = csv.reader(fh)
        header = next(reader)
        rows   = list(reader)

    updated = 0

    for row in rows:
        if len(row) <= OPENALEX_COL:
            continue

        openalex_id = row[OPENALEX_COL].strip()
        if not openalex_id:
            continue

        try:
            chapter_val = int(row[CHAPTER_COL].strip())
        except ValueError:
            continue

        chapter_is_zero = chapter_val == 0

        print(f"Fetching {openalex_id}  (chapter={chapter_val}, "
              f"mode={'domain+sdg' if chapter_is_zero else 'topic+subfield+field'}) …")

        tags = fetch_tags(openalex_id, chapter_is_zero)

        if tags is not None:
            row[TAGLIST_COL] = tags
            updated += 1

        time.sleep(0.15)   # polite delay

    # Write back
    with open(OUTPUT_FILE, "w", encoding="utf-8", newline="") as fh:
        writer = csv.writer(fh, quoting=csv.QUOTE_MINIMAL)
        writer.writerow(header)
        writer.writerows(rows)

    print(f"\nDone — updated {updated} rows.")


if __name__ == "__main__":
    main()
