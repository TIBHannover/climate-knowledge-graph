import urllib.request
import urllib.parse
import json

ENDPOINT = "https://prod-climatekg.semanticclimate.org/query/proxy/sparql"
BASE = "https://prod-climatekg.semanticclimate.org/entity/Q"

def sparql(q):
    data = urllib.parse.urlencode({"query": q}).encode()
    req = urllib.request.Request(
        ENDPOINT, data=data,
        headers={
            "Accept": "application/sparql-results+json",
            "Content-Type": "application/x-www-form-urlencoded"
        }
    )
    with urllib.request.urlopen(req, timeout=15) as r:
        return json.load(r)

def count(q):
    return sparql(q)["results"]["bindings"][0]["c"]["value"]

filter_q = 'FILTER(STRSTARTS(STR(?item), "' + BASE + '"))'

print("Distinct Q-items in index :", count(
    "SELECT (COUNT(DISTINCT ?item) AS ?c) WHERE { ?item ?p ?o . " + filter_q + " }"
))
print("Items with P20 (wdt https):", count(
    "SELECT (COUNT(DISTINCT ?item) AS ?c) WHERE "
    "{ ?item <https://prod-climatekg.semanticclimate.org/prop/direct/P20> ?v }"
))
print("Items with P20 (p: https)  :", count(
    "SELECT (COUNT(DISTINCT ?item) AS ?c) WHERE "
    "{ ?item <https://prod-climatekg.semanticclimate.org/prop/P20> ?stmt }"
))
