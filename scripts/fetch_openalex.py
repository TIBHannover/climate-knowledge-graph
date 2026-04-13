import csv
import json
import urllib.request
import urllib.error
import time

input_file = "data/doi/ar6-doi.csv"
output_file = "data/doi/ar6-doi-openalex.csv"

def reconstruct_abstract(inverted_index):
    if not inverted_index:
        return ""
    try:
        max_idx = max(idx for indices in inverted_index.values() for idx in indices)
        words = [""] * (max_idx + 1)
        for word, indices in inverted_index.items():
            for idx in indices:
                words[idx] = word
        return " ".join(words).replace('\n', ' ').strip()
    except Exception as e:
        return ""

def fetch_openalex(doi_url):
    # OpenAlex API url
    api_url = f"https://api.openalex.org/works/{doi_url}"
    req = urllib.request.Request(api_url, headers={'User-Agent': 'ckg-bot/1.0 (mailto:info@example.com)'})
    try:
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode('utf-8'))
            oa_id = data.get('id', '')
            inverted_index = data.get('abstract_inverted_index', {})
            description = reconstruct_abstract(inverted_index) if inverted_index else ""
            return oa_id, description
    except urllib.error.HTTPError as e:
        print(f"HTTP Error for {doi_url}: {e.code}")
        return "", ""
    except Exception as e:
        print(f"Error for {doi_url}: {e}")
        return "", ""

def main():
    results = []
    with open(input_file, encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        for row in reader:
            if not row: continue
            doi_url = row[0].strip()
            if not doi_url: continue
            
            print(f"Fetching {doi_url} ...")
            oa_id, desc = fetch_openalex(doi_url)
            results.append({
                'DOI': doi_url,
                'OpenAlex_ID': oa_id,
                'Description': desc
            })
            time.sleep(0.1) # polite delay
            
    with open(output_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['DOI', 'OpenAlex_ID', 'Description'])
        writer.writeheader()
        writer.writerows(results)
    print(f"Finished. Wrote {len(results)} rows to {output_file}")

if __name__ == '__main__':
    main()
