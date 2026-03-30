
import csv

with open("data/doi/ar6-doi-validation.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        desc = row.get("description", "")
        if "A summary is not available" in desc:
            print(f"{row[\"doi\"]} | {row[\"title\"]}")

