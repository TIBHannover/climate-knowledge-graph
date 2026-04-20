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

---

## XML Tooling

### XSLT Preview for XML Notepad

The file `data-import/report.xml` includes two processing instructions that enable in-tool HTML preview in [XML Notepad](https://microsoft.github.io/XmlNotepad/):

```xml
<?xml version="1.0" ?>
<?xml-stylesheet type="text/xsl" href="report.xsl" ?>
<?xsl-output default="report_output" ?>
```

| Instruction | Purpose |
|---|---|
| `xml-stylesheet` | Links the XML document to its XSLT stylesheet. XML Notepad reads this and automatically applies the transform when the **XSL Output** tab is selected. |
| `xsl-output` | Sets the default output filename (`report_output`) used when saving the transformed result from XML Notepad. |

#### Stylesheet: `data-import/report.xsl`

An XSLT 1.0 stylesheet that transforms `report.xml` into a styled HTML page. The transform renders:

- **Series metadata** – title, DOI (linked to `https://doi.org/`), license, date, and semicolon-delimited tags as pill badges.
- **Front Matter** – table of summary/policy documents with DOI, OpenAlex, Wiki and PDF links.
- **Books** – one table per book section (e.g. *Chapters*, *Cross-Chapter Papers*), with chapter number, label, DOI, OpenAlex, and Web/Wiki/PDF links.

A reference copy of the stylesheet is stored at `design_pattern/report-test/report.xsl`.

#### How to use in XML Notepad

1. Open `data-import/report.xml` in XML Notepad.
2. Select the **XSL Output** tab — the stylesheet is applied automatically via the `xml-stylesheet` processing instruction.
3. To save the rendered HTML, use **File › Save As** from the XSL Output tab; the default filename is `report_output` as set by the `xsl-output` instruction.

#### Adding XSLT preview to a new XML file

Add these two lines immediately after the `<?xml version="1.0" ?>` declaration, adjusting `href` to point to your stylesheet:

```xml
<?xml-stylesheet type="text/xsl" href="your-stylesheet.xsl" ?>
<?xsl-output default="your_output_filename" ?>
```

XML Notepad will detect the `xml-stylesheet` instruction and apply the transform without any further configuration.
