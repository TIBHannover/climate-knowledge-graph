
import csv
import json
import urllib.request
import time

input_file = "data/doi/ar6-doi-validation.csv"
output_file = "data/doi/ar6-doi-validation.csv"

rows = []
with open(input_file, "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = list(reader.fieldnames)
    
    if "license" not in fields:
        fields.extend(["license", "oa_status"])
        
    for i, row in enumerate(reader):
        oa_id = row.get("openalex_id_short", "")
        lic = "No license specified"
        status = "unknown"
        
        if oa_id:
            url = f"https://api.openalex.org/works/{oa_id}"
            req = urllib.request.Request(url, headers={"User-Agent": "ckg-bot/1.0 (mailto:info@example.com)"})
            try:
                with urllib.request.urlopen(req) as response:
                    data = json.loads(response.read().decode("utf-8"))
                    
                    loc = data.get("primary_location") or {}
                    lic = loc.get("license") or "No license specified"
                    
                    oa = data.get("open_access") or {}
                    status = oa.get("oa_status") or "unknown"
            except Exception as e:
                pass
            time.sleep(0.1)
                
        row["license"] = lic
        row["oa_status"] = status
        rows.append(row)

with open(output_file, "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(rows)

print("Saved license data to CSV")

