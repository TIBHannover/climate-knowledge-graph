# Climate Knowledge Graph Scripts Overview

This directory contains utility scripts for processing IPCC AR6 data and population of the Knowledge Graph.

## List of Scripts

- `add_iso_codes.py`: Adds ISO codes to country data.
- `add_licenses_to_csv.py`: Assigns license information to DOI records.
- `add_short_id.py`: Generates shorthand identifiers for articles.
- `analyse_glossary_terms.py`: Uses report text and global frequency to assign glossary terms to articles.
- `analyse_wiki_links.py`: Analyzes internal linkage within the MediaWiki export.
- `check_licenses.py`: Verifies license statuses for publications.
- `clean_bom.py`: Strips Byte Order Marks (BOM) from data files.
- `clean_chars.py`: Regularizes character encoding issues.
- `dump_missing.py`: Identifies and logs missing data points for review.
- `fetch_dates.py`: Retrieves publication dates for references.
- `fetch_openalex.py`: Syncs metadata from OpenAlex for DOI records.
- `fetch_wikidata_countries.py`: Pulls country metadata from Wikidata.
- `fix_header.py`: Standardizes CSV headers across different datasets.
- `list_long.py`: Identifies entries with long descriptions needing truncation.
- `merge_desc_py.py`: Merges updated descriptions into main dataset.
- `merge_py.py`: General purpose data merging utility.
- `normalise_countries.py`: Standardizes country names across datasets.
- `normalise_names.py`: Standardizes author names (e.g., formatting).
- `normalise_roles_gender.py`: Maps roles and gender data for authors.
- `replace_summaries.py`: Updates short summaries for report sections.
- `revert_descriptions.py`: Reverts description changes if needed.
- `scrape_cambridge.py`: Extracts metadata from Cambridge University Press.
- `truncate_desc.py`: Shortens long descriptions for database storage.
- `update_descriptions.py`: Batch updates descriptions across the article set.

## Running Scripts

Most scripts are designed to be run from the root of the project to maintain proper relative paths to the `data/` directory.

Example:
```bash
python scripts/analyse_glossary_terms.py
```
