"""
Normalise author names from ALL CAPS to Title Case in IPCC AR6 authors CSV.

Handles:
    - Hyphenated names (DIONGUE-NIANG -> Diongue-Niang)
    - Multi-word names (VAN VUUREN -> Van Vuuren)
    - Diacritics (AðALGEIRSDóTTIR -> Aðalgeirsdóttir)
    - Roman numerals (TURNER II -> Turner II)
    - Parenthesised nicknames (Elizabeth (libby) -> Elizabeth (Libby))
    - Abbreviations with periods (Bjørn H. -> Bjørn H.)

Input/Output: ipcc-ar6-authors-v2.csv (in-place update)
"""

import csv
import re

ROMAN = {"II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"}


def title_part(s):
    """Title-case a single hyphen-free, space-free token."""
    if s.strip("()").upper() in ROMAN:
        return s.upper()
    if re.match(r"^[a-zA-Z]\.$", s):
        return s[0].upper() + "."
    if len(s) == 0:
        return s
    if s.startswith("(") and len(s) > 1:
        return "(" + s[1].upper() + s[2:]
    return s[0].upper() + s[1:]


def title_case_name(name):
    """Convert a name to title case, handling hyphens, spaces, parens."""
    name = name.lower()
    words = name.split(" ")
    result_words = []
    for word in words:
        parts = word.split("-")
        titled_parts = [title_part(p) for p in parts]
        result_words.append("-".join(titled_parts))
    return " ".join(result_words)


INPUT_OUTPUT_FILE = "ipcc-ar6-authors-v2.csv"


if __name__ == "__main__":
    with open(INPUT_OUTPUT_FILE, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        rows = list(reader)

    for r in rows:
        r["Last Name"] = title_case_name(r["Last Name"])
        r["First Name"] = title_case_name(r["First Name"])

    with open(INPUT_OUTPUT_FILE, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"Name normalisation complete. {len(rows)} rows processed.")
