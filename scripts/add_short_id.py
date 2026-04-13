
import csv

input_file = "data/doi/ar6-doi-validation.csv"
output_file = "data/doi/ar6-doi-validation.csv"

rows = []
with open(input_file, "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = list(reader.fieldnames)
    
    if "openalex_id_short" not in fields:
        # Insert it right after openalex_id
        idx = fields.index("openalex_id")
        fields.insert(idx + 1, "openalex_id_short")
        
    for row in reader:
        val = row.get("openalex_id", "")
        if val.startswith("https://openalex.org/"):
            row["openalex_id_short"] = val.replace("https://openalex.org/", "")
        else:
            row["openalex_id_short"] = val
        rows.append(row)

with open(output_file, "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(rows)

print("Successfully added openalex_id_short to validation CSV.")

