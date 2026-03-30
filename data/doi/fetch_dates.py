
import csv
import json
import urllib.request
import urllib.error
import time
import os

input_file = "data/doi/ar6-doi-validation.csv"
output_file = "data/doi/ar6-doi-validation_updated.csv"

def fetch_crossref_date(doi):
    if not doi:
        return ""
    # CrossRef API url
    api_url = f"https://api.crossref.org/works/{doi}"
    req = urllib.request.Request(api_url, headers={'User-Agent': 'ckg-bot/1.0 (mailto:info@example.org)'})
    try:
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode('utf-8'))
            message = data.get('message', {})
            
            # Try published-print, then published-online, then issued
            date_parts = None
            if 'published-print' in message and 'date-parts' in message['published-print']:
                date_parts = message['published-print']['date-parts'][0]
            elif 'published-online' in message and 'date-parts' in message['published-online']:
                date_parts = message['published-online']['date-parts'][0]
            elif 'issued' in message and 'date-parts' in message['issued']:
                date_parts = message['issued']['date-parts'][0]
            
            if date_parts:
                year = str(date_parts[0])
                month = str(date_parts[1]).zfill(2) if len(date_parts) >= 2 else "01"
                day = str(date_parts[2]).zfill(2) if len(date_parts) >= 3 else "01"
                return f"{year}-{month}-{day}"
            return ""
    except Exception as e:
        print(f"Error fetching date for {doi}: {e}")
        return ""

def main():
    if not os.path.exists(input_file):
        print(f"File not found: {input_file}")
        return

    with open(input_file, mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        rows = list(reader)

    print(f"Processing {len(rows)} rows...")
    for i, row in enumerate(rows):
        doi = row.get('doi', '').strip()
        if doi:
            date = fetch_crossref_date(doi)
            if date:
                row['published'] = date
                print(f"[{i+1}/{len(rows)}] {doi} -> {date}")
            else:
                print(f"[{i+1}/{len(rows)}] {doi} -> No date found")
        time.sleep(0.1)  # Respect API

    with open(output_file, mode='w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)
    print(f"Updated CSV saved to {output_file}")

if __name__ == "__main__":
    main()
