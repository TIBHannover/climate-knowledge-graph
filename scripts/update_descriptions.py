import csv
import re
import xml.etree.ElementTree as ET

csv_path = r"data/doi/ar6-doi-validation.csv"
xml_path = r"mediawiki-text/KEWL-20260322093018.xml"

# Mapping logic from DOI/Title to XML Page Title
def get_xml_title(row):
    doi = row["doi"]
    title = row["title"].lower()
    
    # SR15 (10.1017/9781009157940)
    if "9781009157940" in doi:
        if ".001" in doi: return "IPCC:Sr15:Chapter:Spm"
        if ".002" in doi: return "IPCC:Sr15:Resources:Technicalsummary"
        match = re.search(r"9781009157940\.00(\d)", doi)
        if match: return f"IPCC:Sr15:Chapter:Chapter-{int(match.group(1))-2}"

    # SRCCL (10.1017/9781009157988)
    if "9781009157988" in doi:
        if ".001" in doi: return "IPCC:Srccl:Chapter:Summary-for-policymakers"
        if ".002" in doi: return "IPCC:Srccl:Chapter:Technical-summary"
        match = re.search(r"9781009157988\.00(\d)", doi)
        if match: return f"IPCC:Srccl:Chapter:Chapter-{int(match.group(1))-2}"

    # SROCC (10.1017/9781009157964)
    if "9781009157964" in doi:
        if ".001" in doi: return "IPCC:Srocc:Chapter:Summary-for-policymakers"
        if ".002" in doi: return "IPCC:Srocc:Chapter:Technical-summary"
        if ".009" in doi: return "IPCC:Srocc:Chapter:Cross-chapter-box-9-integrative-cross-chapter-box-on-low-lying-islands-and-coasts"
        match = re.search(r"9781009157964\.00(\d)", doi)
        if match: return f"IPCC:Srocc:Chapter:Chapter-{int(match.group(1))-2}"

    # WG1 (10.1017/9781009157896)
    if "9781009157896" in doi:
        if ".001" in doi: return "IPCC:Wg1:Chapter:Summary-for-policymakers"
        if ".002" in doi: return "IPCC:Wg1:Chapter:Technical-summary"
        if ".021" in doi: return "IPCC:Wg1:Chapter:Atlas"
        match = re.search(r"9781009157896\.0(\d+)", doi)
        if match: 
            num = int(match.group(1))
            if num >= 3: return f"IPCC:Wg1:Chapter:Chapter-{num-2}"

    # WG2 (10.1017/9781009325844)
    if "9781009325844" in doi:
        if ".001" in doi: return "IPCC:Wg2:Chapter:Summary-for-policymakers"
        if ".002" in doi: return "IPCC:Wg2:Chapter:Technical-summary"
        match = re.search(r"9781009325844\.0(\d+)", doi)
        if match:
            num = int(match.group(1))
            if num >= 3 and num <= 20: return f"IPCC:Wg2:Chapter:Chapter-{num-2}"
            if num >= 21: # Need to check CCP mappings if num corresponds
                pass 

    # WG3 (10.1017/9781009157926)
    if "9781009157926" in doi:
        if ".001" in doi: return "IPCC:Wg3:Chapter:Summary-for-policymakers"
        if ".002" in doi: return "IPCC:Wg3:Chapter:Technical-summary"
        match = re.search(r"9781009157926\.0(\d+)", doi)
        if match:
            num = int(match.group(1))
            if num >= 3: return f"IPCC:Wg3:Chapter:Chapter-{num-2}"

    # SYR (10.59327/IPCC/AR6-9789291691647)
    if "AR6-9789291691647" in doi:
        if ".001" in doi: return "IPCC:Syr"
        return "IPCC:Syr:Longer-report"

    return None

def extract_summary(text):
    if not text: return ""
    
    # Pre-processing: Clean up common wiki/special patterns
    text = re.sub(r"<[^>]+>", "", text) # Remove HTML tags
    text = re.sub(r"\[\[[^\]]+\]\]", "", text) # Remove Wiki links
    text = re.sub(r"'''|''", "", text) # Remove wiki bold/italic
    text = re.sub(r"&nbsp;", " ", text)
    text = re.sub(r"&[a-z0-9#]+;", " ", text, flags=re.IGNORECASE) # Other HTML entities

    # Filter out common boilerplate like lists and headers from search
    # Find ES Executive Summary
    es_match = re.search(r"==\s*ES\s*Executive\s*Summary\s*==\s*(.*?)(?===|$)", text, re.DOTALL | re.IGNORECASE)
    if es_match:
        content = es_match.group(1).strip()
    else:
        # Fallback: find the first block that looks like a paragraph (no wiki headers or bullet points)
        # We also want to skip very short fragments
        blocks = text.split("\n\n")
        content = ""
        for b in blocks:
            b_clean = b.strip()
            # If it's not a header (starts with =) and not a list (starts with *) and isn't too short
            if b_clean and not b_clean.startswith("=") and not b_clean.startswith("*") and len(b_clean) > 50:
                content = b_clean
                break
        
        if not content:
            content = text.strip()

    # Final cleanup of the content (remove any remaining headers/newlines)
    content = re.sub(r"={1,6}.*?={1,6}", "", content)
    content = re.sub(r"\n+", " ", content).strip()
    
    # Split into sentences and take up to 250 chars
    sentences = re.split(r"(?<=[.!?])\s+", content)
    summary = ""
    for s in sentences:
        s = s.strip()
        if not s: continue
        if len(summary) + len(s) + 1 <= 250:
            summary += s + " "
        else:
            if not summary: summary = s[:247] + "..."
            break
    
    return summary.strip()

print("Parsing XML...")
tree = ET.parse(xml_path)
root = tree.getroot()
ns = {"mw": "http://www.mediawiki.org/xml/export-0.11/"}

pages = {}
for page in root.findall("mw:page", ns):
    title_elem = page.find("mw:title", ns)
    if title_elem is not None:
        title = title_elem.text
        text_elem = page.find("mw:revision/mw:text", ns)
        if text_elem is not None:
            pages[title] = text_elem.text

print("Reading CSV and updating descriptions...")
updated_rows = []
with open(csv_path, "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fieldnames = reader.fieldnames
    for row in reader:
        xml_title = get_xml_title(row)
        if xml_title and xml_title in pages:
            new_desc = extract_summary(pages[xml_title])
            if new_desc:
                row["description"] = new_desc
        updated_rows.append(row)

with open(csv_path, "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(updated_rows)

print("Done.")
