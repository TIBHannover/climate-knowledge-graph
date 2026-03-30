
import csv
rows = []
modified_count = 0
with open("data/doi/ar6-doi-validation.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = list(reader.fieldnames)
    for row in reader:
        desc = row.get("description", "")
        if "&#13;\n" in desc:
            desc = desc.replace("&#13;\n", " ")
        if desc.endswith("..."):
            pass # already handled
        row["description"] = desc
        rows.append(row)

with open("data/doi/ar6-doi-validation.csv", "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(rows)

