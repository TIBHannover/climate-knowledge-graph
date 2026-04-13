"""
Query Wikidata for country data using ISO 3166-1 alpha-2 codes.
Fetches QID, label, description, official name (P1448), short name (P1813),
ISO alpha-2 (P297), alpha-3 (P298), and numeric (P299) codes.

Output: ipcc-ar6-countries.csv
"""

import csv
import json
import urllib.request
import urllib.parse


def get_countries_from_csv():
    """Collect unique ISO codes and their full names from the authors CSV."""
    countries = {}
    with open("ipcc-ar6-authors-v2.csv", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for r in reader:
            cor = r["Country of Residence"].strip()
            cor_code = r["Country of Residence Code"].strip()
            if cor and cor_code:
                countries[cor_code] = cor
            cit = r["Citizenship"].strip()
            cit_code = r["Citizenship Code"].strip()
            if cit and cit_code:
                countries[cit_code] = cit
    return countries


def query_wikidata(iso_codes):
    """Query Wikidata SPARQL for countries by ISO 3166-1 alpha-2 code."""
    values = " ".join(f'"{code}"' for code in iso_codes)
    sparql = f"""
    SELECT ?item ?itemLabel ?itemDescription ?isoAlpha2 ?isoAlpha3 ?isoNumeric
           ?officialName ?shortName
    WHERE {{
      VALUES ?isoAlpha2 {{ {values} }}
      ?item wdt:P297 ?isoAlpha2 .
      OPTIONAL {{ ?item wdt:P298 ?isoAlpha3 . }}
      OPTIONAL {{ ?item wdt:P299 ?isoNumeric . }}
      OPTIONAL {{ ?item wdt:P1448 ?officialName . FILTER(LANG(?officialName) = "en") }}
      OPTIONAL {{ ?item wdt:P1813 ?shortName . FILTER(LANG(?shortName) = "en") }}
      SERVICE wikibase:label {{ bd:serviceParam wikibase:language "en". }}
    }}
    ORDER BY ?isoAlpha2
    """
    url = "https://query.wikidata.org/sparql"
    params = urllib.parse.urlencode({"query": sparql, "format": "json"})
    req = urllib.request.Request(
        f"{url}?{params}",
        headers={"User-Agent": "IPCC-AR6-ClimateKG/1.0 (research project)"},
    )
    with urllib.request.urlopen(req, timeout=60) as resp:
        data = json.loads(resp.read().decode("utf-8"))
    return data["results"]["bindings"]


if __name__ == "__main__":
    countries = get_countries_from_csv()
    iso_codes = sorted(countries.keys())
    print(f"Querying Wikidata for {len(iso_codes)} countries...")

    results = query_wikidata(iso_codes)
    print(f"Received {len(results)} results from Wikidata.")

    # Build lookup - take first result per code (some may have multiple official names)
    wd_lookup = {}
    for r in results:
        code = r["isoAlpha2"]["value"]
        if code in wd_lookup:
            continue
        qid = r["item"]["value"].rsplit("/", 1)[-1]
        wd_lookup[code] = {
            "qid": qid,
            "label": r.get("itemLabel", {}).get("value", ""),
            "description": r.get("itemDescription", {}).get("value", ""),
            "alpha3": r.get("isoAlpha3", {}).get("value", ""),
            "numeric": r.get("isoNumeric", {}).get("value", ""),
            "official_name": r.get("officialName", {}).get("value", ""),
            "short_name": r.get("shortName", {}).get("value", ""),
        }

    # Write output CSV with Wikidata-style column names
    fieldnames = [
        "QID",
        "Label",
        "Description",
        "Country Name (CSV)",
        "Official Name (P1448)",
        "Short Name (P1813)",
        "ISO 3166-1 alpha-2 (P297)",
        "ISO 3166-1 alpha-3 (P298)",
        "ISO 3166-1 numeric (P299)",
    ]
    with open("ipcc-ar6-countries.csv", "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for code in iso_codes:
            wd = wd_lookup.get(code, {})
            writer.writerow({
                "QID": wd.get("qid", ""),
                "Label": wd.get("label", ""),
                "Description": wd.get("description", ""),
                "Country Name (CSV)": countries[code],
                "Official Name (P1448)": wd.get("official_name", ""),
                "Short Name (P1813)": wd.get("short_name", ""),
                "ISO 3166-1 alpha-2 (P297)": code,
                "ISO 3166-1 alpha-3 (P298)": wd.get("alpha3", ""),
                "ISO 3166-1 numeric (P299)": wd.get("numeric", ""),
            })

    # Report any missing
    missing = [c for c in iso_codes if c not in wd_lookup]
    if missing:
        print(f"WARNING - No Wikidata match for: {missing}")
    else:
        print("All countries matched in Wikidata.")
    print(f"Output: ipcc-ar6-countries.csv ({len(iso_codes)} rows)")
