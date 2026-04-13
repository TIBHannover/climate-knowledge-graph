"""
Normalise Role and Gender values in IPCC AR6 authors CSV.

Role changes:
    - Core_Writing_Team -> Core Writing Team
    - CLA -> Coordinating Lead Author
    - LA  -> Lead Author
    - RE  -> Review Editor
    (Author and Lead are left unchanged)

Gender changes:
    - M -> Male
    - F -> Female

Input/Output: ipcc-ar6-authors-v2.csv (in-place update)
"""

import csv

ROLE_MAP = {
    "CLA": "Coordinating Lead Author",
    "LA": "Lead Author",
    "RE": "Review Editor",
    "Core_Writing_Team": "Core Writing Team",
}

GENDER_MAP = {
    "M": "Male",
    "F": "Female",
}

INPUT_OUTPUT_FILE = "ipcc-ar6-authors-v2.csv"


if __name__ == "__main__":
    with open(INPUT_OUTPUT_FILE, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        rows = list(reader)

    roles_changed = 0
    gender_changed = 0

    for r in rows:
        role = r["Role"].strip()
        if role in ROLE_MAP:
            r["Role"] = ROLE_MAP[role]
            roles_changed += 1

        gender = r["Gender"].strip()
        if gender in GENDER_MAP:
            r["Gender"] = GENDER_MAP[gender]
            gender_changed += 1

    with open(INPUT_OUTPUT_FILE, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"Role normalisation: {roles_changed} rows updated.")
    print(f"Gender normalisation: {gender_changed} rows updated.")
