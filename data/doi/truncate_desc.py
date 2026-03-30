
import csv
import re

def summarize(text, max_len=250):
    if len(text) <= max_len:
        return text
    
    # Try to cut at nearest sentence boundary under max_len
    sentences = re.split(r"(?<=[.!?])\s+", text)
    summary = ""
    for s in sentences:
        if len(summary) + len(s) + 1 <= max_len:
            summary += (s + " ")
        else:
            break
            
    summary = summary.strip()
    
    # If even the first sentence is too long, truncate it
    if not summary:
        words = text.split(" ")
        temp = ""
        for w in words:
            if len(temp) + len(w) + 1 <= (max_len - 3):
                temp += (w + " ")
            else:
                break
        summary = temp.strip() + "..."
        
    return summary

rows = []
modified_count = 0
with open("data/doi/ar6-doi-validation.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = list(reader.fieldnames)
    for row in reader:
        desc = row.get("description", "")
        if len(desc) > 250:
            row["description"] = summarize(desc, 250)
            modified_count += 1
        rows.append(row)

with open("data/doi/ar6-doi-validation.csv", "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(rows)

print(f"Truncated/Summarized {modified_count} descriptions.")

