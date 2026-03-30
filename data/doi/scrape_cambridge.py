
import csv
import urllib.request
import re
import time

input_file = "data/doi/ar6-doi-validation.csv"
output_file = "data/doi/ar6-doi-validation.csv"

def get_cc_license(url):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=15) as response:
            html = response.read().decode("utf-8", errors="ignore")
            # Look for common CC patterns in Cambridge University Press landing pages
            # Often found in meta tags or specific div classes
            match = re.search(r"creativecommons\.org/licenses/([a-z0-9\-]+)/", html, re.I)
            if match:
                return f"cc-{match.group(1).lower()}"
            
            # Fallback check for "Creative Commons" text + type
            if "Creative Commons Attribution-NonCommercial-NoDerivs" in html:
                return "cc-by-nc-nd"
            if "Creative Commons Attribution" in html:
                if "Non-Commercial" in html or "NonCommercial" in html:
                    return "cc-by-nc"
                return "cc-by"
            
            return None
    except Exception as e:
        print(f"Error fetching {url}: {e}")
        return None

rows = []
modified_count = 0
print("Scraping Cambridge University Press landing pages for CC licenses...")

with open(input_file, "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = list(reader.fieldnames)
    
    for row in reader:
        # Only check Cambridge University Press where license is "No license specified"
        publisher = row.get("publisher", "")
        current_lic = row.get("license", "No license specified")
        
        if "Cambridge University Press" in publisher and (current_lic == "No license specified" or current_lic == ""):
            doi_url = row.get("crossref_url") or row.get("input")
            if doi_url:
                print(f"Checking {doi_url} ...")
                found_lic = get_cc_license(doi_url)
                if found_lic:
                    print(f"  Found: {found_lic}")
                    row["license"] = found_lic
                    modified_count += 1
                time.sleep(1) # Be respectful
        rows.append(row)

with open(output_file, "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(rows)

print(f"Updated {modified_count} licenses from Cambridge landing pages.")

