
import csv
import json
import urllib.request
import time
from collections import Counter

input_file = "data/doi/ar6-doi-validation.csv"

licenses = Counter()
oa_statuses = Counter()

print("Fetching license information from OpenAlex...")
with open(input_file, "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for i, row in enumerate(reader):
        oa_id = row.get("openalex_id_short")
        if not oa_id:
            continue
        
        url = f"https://api.openalex.org/works/{oa_id}"
        req = urllib.request.Request(url, headers={"User-Agent": "ckg-bot/1.0 (mailto:info@example.com)"})
        try:
            with urllib.request.urlopen(req) as response:
                data = json.loads(response.read().decode("utf-8"))
                
                # Check primary location for license
                loc = data.get("primary_location") or {}
                lic = loc.get("license") or "No license specified"
                licenses[lic] += 1
                
                # Check OA status
                oa = data.get("open_access") or {}
                status = oa.get("oa_status") or "unknown"
                oa_statuses[status] += 1
                
        except Exception as e:
            pass
        time.sleep(0.1)

print("\n--- Summary of Licenses ---")
for k, v in licenses.most_common():
    print(f"{k}: {v}")

print("\n--- Summary of Open Access Status ---")
for k, v in oa_statuses.most_common():
    print(f"{k}: {v}")

