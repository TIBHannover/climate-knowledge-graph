
import csv
with open("data/doi/ar6-doi-validation.csv", "r", encoding="utf-8-sig") as f:
    text = f.read()

with open("data/doi/ar6-doi-validation.csv", "w", encoding="utf-8") as f:
    f.write(text)

