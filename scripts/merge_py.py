
import csv

openalex_data = {}
with open("data/doi/ar6-doi-openalex.csv", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        # Key on the DOI URL to match the input or crossref_url
        doi_url = row["DOI"].strip()
        openalex_data[doi_url] = row["OpenAlex_ID"]

merged_rows = []
matched_count = 0
with open("data/doi/ar6-doi-validation.csv", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = reader.fieldnames
    for row in reader:
        # The input column or crossref_url usually has the https://doi.org/ form
        match_url = row.get("input", "")
        if match_url in openalex_data:
            row["openalex_id"] = openalex_data[match_url]
            if openalex_data[match_url]:
                matched_count += 1
        elif row.get("crossref_url", "") in openalex_data:
            row["openalex_id"] = openalex_data[row["crossref_url"]]
            if openalex_data[row["crossref_url"]]:
                matched_count += 1
        else:
            # Maybe the raw doi? Let us check if https://doi.org/ + doi works
            fallback = "https://doi.org/" + row.get("doi", "")
            if fallback in openalex_data:
                row["openalex_id"] = openalex_data[fallback]
                if openalex_data[fallback]:
                    matched_count += 1
            else:
                row["openalex_id"] = ""
        merged_rows.append(row)

with open("data/doi/ar6-doi-validation.csv", "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(merged_rows)

print(f"Merged OpenAlex IDs: {matched_count} / {len(merged_rows)}")

