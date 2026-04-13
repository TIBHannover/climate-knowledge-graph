"""
Add ISO 3166-1 alpha-2 country code columns to the IPCC AR6 authors CSV.

Adds:
    - Country of Residence Code
    - Citizenship Code

Input/Output: ipcc-ar6-authors-v2.csv (in-place update)
"""

import csv

ISO_MAP = {
    "Algeria": "DZ",
    "Argentina": "AR",
    "Australia": "AU",
    "Austria": "AT",
    "Bahamas": "BS",
    "Bangladesh": "BD",
    "Belgium": "BE",
    "Benin": "BJ",
    "Botswana": "BW",
    "Brazil": "BR",
    "Cameroon": "CM",
    "Canada": "CA",
    "Chile": "CL",
    "China": "CN",
    "Colombia": "CO",
    "Cook Islands": "CK",
    "Costa Rica": "CR",
    "Cote d'Ivoire": "CI",
    "Cuba": "CU",
    "Czech Republic": "CZ",
    "Democratic Republic of the Congo": "CD",
    "Denmark": "DK",
    "Dominican Republic": "DO",
    "Ecuador": "EC",
    "Egypt": "EG",
    "Eritrea": "ER",
    "Ethiopia": "ET",
    "Fiji": "FJ",
    "Finland": "FI",
    "France": "FR",
    "Gambia": "GM",
    "Germany": "DE",
    "Ghana": "GH",
    "Greece": "GR",
    "Guatemala": "GT",
    "Haiti": "HT",
    "Hungary": "HU",
    "Iceland": "IS",
    "India": "IN",
    "Indonesia": "ID",
    "Iran": "IR",
    "Ireland": "IE",
    "Israel": "IL",
    "Italy": "IT",
    "Jamaica": "JM",
    "Japan": "JP",
    "Kenya": "KE",
    "Latvia": "LV",
    "Luxembourg": "LU",
    "Malaysia": "MY",
    "Maldives": "MV",
    "Mali": "ML",
    "Mauritania": "MR",
    "Mauritius": "MU",
    "Mexico": "MX",
    "Micronesia, Federated States of": "FM",
    "Monaco": "MC",
    "Morocco": "MA",
    "Mozambique": "MZ",
    "Nepal": "NP",
    "Netherlands": "NL",
    "New Zealand": "NZ",
    "Niger": "NE",
    "Nigeria": "NG",
    "Norway": "NO",
    "Pakistan": "PK",
    "Palau": "PW",
    "Peru": "PE",
    "Philippines": "PH",
    "Poland": "PL",
    "Portugal": "PT",
    "Qatar": "QA",
    "Republic of Korea": "KR",
    "Russian Federation": "RU",
    "Rwanda": "RW",
    "Saudi Arabia": "SA",
    "Senegal": "SN",
    "Serbia": "RS",
    "Singapore": "SG",
    "Solomon Islands": "SB",
    "South Africa": "ZA",
    "Spain": "ES",
    "Sri Lanka": "LK",
    "Sudan": "SD",
    "Sweden": "SE",
    "Switzerland": "CH",
    "Thailand": "TH",
    "Tonga": "TO",
    "Trinidad and Tobago": "TT",
    "T\u00fcrkiye": "TR",
    "Uganda": "UG",
    "Ukraine": "UA",
    "United Arab Emirates": "AE",
    "United Kingdom (of Great Britain and Northern Ireland)": "GB",
    "United Republic of Tanzania": "TZ",
    "United States of America": "US",
    "Uruguay": "UY",
    "Uzbekistan": "UZ",
    "Venezuela": "VE",
    "Vietnam": "VN",
    "Zambia": "ZM",
    "Zimbabwe": "ZW",
}

INPUT_OUTPUT_FILE = "ipcc-ar6-authors-v2.csv"

if __name__ == "__main__":
    with open(INPUT_OUTPUT_FILE, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = list(reader.fieldnames)
        rows = list(reader)

    fieldnames.append("Country of Residence Code")
    fieldnames.append("Citizenship Code")

    unmapped = set()
    for r in rows:
        cor = r["Country of Residence"].strip()
        cit = r["Citizenship"].strip()
        r["Country of Residence Code"] = ISO_MAP.get(cor, "")
        r["Citizenship Code"] = ISO_MAP.get(cit, "")
        if cor and not r["Country of Residence Code"]:
            unmapped.add(cor)
        if cit and not r["Citizenship Code"]:
            unmapped.add(cit)

    with open(INPUT_OUTPUT_FILE, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    if unmapped:
        print(f"WARNING - unmapped countries: {unmapped}")
    else:
        print("All countries mapped successfully.")
    print(f"Columns: {fieldnames}")
    print(f"Rows: {len(rows)}")
