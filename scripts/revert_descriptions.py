
import csv
import urllib.request
import json
import re
import time
import os

csv_path = "data/doi/ar6-doi-validation.csv"

def get_openalex_description(work_id):
    if not work_id or not work_id.startswith("https://openalex.org/"):
        return None
    
    api_url = work_id.replace("https://openalex.org/", "https://api.openalex.org/works/")
    headers = {"User-Agent": "mailto:admin@example.org"}
    try:
        req = urllib.request.Request(api_url, headers=headers)
        with urllib.request.urlopen(req, timeout=15) as response:
            data = json.loads(response.read().decode())
            index = data.get("abstract_inverted_index")
            if not index:
                return None
            
            word_list = []
            for word, pos_list in index.items():
                for pos in pos_list:
                    word_list.append((pos, word))
            word_list.sort()
            text = " ".join([w[1] for w in word_list])
            
            if len(text) <= 250:
                return text
            
            truncated = text[:250]
            last_dot = truncated.rfind(".")
            if last_dot > 150:
                return truncated[:last_dot + 1]
            return truncated.rsplit(" ", 1)[0] + "..."
            
    except Exception as e:
        print(f"Error fetching {work_id}: {e}")
        return None

rows = []
with open(csv_path, "r", encoding="utf-8") as f:
    rows = list(csv.DictReader(f))
    fieldnames = list(rows[0].keys())

print(f"Reverting {len(rows)} descriptions to OpenAlex source...")
for i, row in enumerate(rows):
    work_id = row.get("openalex_id")
    if work_id:
        print(f"[{i+1}/{len(rows)}] {work_id}...")
        new_desc = get_openalex_description(work_id)
        if new_desc:
            row["description"] = new_desc
            print(f"  Success.")
        time.sleep(0.2) # Throttling

with open(csv_path, "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)
print("Done.")

