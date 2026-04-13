
import csv

lines = []
with open("data/doi/ar6-doi-validation.csv", "r", encoding="utf-8") as f:
    for line in f:
        lines.append(line)

if lines:
    header = lines[0]
    if "\"﻿\"\"input\"\"\"" in header or "﻿" in header:
        lines[0] = "input,doi,status,type,title,publisher,published,crossref_url,openalex_id,description\n"

with open("data/doi/ar6-doi-validation.csv", "w", encoding="utf-8") as f:
    f.writelines(lines)

