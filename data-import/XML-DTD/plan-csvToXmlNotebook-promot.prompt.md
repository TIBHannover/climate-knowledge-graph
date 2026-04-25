# Plan: CSV to XML Jupyter Notebook

## TL;DR
Build a Jupyter notebook at `data-import/XML-DTD/csv_to_xml.ipynb` that reads `WGII.csv`, constructs a DTD-compliant XML tree matching the reference `work.xml`, validates with `lxml`, and diffs against `work.xml`. Designed to scale to 7 series / 95 chapters later.

---

## CSV Structure – Key Parsing Rules
The BOOK and CHAPTER columns encode row type:
- `BOOK=0, CHAPTER=0` → series-level metadata (doi, license, tags, date, title, description)
- `BOOK=0, CHAPTER>0` → front_matter chapters (id = str(CHAPTER), sorted by CHAPTER)
- `BOOK>0, CHAPTER=10` → book header row (title only, no wiki/doi)
- `BOOK>0, CHAPTER>10` → chapter row within that book (id = str(CHAPTER - 10), sorted by CHAPTER within BOOK)

Chapter id within a book = CHAPTER - 10 (e.g., CHAPTER=11 → id="1", CHAPTER=28 → id="18").
Book chapters may appear non-contiguously in the CSV (books interleaved) — sort by CHAPTER within each BOOK group.

---

## Steps

### Phase 1: Setup (no dependencies)
1. Create output directory `data-import/XML-DTD/outputs/`
2. Create notebook `data-import/XML-DTD/csv_to_xml.ipynb`

### Phase 2: Notebook cells in order

**Cell 1 – Markdown: Title and Purpose**
Describe the goal, data source, DTD reference, and expected output.

**Cell 2 – Imports**
- `pandas`, `xml.etree.ElementTree`, `lxml.etree`, `pathlib.Path`, `os`, `copy`

**Cell 3 – Markdown: Configuration**

**Cell 4 – Configuration Constants**
```python
INPUT_CSV   = Path('WGII.csv')
DTD_FILE    = Path('work.dtd')
REFERENCE_XML = Path('work.xml')
OUTPUT_DIR  = Path('outputs')
OUTPUT_XML  = OUTPUT_DIR / 'WGII.xml'

PUB_ID          = 'IPCC_AR6'
PUB_TITLE       = 'IPCC Sixth Assessment Report'
PUB_DESCRIPTION = 'IPCC Cycle'

SERIES_ID_MAP = {2: 'IPCC_AR6_WGII'}  # extend for 7 series later
```

**Cell 5 – Markdown: Data Loading**

**Cell 6 – Load & normalise CSV**
- `pd.read_csv()` with explicit column names stripping the type hints
- Display dtypes, shape, `df.head()`

**Cell 7 – Markdown: Structure Explanation**
Explain the BOOK/CHAPTER encoding with a table and example rows.

**Cell 8 – Structure preview**
Show row counts per type (series root, front matter, book headers, chapters).

**Cell 9 – Markdown: Helper Functions**

**Cell 10 – `build_chapter_element(parent, row, ch_id)` function**
Adds `<chapter id="…">` with conditional child elements (wiki, source, pdf, doi, openalex) — only emitted when value is non-empty/non-NaN.

**Cell 11 – `build_xml(df, pub_id, pub_title, pub_desc)` function**
Main converter:
1. Create `<work>` root → `<publication id=pub_id>`
2. For each unique SERIES value (sorted):
   a. Extract series meta row (BOOK=0, CHAPTER=0)
   b. Build `<series id=SERIES_ID_MAP[series_id]>` with title/description/doi/license/tags/date
   c. Build `<front_matter>` from BOOK=0,CHAPTER>0 rows (sorted)
   d. Build `<books>` — for each BOOK>0 group (sorted by BOOK):
      - Extract header row (CHAPTER=10) → `<book id=str(book_id)>` with title
      - Add `<chapters>` from CHAPTER>10 rows (sorted by CHAPTER)
3. Return root element

**Cell 12 – Markdown: Indentation helper**
Note: `ET.indent()` available in Python ≥3.9; fall back to `xml.dom.minidom` for earlier versions.

**Cell 13 – `pretty_print_xml(root)` / `indent_tree(root)` helper**

**Cell 14 – Build and print XML**
Call `build_xml()`, pretty-print to cell output, display first 60 lines.

**Cell 15 – Write output file**
Create `outputs/` dir if missing. Write XML with `<?xml version="1.0" ?>` and `<!DOCTYPE work SYSTEM "work.dtd">` prologue.

**Cell 16 – Markdown: DTD Validation**

**Cell 17 – DTD Validation with lxml**
```python
dtd = lxml.etree.DTD(open(DTD_FILE))
tree = lxml.etree.parse(OUTPUT_XML)
valid = dtd.validate(tree)
# Print errors if any
```
⚠️ Known constraint: work.dtd requires `(doi, isbn?)` for `<book>` elements but current data has no DOI/ISBN for book header rows → DTD validation will flag this. Document and flag the discrepancy; suggest optional DTD amendment.

**Cell 18 – Markdown: Comparison with Reference**

**Cell 19 – XML diff/comparison against work.xml**
- Parse both files with `lxml.etree`
- Compare element trees: tag names, attributes, text content, child counts
- Display a summary: total elements, any mismatches
- Use `lxml.etree.tostring(canonicalize=True)` for canonical comparison

---

## Relevant Files
- `data-import/XML-DTD/WGII.csv` — input data
- `data-import/XML-DTD/work.dtd` — DTD for validation
- `data-import/XML-DTD/work.xml` — reference benchmark
- `data-import/XML-DTD/csv_to_xml.ipynb` — **new notebook to create**
- `data-import/XML-DTD/outputs/WGII.xml` — **new output to generate**

---

## Verification
1. Run all cells — no Python exceptions
2. `outputs/WGII.xml` is created and well-formed
3. DTD validation cell reports discrepancy only for `<book>` doi/isbn constraint (known issue), all other elements pass
4. Comparison cell reports 0 mismatches against `work.xml`
5. Manually open `outputs/WGII.xml` in XML Notepad and verify structure matches reference

---

## Decisions
- Publication wrapper metadata hardcoded as constants (not in CSV)
- Output goes to `data-import/XML-DTD/outputs/`
- Use `lxml` for DTD validation
- Include comparison step against `work.xml`
- SERIES→ID mapping in a dict constant (`SERIES_ID_MAP`) for future extensibility (7 series)

## Further Considerations
1. **DTD `<book>` constraint**: The current DTD requires `(doi, isbn?)` per book, but book header rows in the CSV have none. Recommend amending `work.dtd` to make this optional for books: change `(doi, isbn? | isbn, doi?)` to `(doi, isbn? | isbn, doi?)?` — flag this as a follow-up in the notebook.
2. **Scale to 7 series**: `SERIES_ID_MAP` dict handles future series; the algorithm already groups by SERIES, so only the map needs extending.
3. **Python version**: `ET.indent()` requires Python ≥3.9 — add a version check with fallback to `minidom`.
