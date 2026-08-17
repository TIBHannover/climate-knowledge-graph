# Project Information Pipeline

## Overview

This pipeline transforms structured, bilingual project information into multiple output
formats from a single source of truth. The source is a human-editable document
(`project-template.fodt`) that is maintained by both technical and non-technical team
members, then converted into XML instances which drive all downstream outputs.

```
Nextcloud share (e.g. https://tib.cloud/s/...)   ← EDITOR UPLOADS HERE
        │
        │  scripts/Convert-FODT.ps1
        │  (downloads and parses the FODT)
        ▼
project-template.fodt   ← local copy (versioned)
        │
        │  Convert-FODT.ps1 writes:
        ▼
project-info-en.xml     project-info-de.xml
        │
        ├── scripts/Apply-XSLT.ps1 (uses ResearchProject.xslt)
        │          ▼
        │   project-info-en.html  ← generated webpage
        │
        └── scripts/Make-Readme.ps1 (uses ResearchProject-readme.xslt)
                   ▼
             README.md  ← repository README

  (future outputs from XML)
  TIB project page  ·  Wikidata entries  ·  Zenodo metadata
  GitLab Pages (Quarto)  ·  Wiki Commons
```

---

## Files in `project-info/`

| File | Role |
|---|---|
| `project-template.fodt` | **Source of truth.** Bilingual EN/DE template. Open in LibreOffice Writer. |
| `project-info-en.xml` | English XML instance, conforming to `ResearchProject.dtd` |
| `project-info-de.xml` | German XML instance, conforming to `ResearchProject.dtd` |
| `ResearchProject.dtd` | XML schema definition (schema.org ResearchProject, v30.0) |
| `ResearchProject.xslt` | XSLT 1.0 stylesheet — transforms XML to HTML5 webpage |
| `ResearchProject-readme.xslt` | XSLT 1.0 stylesheet — transforms XML to Markdown README |
| `project-info-en.html` | Generated HTML webpage (do not edit manually) |
| `scripts/Convert-FODT.ps1` | Downloads FODT from Nextcloud and converts it to EN/DE XML |
| `scripts/Apply-XSLT.ps1` | PowerShell script to regenerate the HTML from XML |
| `scripts/Make-Readme.ps1` | PowerShell script to regenerate `README.md` at the repo root |
| `README.md` | This file — workflow documentation |

---

## Step-by-Step Workflow

### 1 — Update content (non-technical)

**Make a copy of `project-template.fodt` before editing.** The template file in the
repository is a blank master — do not fill it in directly. Create a working copy (e.g.
`project-template-2026.fodt`) in your local folder, fill that in, and return the
completed copy to the technical team. This keeps the blank template intact for future
use.

Open your copy of `project-template.fodt` in **LibreOffice Writer**.

- The **Active Project Fields** table contains all currently used fields.
  Each row shows the `schema.org` field name, an English column, and a German column.
- Write `(= EN)` in the DE cell for fields that do not require translation (URLs,
  identifiers, team member names).
- Do **not** edit the grey "Unused DTD Fields" section unless you want to activate a
  new field — if so, add the value and flag it for the technical team.
- Save your copy. Send it to the technical team (or commit it to the repository under
  a versioned filename such as `project-template-2026.fodt`).

### 2 — Convert FODT to XML (automated)

Run `scripts/Convert-FODT.ps1` to download the FODT from Nextcloud and regenerate
both XML files automatically:

```powershell
cd C:\gitlab\opp\project-info\scripts

# Fetch from Nextcloud (default share URL in the script)
.\Convert-FODT.ps1

# Or supply a different share URL
.\Convert-FODT.ps1 -ShareUrl https://tib.cloud/s/QFJHz4NZZLJKTe2

# Or convert a locally saved FODT (offline / specific version)
.\Convert-FODT.ps1 -LocalFodt "C:\Downloads\project-template-2026.fodt"

# Save a local archive copy of the downloaded FODT at the same time
.\Convert-FODT.ps1 -ShareUrl https://tib.cloud/s/QFJHz4NZZLJKTe2 `
                   -SaveFodt "..\project-template-2026.fodt"
```

The script parses all fields in the **Active Project Fields** table, including
structured entries (team members with ORCIDs, organisations with ROR identifiers,
licence blocks, funding details). German cells that contain `(= EN)` automatically
fall back to the English value.

**Field conventions used in the FODT table** (for editors):

| Field | Convention in EN/DE cells |
|---|---|
| `name`, `alternateName`, `url`, `keywords` | Plain text in one paragraph |
| `description`, `knowsAbout` | One paragraph per item / paragraph |
| `sameAs` | One URL per paragraph |
| `identifier` | Line 1: display text · Line 2: `propertyID="..." value="..."` |
| `image → imageObject` | Alternating caption / URL pairs (EN); DE: `URLs (= EN)` then `DE captions:` then captions |
| `foundingDate / dissolutionDate` | `Start: YYYY` and `End: YYYY` |
| `parentOrganization` | Line 1: org name · Line 2: `ROR: https://...` |
| `member` | Alternating name / `ORCID: 0000-...` pairs |
| `memberOf` | EN: alternating name / `ROR: https://...` or URL pairs · DE: names only (hrefs taken from EN) |
| `funding` | `Label:` / value alternating pairs (`Name:`, `Grant ID:`, `Funder:`, `URL:`) |
| `knowsLanguage` | `code (Language name)` per paragraph, e.g. `en (English)` |
| `hasCredential` | Groups of three paragraphs: name · description · URL (blank line between groups) |

### 3 — Regenerate the HTML webpage

Run `scripts/Apply-XSLT.ps1` from PowerShell (no extra software required — uses
.NET's built-in XSLT processor):

```powershell
cd C:\gitlab\opp\project-info
.\scripts\Apply-XSLT.ps1
```

Or to transform a specific input/output:

```powershell
.\scripts\Apply-XSLT.ps1 -Source project-info-en.xml -Output project-info-en.html
```

The XSLT stylesheet (`ResearchProject.xslt`) is reusable: pass the DE XML to produce
a German-language webpage:

```powershell
.\scripts\Apply-XSLT.ps1 -Source project-info-de.xml -Output project-info-de.html
```

### 4 — Regenerate the repository README

Run `scripts/Make-Readme.ps1` from anywhere in the repository. It calls
`Apply-XSLT.ps1` with the correct paths and writes `README.md` to the repo root:

```powershell
cd C:\gitlab\opp
.\project-info\scripts\Make-Readme.ps1
```

The README is generated from `project-info-en.xml` using
`ResearchProject-readme.xslt`. Do not edit `README.md` manually — changes will be
overwritten the next time the script is run.

### 5 — Use outputs downstream

The XML files are the machine-readable source for all other outputs:

| Output | How to produce |
|---|---|
| **HTML webpage** | Run `Apply-XSLT.ps1` (Step 3 above) |
| **GitLab README** | Run `Make-Readme.ps1` (Step 4 above) |
| **TIB project page** | Paste `description` (EN/DE) and metadata into the TIB CMS |
| **Wikidata entry** | Map XML fields to Wikidata properties (see mapping table below) |
| **Zenodo deposit** | Use `name`, `description`, `member` (authors), `funding`, `keywords` |
| **GitLab Pages (Quarto)** | Future: Jupyter Notebook reads XML and renders Quarto site |

---

## Schema.org → Wikidata Property Mapping

| XML field | Wikidata property | Notes |
|---|---|---|
| `name` | P1476 (title) | Use monolingual text with language tag |
| `description` | P18 / description field | Wikidata descriptions are short (< 250 chars) — use `disambiguatingDescription` |
| `alternateName` | P4970 (alternative name) | |
| `url` | P856 (official website) | |
| `sameAs` | P2888 (exact match) | |
| `identifier` (GrantID) | P8329 (project grant ID) | |
| `foundingDate` | P571 (inception) | |
| `dissolutionDate` | P576 (dissolved/abolished) | |
| `parentOrganization` (Lead) | P361 (part of) | |
| `memberOf` (Partner) | P361 (part of) or P664 (organizer) | |
| `member` | P710 (participant) | Link to person's Wikidata item via ORCID |
| `funder` | P8324 (funded by) | |
| `funding` identifier | P8329 (project grant ID) | |
| `keywords` | P921 (main subject) | Create as separate Wikidata items where possible |

---

## DTD and Schema Reference

- **Schema**: <https://schema.org/ResearchProject>
  Hierarchy: Thing → Organization → Project → ResearchProject
- **DTD**: `ResearchProject.dtd` (Schema Version 30.0, 2026-03-19)
  Available at: <https://gitlab.com/TIBHannover/open-science-lab/pip/-/blob/main/ResearchProject.dtd>
- **ODF specification**: <https://docs.oasis-open.org/office/OpenDocument/v1.3/>
  The `.fodt` template is a Flat ODF Text document — a single-file XML format that
  LibreOffice Writer opens and saves natively.

---

## Adding a New Field

1. Add the field row to the `project-template.fodt` Active Fields table, following the
   convention format for its type (see the table in Step 2 above).
2. Add a parsing block for the new field in `scripts/Convert-FODT.ps1` and add the
   corresponding XML output in its `Build-XML` function.
3. If the field should appear in the HTML webpage, add a rendering block to
   `ResearchProject.xslt` and run `Apply-XSLT.ps1` to regenerate.
4. If the field should appear in the README, add a rendering block to
   `ResearchProject-readme.xslt` and run `Make-Readme.ps1` to regenerate.
5. Update this file (`project-info/README.md`) with the new field's downstream mapping.

---

## Notes on the FODT Format

The template is saved as `.fodt` (Flat OpenDocument Text), a plain XML file.
This means it is:
- **Human-readable** — can be opened in any text editor
- **Version-control friendly** — diffs work properly in Git
- **Fully editable** in LibreOffice Writer (File → Open, or double-click)

To save in the standard compressed `.odt` format (for sharing with partners who
prefer it), use **File → Save As → ODF Text Document (.odt)** in LibreOffice.
