"""
Normalise citizenship short-forms to full country names in IPCC AR6 authors CSV.

Maps:
    UK -> United Kingdom (of Great Britain and Northern Ireland)
    USA -> United States of America
    Russia -> Russian Federation
    Tanzania -> United Republic of Tanzania

Input:  ipcc-ar6-authors-v1.csv
Output: ipcc-ar6-authors-v2.csv (also used by subsequent scripts)
"""

import csv

CITIZENSHIP_MAP = {
    "UK": "United Kingdom (of Great Britain and Northern Ireland)",
    "USA": "United States of America",
    "Russia": "Russian Federation",
    "Tanzania": "United Republic of Tanzania",
}

INPUT_FILE = "ipcc-ar6-authors-v1.csv"
OUTPUT_FILE = "ipcc-ar6-authors-v2.csv"


def normalise_citizenship(rows):
    changed = 0
    for r in rows:
        cit = r["Citizenship"].strip()
        if cit in CITIZENSHIP_MAP:
            r["Citizenship"] = CITIZENSHIP_MAP[cit]
            changed += 1
    return changed


if __name__ == "__main__":
    with open(INPUT_FILE, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        rows = list(reader)

    changed = normalise_citizenship(rows)

    with open(OUTPUT_FILE, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"Citizenship normalisation: {changed} rows updated.")
    print(f"Output: {OUTPUT_FILE}")
