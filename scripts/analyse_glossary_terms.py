import pandas as pd
import xml.etree.ElementTree as ET
import re
from collections import Counter
import os

def load_glossary(file_path):
    df = pd.read_csv(file_path)
    # Using 'Term' column for matching.
    # We might want to handle case-insensitivity and pluralization if possible.
    terms = df['Term'].dropna().unique().tolist()
    return terms

def extract_wiki_content(xml_path):
    # Since the file is large, we should parse it iteratively if possible, 
    # but for a script we can try to find relevant pages.
    # The user mentioned "IPCC AR6 report text divisions".
    # article-data.csv has 'Wiki Url' which seems to point to these pages.
    
    pages = {}
    context = ET.iterparse(xml_path, events=('end',))
    for event, elem in context:
        if elem.tag.endswith('page'):
            title_elem = elem.find('{http://www.mediawiki.org/xml/export-0.11/}title')
            text_elem = elem.find('.//{http://www.mediawiki.org/xml/export-0.11/}text')
            if title_elem is not None and text_elem is not None:
                pages[title_elem.text] = text_elem.text
            elem.clear()
    return pages

def get_wiki_title_from_url(url):
    if pd.isna(url) or not isinstance(url, str):
        return None
    # Example: https://test.kewl.org/wiki/IPCC:Sr15:Chapter:Chapter-1
    parts = url.split('/wiki/')
    if len(parts) > 1:
        return parts[1].replace('_', ' ')
    return None

def main():
    glossary_path = r'c:\git\climate-knowledge-graph\data\glossary\Glossary.csv'
    xml_path = r'c:\git\climate-knowledge-graph\mediawiki-text\KEWL-20260322093018.xml'
    article_data_path = r'c:\git\climate-knowledge-graph\data\article data\article-data.csv'
    
    print("Loading glossary...")
    terms = load_glossary(glossary_path)
    # Sort terms by length descending to match longer terms first (e.g. "1.5°C pathway" before "1.5°C")
    terms.sort(key=len, reverse=True)
    
    print("Loading article data...")
    article_df = pd.read_csv(article_data_path)
    
    print("Extracting wiki content...")
    wiki_pages = extract_wiki_content(xml_path)
    
    results = []
    all_found_terms = []
    
    for idx, row in article_df.iterrows():
        wiki_url = row.get('Wiki Url - DO NOT IMPORT')
        wiki_title = get_wiki_title_from_url(wiki_url)
        
        found_for_page = []
        if wiki_title and wiki_title in wiki_pages:
            content = wiki_pages[wiki_title].lower()
            for term in terms:
                # Simple check for term in content
                if term.lower() in content:
                    found_for_page.append(term)
        
        # If no wiki title matches, try searching the "Description - DO NOT USE" column
        # which often contains the abstract.
        if not found_for_page:
            desc = str(row.get('Description - DO NOT USE', ''))
            content = desc.lower()
            for term in terms:
                if term.lower() in content:
                    found_for_page.append(term)
        
        # If still nothing, try the first column "Parts - DO NOT IMPORT" or "Title"
        if not found_for_page:
            title = str(row.get('"""Title"" (Data type: Monolingual text)"', ''))
            content = title.lower()
            for term in terms:
                if term.lower() in content:
                    found_for_page.append(term)

        results.append(found_for_page)
        all_found_terms.extend(found_for_page)

    # To minimize total glossary terms while picking 3 per article:
    # 1. Count frequency of all terms found
    term_counts = Counter(all_found_terms)
    
    final_glossary_col = []
    for found_list in results:
        # Sort found terms by their total frequency in the whole dataset (descending)
        # and then pick top 3. This helps reuse terms across articles.
        sorted_terms = sorted(found_list, key=lambda x: term_counts[x], reverse=True)
        # Select up to 3
        selected = sorted_terms[:3]
        final_glossary_col.append("; ".join(selected))
    
    article_df['Glossary Terms'] = final_glossary_col
    
    # Save back
    article_df.to_csv(article_data_path, index=False)
    print(f"Updated {article_data_path} with Glossary Terms.")

if __name__ == "__main__":
    main()
