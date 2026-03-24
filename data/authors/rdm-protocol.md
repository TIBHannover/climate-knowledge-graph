# Research Data Management Protocol

## Dataset: IPCC AR6 Authors

**Date:** 2026-03-24  
**Performed by:** GitHub Copilot (Claude Opus 4.6) in VS Code  
**Repository:** TIBHannover/climate-knowledge-graph (branch: main)

---

## 1. Source Data

| Item | Detail |
|------|--------|
| File | `ipcc-ar6-authors-v1.csv` |
| Records | 1,164 rows (932 unique authors) |
| Columns (v1) | Report, Chapter, Last Name, First Name, CountIfs, Role, Gender, Country of Residence, Citizenship, Affiliation |
| Columns (v2) | As above + Country of Residence Code, Citizenship Code |
| Encoding | UTF-8 |
| Origin | IPCC Sixth Assessment Report author listings |

---

## 2. Normalisation Actions

All transformations were applied to produce `ipcc-ar6-authors-v2.csv`. The original `v1` file is preserved unmodified.

### 2.1 Citizenship Standardisation

**Script:** `normalise_countries.py`  
**Rows affected:** 227

Short-form citizenship values were mapped to their full official names to match the `Country of Residence` column:

| Original Value | Normalised Value |
|----------------|------------------|
| UK | United Kingdom (of Great Britain and Northern Ireland) |
| USA | United States of America |
| Russia | Russian Federation |
| Tanzania | United Republic of Tanzania |

### 2.2 Name Casing (Title Case)

**Script:** `normalise_names.py`  
**Rows affected:** 1,164 (all rows)

Last Name and First Name fields were converted from ALL CAPS to Title Case with handling for:

- Hyphenated names: `DIONGUE-NIANG` → `Diongue-Niang`
- Multi-word names: `VAN VUUREN` → `Van Vuuren`
- Diacritics: `AðALGEIRSDóTTIR` → `Aðalgeirsdóttir`, `SöRENSSON` → `Sörensson`
- Roman numerals preserved: `TURNER II` → `Turner II`
- Parenthesised nicknames: `Elizabeth (libby)` → `Elizabeth (Libby)`
- Abbreviations with periods: `Bjørn H.` → `Bjørn H.`

### 2.3 Role Expansion

**Script:** `normalise_roles_gender.py`  
**Rows affected:** 1,052 (role) + 60 (underscore removal)

IPCC role acronyms were expanded to full names:

| Original | Expanded |
|----------|----------|
| CLA | Coordinating Lead Author |
| LA | Lead Author |
| RE | Review Editor |
| Core_Writing_Team | Core Writing Team |

The values `Author` (37 rows) and `Lead` (15 rows), found only in WGII Cross-Chapter Papers, were intentionally **not mapped** but are documented in the role mapping table as equivalent to Lead Author and Coordinating Lead Author respectively.

### 2.4 Gender Expansion

**Script:** `normalise_roles_gender.py`  
**Rows affected:** 1,164 (all rows)

| Original | Expanded |
|----------|----------|
| M | Male |
| F | Female |

### 2.5 ISO 3166-1 Alpha-2 Country Codes

**Script:** `add_iso_codes.py`  
**Rows affected:** 1,164 (all rows)

Two new columns were appended, derived from the existing country name columns:

| New Column | Source Column | Standard |
|------------|---------------|----------|
| Country of Residence Code | Country of Residence | ISO 3166-1 alpha-2 |
| Citizenship Code | Citizenship | ISO 3166-1 alpha-2 |

All 102 unique country names across both columns were successfully mapped (e.g. `United Kingdom (of Great Britain and Northern Ireland)` → `GB`, `United States of America` → `US`, `Republic of Korea` → `KR`).

---

## 3. Outputs

| File | Description |
|------|-------------|
| `ipcc-ar6-authors-v1.csv` | Original source data (unchanged) |
| `ipcc-ar6-authors-v2.csv` | Normalised dataset |
| `ipcc-ar6-roles.csv` | Role acronym mapping table (CSV) |
| `ipcc-ar6-roles.md` | Role acronym mapping table (Markdown) |
| `dashboard.html` | Interactive summary dashboard (Chart.js) |
| `normalise_countries.py` | Citizenship normalisation script |
| `normalise_names.py` | Name casing normalisation script |
| `normalise_roles_gender.py` | Role and gender normalisation script |
| `add_iso_codes.py` | ISO 3166-1 alpha-2 country code script |
| `rdm-protocol.md` | This protocol document |

---

## 4. Execution Order

To reproduce `ipcc-ar6-authors-v2.csv` from `ipcc-ar6-authors-v1.csv`:

```bash
cd data/authors
python normalise_countries.py    # Step 1: Creates v2 from v1, normalises citizenship
python normalise_names.py        # Step 2: Updates v2 in-place, title-cases names
python normalise_roles_gender.py # Step 3: Updates v2 in-place, expands roles & gender
python add_iso_codes.py          # Step 4: Updates v2 in-place, adds ISO country codes
```

---

## 5. Quality Checks

| Check | Result |
|-------|--------|
| Row count preserved | 1,164 in v1 = 1,164 in v2 |
| No citizenship short-forms remain | UK, USA, Russia, Tanzania all mapped |
| No ALL-CAPS names remain | Verified via unique value inspection |
| Role acronyms expanded | CLA, LA, RE all expanded; Author/Lead retained by design |
| Gender values expanded | M/F → Male/Female for all rows |
| UTF-8 encoding preserved | Diacritics intact (ö, é, ø, ð, ü, í, ñ, etc.) |
| ISO codes complete | All 102 unique country names mapped; no blanks in code columns (except where source is blank) |
| Column count | v1: 10 columns → v2: 12 columns |

---

## 6. Agent Details

| Item | Detail |
|------|--------|
| Tool | GitHub Copilot (VS Code extension) |
| Model | Claude Opus 4.6 (Anthropic) |
| Mode | Interactive chat with tool use |
| Session date | 2026-03-24 |
| Runtime | Python 3.11.9, PowerShell 5.1 (Windows) |
| Approach | Iterative — each normalisation step was discussed, confirmed by user, executed, and verified before proceeding |
