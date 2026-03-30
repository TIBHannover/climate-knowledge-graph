
import csv

with open("data/doi/ar6-doi-validation.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    long_items = []
    for row in reader:
        desc = row.get("description", "")
        if len(desc) > 250:
            long_items.append((row["doi"], row["title"], len(desc)))
    
    print(f"Total over 250 chars: {len(long_items)}")
    for i, item in enumerate(long_items):
        print(f"{i+1}. {item[1]} ({item[2]} chars)")

