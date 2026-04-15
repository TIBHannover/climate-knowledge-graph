# Glossary Analysis Script Documentation

This documentation provides details about the `analyse_glossary_terms.py` script located in the `scripts/` directory.

## Purpose

The `analyse_glossary_terms.py` script is designed to automatically identify and associate IPCC glossary terms with various report articles (chapters, summaries, etc.) based on their text content extracted from MediaWiki XML exports.

## How it Works

1. **Load Glossary**: Reads `data/glossary/Glossary.csv` to extract valid IPCC terms.
2. **Extract Wiki Text**: Parses the large MediaWiki XML file (`mediawiki-text/KEWL-20260322093018.xml`) to retrieve the full wikitext of each report section.
3. **Keyword Matching**: Searches for every glossary term within the content of each article.
4. **Optimization Strategy**: To ensure consistency across the dataset, the script:
   - Identifies all matching terms for an article.
   - Calculates the frequency of each term across the entire report collection.
   - Selects the top 3 most frequently occurring terms for each article to promote a "minimal set" of terms (reusing common terms where appropriate).
5. **Fallback Mechanism**: For articles not found in the XML, the script searches the `Description` and `Title` columns of the input CSV.
6. **Update Spreadsheet**: Adds a `Glossary Terms` column to `data/article data/article-data.csv` containing the selected terms separated by semicolons.

## Requirements

- Python 3.x
- `pandas` library

## Usage

Run the script from the root of the repository:

```bash
python scripts/analyse_glossary_terms.py
```

## Input Files

- `data/glossary/Glossary.csv`: Source of terms.
- `mediawiki-text/KEWL-20260322093018.xml`: Source of article text.
- `data/article data/article-data.csv`: Target file to update.

## Output

- An updated `data/article data/article-data.csv` with the `Glossary Terms` column populated.
