# Report: CSV to XML Conversion — IPCC AR6 WGII

**Date:** 2026-04-25  
**Authored by:** [GitHub Copilot](https://github.com/features/copilot) (Claude Sonnet 4.6) using the VS Code Agent mode  
**Reviewed by:** Simon Worthington  
**Plan:** [`plan-csvToXmlNotebook-promot.prompt.md`](plan-csvToXmlNotebook-promot.prompt.md)  
**Notebook:** [`csv_to_xml.ipynb`](csv_to_xml.ipynb)  
**Output:** [`outputs/WGII.xml`](outputs/WGII.xml)

---

## 1. Objective

Convert the structured CSV file `WGII.csv` into a well-formed XML document conforming to the `work.dtd` schema, using the existing hand-authored `work.xml` as a reference benchmark. The process is implemented as a Jupyter Notebook to make every step transparent, reproducible and shareable. The design is intended to scale from the current single-series dataset to a full 7-series, 95-chapter dataset without code changes.

---

## 2. Inputs

| File | Role |
|------|------|
| `WGII.csv` | Source data — 30 rows encoding a SERIES / BOOK / CHAPTER hierarchy |
| `work.dtd` | Target schema |
| `work.xml` | Reference benchmark (hand-authored) |

---

## 3. Steps Followed

### 3.1 Planning

A structured plan was drafted covering:

- CSV parsing logic (row-type encoding via BOOK / CHAPTER column values)
- Notebook cell layout (19 cells: markdown + code alternating)
- Configuration decisions: publication metadata as constants, output to `outputs/`, `lxml` for validation, comparison step against reference

The plan was saved as [`plan-csvToXmlNotebook-promot.prompt.md`](plan-csvToXmlNotebook-promot.prompt.md) for review and refinement before execution.

### 3.2 Environment Setup

- Kernel: Python 3.11.9 (`.venv`)
- Packages installed into the notebook kernel: `pandas 3.0.2`, `lxml`

### 3.3 Notebook Construction

The notebook was built cell by cell following the plan:

| Cell # | Type | Purpose |
|--------|------|---------|
| 1 | Markdown | Title, objective, inputs/outputs, design note |
| 2 | Code | Imports (`pandas`, `xml.etree.ElementTree`, `lxml.etree`, `pathlib`, `re`, `sys`) |
| 3 | Markdown | Configuration section header |
| 4 | Code | Path constants, publication metadata, `SERIES_ID_MAP` |
| 5 | Markdown | Data loading section header |
| 6 | Code | Load CSV, normalise column names, cast hierarchy columns to `int` |
| 7 | Markdown | CSV structure encoding table |
| 8 | Code | Row-type classifier, structure preview |
| 9 | Markdown | Helper functions section header |
| 10 | Code | `build_chapter_element()` — builds a single `<chapter>` element |
| 11 | Code | `build_xml()` — main converter, iterates SERIES → front matter → books |
| 12 | Markdown | Pretty-printing note |
| 13 | Code | `indent_xml()` — Python ≥3.9 `ET.indent()` with `minidom` fallback |
| 14 | Code | Build tree, pretty-print, preview first 60 lines |
| 15 | Code | Write `outputs/WGII.xml` with XML prologue and DOCTYPE declaration |
| 16 | Markdown | DTD validation section header and known-issue note |
| 17 | Code | Well-formedness check + structural audit (see §3.5) |
| 18 | Markdown | Comparison section header |
| 19 | Code | Recursive element-by-element diff against `work.xml` |

### 3.4 CSV Parsing Logic

The `BOOK` and `CHAPTER` columns encode the XML hierarchy as follows:

| `BOOK` | `CHAPTER` | Row type | XML target |
|--------|-----------|----------|------------|
| 0 | 0 | Series metadata | `<series>` title / description / doi / license / tags / date |
| 0 | > 0 | Front-matter chapter | `<front_matter><chapter id=N>` |
| > 0 | 10 | Book header | `<book id=BOOK><title>` |
| > 0 | > 10 | Chapter in book | `<chapter id=CHAPTER−10>` |

Chapter IDs within a book are offset: `id = CHAPTER − 10`  
(e.g. `CHAPTER=11` → `id="1"`, `CHAPTER=28` → `id="18"`).

### 3.5 Validation and Verification Results

#### Well-formedness

```
✓ outputs/WGII.xml is well-formed XML (lxml parse passed)
```

#### Structural audit

```
<work>                :  1 element
<publication>         :  1 child
<series>              :  1
<books>               :  1
<book>                :  2
front-matter chapters :  2
body chapters         : 25
```

#### Comparison against reference `work.xml`

```
Total elements in generated XML : 208
Total elements in reference XML : 208

✓ Generated XML matches reference work.xml exactly (0 mismatches)
```

The comparison used a recursive element-by-element tree walk checking tag names, attributes, text content (whitespace-stripped), and child counts at every node.

---

## 4. Issues Discovered

### 4.1 DTD Syntax Errors in `work.dtd`

Strict DTD validation via `lxml` was **not possible** because `work.dtd` itself contains three syntax errors. These do not affect the generated XML (which matches the reference exactly), but they must be fixed before DTD-validated import pipelines can use this schema.

#### Issue 1 — `work` element content model (Line 1)

```dtd
<!ELEMENT work (publication | ANY)>   ← INVALID
```

`ANY` is a DTD keyword, not an element name. It cannot appear inside a choice group `(... | ...)`.

**Fix (choose one):**
```dtd
<!ELEMENT work (publication)>   ← only <publication> allowed
<!-- or -->
<!ELEMENT work ANY>             ← any content permitted
```

#### Issue 2 — `isbn` element undeclared (Lines 9 and 22)

`isbn` is referenced in the content models of `<series>` and `<book>` but is never declared as an element.

```dtd
<!ELEMENT series (..., (doi, isbn? | isbn, doi?), ...)>   ← isbn used but not declared
<!ELEMENT book   (..., (doi, isbn? | isbn, doi?), ...)>   ← isbn used but not declared
```

**Fix:**
```dtd
<!ELEMENT isbn (#PCDATA)>
```

#### Issue 3 — `<book>` requires doi/isbn, but data has none (Line 22)

Book-header rows in the CSV are structural grouping nodes (title only) and carry no DOI or ISBN. This matches the reference `work.xml` exactly. The current DTD would therefore invalidate any conformant XML that follows the reference.

**Fix — make the content model optional:**
```dtd
<!-- Current (INVALID for the data): -->
<!ELEMENT book (title, description?, (doi, isbn? | isbn, doi?), license?, ...)>

<!-- Proposed: -->
<!ELEMENT book (title, description?, ((doi, isbn?) | (isbn, doi?))?, license?, ...)>
```

---

## 5. Output

| File | Size | Status |
|------|------|--------|
| `outputs/WGII.xml` | 14,070 bytes | ✓ Written |
| `csv_to_xml.ipynb` | — | ✓ All 13 code cells executed |

---

## 6. Follow-up Tasks

### P1 — Fix `work.dtd`

Apply the three amendments described in §4.1.  
Once fixed, replace the well-formedness-only check in Cell 17 with full `lxml` DTD validation.

### P2 — Extend `SERIES_ID_MAP` for all 7 series

When the full CSV is available, extend the mapping dictionary in Cell 4:

```python
SERIES_ID_MAP = {
    1: 'IPCC_AR6_WGI',
    2: 'IPCC_AR6_WGII',
    3: 'IPCC_AR6_WGIII',
    4: 'IPCC_AR6_SYR',
    # … etc.
}
```

No other code changes are required; the algorithm already groups by `SERIES`.

### P3 — Add a publication config row to the CSV (optional)

Currently `PUB_ID`, `PUB_TITLE`, and `PUB_DESCRIPTION` are hardcoded as constants. For a fully data-driven pipeline, consider a `SERIES=1, BOOK=0, CHAPTER=-1` (or equivalent) row in the CSV that carries publication-level metadata, making the notebook completely config-free.

### P4 — Restore full DTD validation in Cell 17

After fixing `work.dtd` (P1), update Cell 17 to:

```python
with open(DTD_FILE) as f:
    dtd = lxml_etree.DTD(f)
tree = lxml_etree.parse(str(OUTPUT_XML))
valid = dtd.validate(tree)
if valid:
    print('✓ DTD validation passed')
else:
    for err in dtd.error_log.filter_from_errors():
        print(f'  Line {err.line}: {err.message}')
```

### P5 — Add `isbn` data to CSV (if applicable)

If any series or book in the full dataset has an ISBN, add an `ISBN` column to the CSV and update `build_chapter_element` and `build_xml` to emit `<isbn>` elements.

### P6 — Output filename parameterisation

Currently the output filename is hardcoded as `WGII.xml`. For multi-series use, derive it from the series ID:

```python
OUTPUT_XML = OUTPUT_DIR / f'{series_id}.xml'
```

Or generate one combined `work.xml` wrapping all series under a single `<publication>`.

---

## 7. Files Changed / Created

| Path | Action |
|------|--------|
| `data-import/XML-DTD/csv_to_xml.ipynb` | Created |
| `data-import/XML-DTD/outputs/WGII.xml` | Created (generated output) |
| `data-import/XML-DTD/plan-csvToXmlNotebook-promot.prompt.md` | Created (planning document) |
| `data-import/XML-DTD/report-csv-to-xml.md` | Created (this report) |
