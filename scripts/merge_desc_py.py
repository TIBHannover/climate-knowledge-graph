
import csv

openalex_data = {}
with open("data/doi/ar6-doi-openalex.csv", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        doi_url = row["DOI"].strip()
        openalex_data[doi_url] = {
            "OpenAlex_ID": row.get("OpenAlex_ID", ""),
            "Description": row.get("Description", "")
        }

merged_rows = []
with open("data/doi/ar6-doi-validation.csv", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = list(reader.fieldnames)
    if "description" not in fields:
        fields.append("description")
    
    for row in reader:
        match_url = row.get("input", "")
        cross_url = row.get("crossref_url", "")
        raw_doi = "https://doi.org/" + row.get("doi", "")
        
        ref_data = openalex_data.get(match_url) or openalex_data.get(cross_url) or openalex_data.get(raw_doi)
        
        if ref_data:
            row["openalex_id"] = ref_data["OpenAlex_ID"]
            row["description"] = ref_data["Description"]
        else:
            if "description" not in row:
                row["description"] = ""
        
        merged_rows.append(row)

with open("data/doi/ar6-doi-validation.csv", "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(merged_rows)

print("Successfully merged descriptions into validation file.")

