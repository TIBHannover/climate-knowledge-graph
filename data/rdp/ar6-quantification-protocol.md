# Research Data Protocol: Quantifying the AR6 Reports

**Source issue:** [TIBHannover/climate-knowledge-graph#18 — Quantifying the AR6 Reports and Data Protocol](https://github.com/TIBHannover/climate-knowledge-graph/issues/18)

**Status:** Ongoing / partially automated (see [Update log](#update-log) and [Open follow-up work](#open-follow-up-work))

## Purpose

This protocol documents how document- and bibliographic-level statistics were gathered
for the scientific text corpus that makes up the IPCC Sixth Assessment Report (AR6). It
records, for each metric, what was counted, where the source data came from, the method
used to collect it, and known limitations, so that the counts can be reproduced,
corrected, or automated in future work.

## Scope

### In scope: the 7 main reports of AR6

| Short code | Report |
|---|---|
| SYR | AR6 Synthesis Report: Climate Change 2023 |
| WGI | Climate Change 2021: The Physical Science Basis (Working Group I) |
| WGII | Climate Change 2022: Impacts, Adaptation and Vulnerability (Working Group II) |
| WGIII | Climate Change 2022: Mitigation of Climate Change (Working Group III) |
| SR1.5 | Special Report: Global Warming of 1.5°C (2018) |
| SRCCL | Special Report: Climate Change and Land (2019) |
| SROCC | Special Report: The Ocean and Cryosphere in a Changing Climate (2019) |

### Out of scope

- *2019 Refinement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories*
  (the Methodology Report belonging to the AR6 cycle, but not treated as one of the main
  reports for this protocol).

## Stats collected

1. PDF page count and word count
2. PDF licensing information and DOIs
3. Citations / references (BibTeX downloads, reference counts)
4. Author counts
5. Wikidata entries of AR6 reports
6. Figures count
7. Data count (datasets / data access points)
8. Glossary term count
9. Report translations
10. Acronyms count
11. Index terms count

---

## 1. PDF page count and word count

**Method**

- File size: read directly from the PDF file properties (Finder/Explorer).
- Page count: read from the PDF file. Counted only the numbered pages of the report body
  (a first pass mistakenly added the roman-numeral front-matter pages on top of the page
  count; this was corrected in the June 2026 update, see below).
- Word count: original pass — copy-pasted PDF text into
  [wordcounter.net](https://wordcounter.net/) ("Basic Option"). Revised pass (June 2026) —
  opened the PDF in Chrome and used the "Word Count Counter Plus" browser extension.

**Known limitations**

- Word counts are rough estimates: front matter, footers, references, and other
  non-body text were not stripped out before counting.
- Clipboard-based counting was unreliable for very large documents.
- Figures reported below are rounded and, in places, have been superseded by a corrected
  figure recorded alongside the original (shown as `original → corrected`).

**Data**

| Report | Source file / URL | File size | Page count | Word count |
|---|---|---|---|---|
| SYR | `IPCC_AR6_SYR_FullVolume.pdf` — https://www.ipcc.ch/report/ar6/syr/ | 4.9 MB | 185 + 14 pages | ~94,000 → 93,806 |
| WGI | `IPCC_AR6_WGI_FullReport.pdf` — https://www.ipcc.ch/report/ar6/wg1/ | 423.3 MB | 2,409 pages | ~1,925,000 → 1,925,469 |
| WGII | `IPCC_AR6_WGII_FullReport.pdf` — https://www.ipcc.ch/report/ar6/wg2/ | 396 MB | 3,068 + 12 pages | ~2,513,000 → 2,514,759 |
| WGIII | `IPCC_AR6_WGIII_FullReport.pdf` — https://www.ipcc.ch/report/ar6/wg3/ | 68.8 MB | 2,042 + 11 pages | ~1,642,000 → 1,642,687 |
| SR1.5 | `SR15_Full_Report_HR.pdf` — https://www.ipcc.ch/sr15/ | 65 MB | 631 pages | ~511,000 → 510,684 |
| SRCCL | `SRCCL_Full_Report.pdf` — https://www.ipcc.ch/srccl/ | 44.9 MB | 908 pages | ~735,000 → 734,356 |
| SROCC | `SROCC_FullReport_FINAL.pdf` — https://www.ipcc.ch/srocc/ | 51.9 MB | 766 pages | ~627,000 → 627,209 |
| **Total** | | **1,054.8 MB** | **10,009 pages** | **~8,047,000 → 8,048,970** |

---

## 2. PDF licensing information and DOIs

**Method**

- DOIs: retrieved from the front matter of each PDF.
- DOIs resolved via [doi.org](https://doi.org) to confirm the target and licence.

**Summary**

- SYR: covered by the general [IPCC copyright statement](https://www.ipcc.ch/copyright/) —
  no report-specific licence was found.
- WGI, WGII, WGIII, SR1.5, SRCCL, SROCC: [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.en).

**Data**

| Report | DOI | Report page | Licence |
|---|---|---|---|
| SYR | 10.59327/IPCC/AR6-9789291691647 | https://www.ipcc.ch/report/ar6/syr/ | https://www.ipcc.ch/copyright/ |
| WGI | 10.1017/9781009157896 | [Cambridge Core](https://www.cambridge.org/core/books/climate-change-2021-the-physical-science-basis/415F29233B8BD19FB55F65E3DC67272B) | CC BY-NC-ND 4.0 |
| WGII | 10.1017/9781009325844 | [Cambridge Core](https://www.cambridge.org/core/books/climate-change-2022-impacts-adaptation-and-vulnerability/161F238F406D530891AAAE1FC76651BD) | CC BY-NC-ND 4.0 |
| WGIII | 10.1017/9781009157926 | [Cambridge Core](https://www.cambridge.org/core/books/climate-change-2022-mitigation-of-climate-change/2929481A59B59C57C743A79420A2F9FF) | CC BY-NC-ND 4.0 |
| SR1.5 | 10.1017/9781009157940 | [Cambridge Core](https://www.cambridge.org/core/books/global-warming-of-15c/D7455D42B4C820E706A03A169B1893FA) | CC BY-NC-ND 4.0 |
| SRCCL | 10.1017/9781009157988 | [Cambridge Core](https://www.cambridge.org/core/books/climate-change-and-land/AAB03E2F17650B1FDEA514E3F605A685) | CC BY-NC-ND 4.0 |
| SROCC | 10.1017/9781009157964 | [Cambridge Core](https://www.cambridge.org/core/books/ocean-and-cryosphere-in-a-changing-climate/A05E6C9F8638FA7CE1748DE2EB7B491B) | CC BY-NC-ND 4.0 |

---

## 3. Citations / references (BibTeX downloads, reference counts)

**Method**

- `.bib` file count: counted manually on each report's website under
  Chapters/Annexes → "Downloads" → "Citations (bib)". Flagged as needing revisiting since
  it was a manual count.
- Reference / citation counts: no single authoritative source exists per report, so
  multiple secondary sources were gathered and cross-checked (see below). Figures should
  be treated as estimates, not exact counts.

**Reference collection**

- Zotero group collection: https://www.zotero.org/groups/2437020/semanticclimate/collections/LJKWTTYZ

**Data**

| Report | `.bib` files | Estimated references/citations | Sources |
|---|---|---|---|
| SYR | 0 (no citations/references in this report) | 0? | — |
| WGI | ~13 | 13,000–19,266 | [Wikipedia](https://en.wikipedia.org/wiki/IPCC_Sixth_Assessment_Report#WG1report) (>14,000 papers); [Zenodo analysis](https://zenodo.org/records/7615825) (>18,000 citations / >13,000 unique refs); [Carbon Brief](https://www.carbonbrief.org/guest-post-what-13500-citations-reveal-about-the-ipccs-climate-science-report/) (13,500); [The Conversation](https://theconversation.com/234-scientists-read-14-000-research-papers-to-write-the-ipcc-climate-report-heres-what-you-need-to-know-and-why-its-a-big-deal-165587) (14,000); [Zenodo record](https://zenodo.org/records/5475442) (19,266 distinct reference strings) |
| WGII | ~29 | 17,419 | [Wikipedia](https://en.wikipedia.org/wiki/IPCC_Sixth_Assessment_Report#Working_Group_2_report_(impacts,_adaptation_and_vulnerability)); [Zenodo](https://zenodo.org/records/6344388) (17,419 DOIs cited) |
| WGIII | ~19 | ? (not yet resolved) | [Wikipedia](https://en.wikipedia.org/wiki/IPCC_Sixth_Assessment_Report#Working_Group_3_report_(mitigation_of_climate_change)) |
| SR1.5 | none found | 5,000–6,099 | [Wikipedia](https://en.wikipedia.org/wiki/Special_Report_on_Global_Warming_of_1.5_%C2%B0C) (>6,000 references, 91 authors, 40 countries); [Zenodo](https://zenodo.org/records/5475442) (5,099 distinct reference strings) |
| SRCCL | none found | 7,800–7,828 | [Wikipedia](https://en.wikipedia.org/wiki/Special_Report_on_Climate_Change_and_Land); [Zenodo](https://zenodo.org/records/5475442) (7,828 distinct reference strings) |
| SROCC | none found | 6,981–7,161 | [Wikipedia](https://en.wikipedia.org/wiki/Special_Report_on_the_Ocean_and_Cryosphere_in_a_Changing_Climate) (6,981 publications, 104 authors, 36 countries); [Centre Scientifique de Monaco](https://www.centrescientifique.mc/en/article/the-special-report-on-the-ocean-and-cryosphere-in-a-changing-climate-srocc-accepted) (6,981 cited references); [Zenodo](https://zenodo.org/records/5475442) (7,161 distinct reference strings) |

---

## 4. Author counts

**Method**

- Counted from the "authors" listing published on each report's landing page, and
  cross-checked against the [IPCC authors app](https://apps.ipcc.ch/report/authors/authors.php).
- Duplicates (an author contributing to multiple reports) are **not** consolidated in the
  per-report table below — the same person is counted once per report they contributed to.
- June 2026 update: all authors were collected into a spreadsheet and de-duplicated using
  an LLM (Claude), matching on Last name + First name → merge. This produced a
  de-duplicated total of **932 unique authors** across all seven reports.

**Data**

| Report | Source | Authors | Notes |
|---|---|---|---|
| SYR | [Core writing team](https://www.ipcc.ch/report/sixth-assessment-report-cycle/) | 30 | [IPCC authors app](https://apps.ipcc.ch/report/authors/report.authors.php?q=38&p=) |
| WGI | [Authors page](https://www.ipcc.ch/report/ar6/wg1/about/authors/) | 234 | [IPCC authors app](https://apps.ipcc.ch/report/authors/report.authors.php?q=35&p=) |
| WGII | [Authors page](https://www.ipcc.ch/report/ar6/wg2/about/authors) | 270 | [IPCC authors app](https://apps.ipcc.ch/report/authors/report.authors.php?q=36&p=) |
| WGIII | [Authors page](https://www.ipcc.ch/report/ar6/wg3/about/authors) | 278 | [Archived IPCC authors app](https://archive.ipcc.ch/report/authors/report.authors.php?q=37&p=) |
| SR1.5 | [Authors page](https://www.ipcc.ch/sr15/authors/) | 86 | |
| SRCCL | [Authors page](https://www.ipcc.ch/srccl/authors/) | 107 | |
| SROCC | [Authors page](https://www.ipcc.ch/srocc/about/authors/) | ~101 | [Archived IPCC authors app](https://archive.ipcc.ch/report/authors/report.authors.php?q=33&p=) |
| **Total (as listed per report)** | | **1,106** | Not de-duplicated across reports |
| **Total (de-duplicated, June 2026)** | | **932** | Deduplicated across all 7 reports |

---

## 5. Wikidata entries of AR6 reports

**Method**

- Searched Wikidata directly for each report's name and cross-referenced with
  [Scholia](https://scholia.toolforge.org/), [Reasonator](https://reasonator.toolforge.org/),
  and [SQID](https://sqid.toolforge.org/).
- Zotero collection: https://www.zotero.org/groups/2437020/semanticclimate/collections/773CNPDW

**Notes / limitations**

- Wikidata also has entries for parts of reports (e.g. the Summary for Policymakers of
  the SYR). Only full-report entries are listed here.

**Data**

| Report | Wikidata item(s) | QID(s) |
|---|---|---|
| IPCC Sixth Assessment Report (overall) | https://www.wikidata.org/wiki/Q103843442 | Q103843442 |
| SYR | https://www.wikidata.org/wiki/Q117820486 | Q117820486 |
| WGI | https://www.wikidata.org/wiki/Q108133155 | Q108133155 |
| WGII | https://www.wikidata.org/wiki/Q124454848, https://www.wikidata.org/wiki/Q111109497 | Q124454848, Q111109497 |
| WGIII | https://www.wikidata.org/wiki/Q123285197, https://www.wikidata.org/wiki/Q111489232 | Q123285197, Q111489232 |
| SR1.5 | https://www.wikidata.org/wiki/Q57077013, https://www.wikidata.org/wiki/Q123675901 | Q57077013, Q123675901 |
| SRCCL | https://www.wikidata.org/wiki/Q66310618, https://www.wikidata.org/wiki/Q114750129 | Q66310618, Q114750129 |
| SROCC | https://www.wikidata.org/wiki/Q67028624, https://www.wikidata.org/wiki/Q114204629 | Q67028624, Q114204629 |

---

## 6. Figures count

**Method**

- Manually scanned and counted the figure-overview pages published on the IPCC website
  for each report. Flagged as unreliable; re-counted in the June 2026 update (figures
  below shown as `original → recount` where a recount happened).

**Data**

| Report | Source | Figures |
|---|---|---|
| SYR | https://www.ipcc.ch/report/ar6/syr/figures | 28 |
| WGI | https://www.ipcc.ch/report/ar6/wg1/figures | 511 → 515 |
| WGII | https://www.ipcc.ch/report/ar6/wg2/figures | 469 |
| WGIII | https://www.ipcc.ch/report/ar6/wg3/figures | 354 |
| SR1.5 | https://www.ipcc.ch/sr15/graphics/#cid_6333 | 89 |
| SRCCL | Individual chapter links off https://www.ipcc.ch/srccl/ (no consolidated figures repository found) | 132 → 116 + 17 images from the PDF-only chapter = 133 |
| SROCC | Individual chapter links off https://www.ipcc.ch/srocc/ (no consolidated figures repository found) | 89 → 90 |
| **Total** | | **1,672 → 1,678** |

---

## 7. Data count

No systematic count of datasets per report has been carried out yet. This section
currently records entry points for future quantification work rather than final figures.

**Sources identified**

- World Data Center for Climate (WDCC): https://www.wdc-climate.de/ui/q?general_key_ss=IPCC-AR6
- IPCC "Available Data for AR6" landing page: https://ipcc-data.org/ar6landing.html
- IPCC Data Browser:
  - https://ipcc-browser.ipcc-data.org/browser/search?searchterm=ar6
  - https://ipcc-browser.ipcc-data.org/browser/search?keywords=IPCC-AR6
  - https://ipcc-browser.ipcc-data.org/browser/search?keywords=AR6
- Data and code access per report (incomplete): WGI — https://www.ipcc.ch/report/ar6/wg1/resources/data-access/

---

## 8. Glossary term count

**Method**

- Each report PDF contains its own glossary section, but individual reports were not
  counted separately — instead, the consolidated glossary repository on the IPCC website
  was used as the source of truth.
- The [IPCC Glossary](https://apps.ipcc.ch/glossary/) "current terms" view (AR6 Working
  Group reports only) gives 925 terms in total.
- The ["Past terms"](https://apps.ipcc.ch/glossary/searchlatest.php) tab additionally
  surfaces terms from the AR6 Special Reports (SRCCL, SROCC, SR1.5).
- June 2026 update: all terms (current + past) were copied into a spreadsheet and merged,
  adding Working Group attribution to each term. This produced a total of **1,274 terms**.

**Data files**

- Before merge: `Glossary-Full.ods` (attached to the source issue)
- After merge: `Glossary-Full_merged.ods` (attached to the source issue)

**Data**

| Pass | Source | Total terms |
|---|---|---|
| Initial | https://apps.ipcc.ch/glossary/ (current terms, WG reports only) | 925 |
| June 2026 (merged) | Current + Past terms, merged and de-duplicated with WG attribution | 1,274 |

---

## 9. Report translations

**Method**

- Manually counted the translation files listed on each report's "Resources /
  Translations" page. It is not always clear what has actually been translated versus
  only announced/in preparation, so figures are unreliable and need double-checking.

**Data**

| Report | Source | Full-report translations | Notes |
|---|---|---|---|
| SYR | https://www.ipcc.ch/report/ar6/syr/resources/translations/ | 5 (in preparation) | 2 × SPM |
| WGI | https://www.ipcc.ch/report/ar6/wg1/resources/translations/ | 5 | 2, partial |
| WGII | https://www.ipcc.ch/report/ar6/wg2/resources/translations/ | 5 | 3 × SPM |
| WGIII | https://www.ipcc.ch/report/ar6/wg3/resources/translations/ | 5 | 1 × SPM |
| SR1.5 | https://www.ipcc.ch/sr15/download/ ("UN and other languages") | 5 | 4 × SPM |
| SRCCL | https://www.ipcc.ch/srccl/download/ ("SPM in UN Languages" / "SPM in other languages") | 5 × SPM | 3 × SPM |
| SROCC | https://www.ipcc.ch/srocc/download/ ("UN and other languages") | 5 × SPM | 5 × SPM |

---

## 10. Acronyms count

**Method**

- Acronym lists were copied from each report's PDF (typically an annex) into plain text
  files, then manually corrected for line breaks introduced by the copy/paste. This is
  not 100% accurate and needs to be automated.
- June 2026 update: source data likely came from a prior scrape; the exact scrape method
  could not be reconstructed. Removing duplicates from the collected spreadsheet gives an
  approximate total of 1,931 acronyms.

**Source text files** (extracted from PDFs, attached to the source issue)

- `syr-acronyms.txt`, `wg1-acronyms.txt`, `wg2-acronyms.txt`, `wg3-acronyms.txt`,
  `SR15-acronyms.txt`, `SRCCL-acronyms.txt`, `SROCC-acronyms.txt`

**Data**

| Report | Source | Acronyms |
|---|---|---|
| SYR | https://www.ipcc.ch/report/ar6/syr/annexes-and-index/#annex-ii | ~90 |
| WGI | (annex, see acronym text file) | ~521 |
| WGII | https://www.ipcc.ch/report/ar6/wg2/chapter/annex-iii/ | ~692 |
| WGIII | (annex, see acronym text file) | ~548 |
| SR1.5 | (annex, see acronym text file) | ~566 |
| SRCCL | (annex, see acronym text file) | ~430 |
| SROCC | (annex, see acronym text file) | ~194 |
| **De-duplicated total (June 2026)** | | **~1,931** |

---

## 11. Index terms count

**Method**

- Very rough manual estimates from each report's index, counted/estimated directly from
  the PDFs. Explicitly flagged as far from 100% accurate and in need of automation.
- Only main (bold) index terms were counted; each of these can have many (sometimes
  hundreds of) sub-terms that were not counted individually.

**Data**

| Report | Index terms (main/bold terms only) |
|---|---|
| SYR | ~227 |
| WGI | ~1,138 |
| WGII | ~1,054 |
| WGIII | ~1,005 |
| SR1.5 | ~526 |
| SRCCL | ~1,036 |
| SROCC | ~477 |

---

## Update log

- **2025-07 to 2025-11**: Initial data collection across all 11 metrics, recorded directly
  in the source issue by [@oldenbourglaura](https://github.com/oldenbourglaura).
- **2026-06**: Revision pass — corrected page counts (removed double-counted front
  matter), switched word-count tooling (Chrome "Word Count Counter Plus" extension),
  re-counted figures, de-duplicated authors (932 total), merged glossary terms (1,274
  total), and de-duplicated acronyms (~1,931 total). Licensing/DOI, translations, and
  index term figures were not updated in this pass.

## Open follow-up work

Noted by [@mrchristian](https://github.com/mrchristian) (2025-09-16) as still required:

1. Re-run/validate counts using [GROBID](https://github.com/kermitt2/grobid) for
   structured extraction from the PDFs (tracked in
   [issue #27](https://github.com/TIBHannover/climate-knowledge-graph/issues/27)).
2. Locate and document the canonical *source* of each report (status and format — PDF,
   web, per-language availability, etc.) rather than relying on ad hoc download links.
3. Establish formal dimensions/quantities for the report corpus (tracked in
   [issue #23](https://github.com/TIBHannover/climate-knowledge-graph/issues/23), marked
   as a duplicate of this protocol's source issue).
4. Consolidate lists of authors, acronyms, and index terms (tracked in
   [issue #33](https://github.com/TIBHannover/climate-knowledge-graph/issues/33), completed).

Additional reference material: semanticClimate's listing of AR6 report parts —
https://semanticclimate.github.io/p/en/posts/ipcc_resources/, and GERICS's "IPCC AR6 made
easy" summary —
https://www.gerics.de/products_and_publications/publications/detail/102556/index.php.en

## Related repository content

- [ar6.qmd](../../ar6.qmd) — structural browse page listing all AR6 report parts and chapters.
- [reports.qmd](../../reports.qmd) — reports overview page.
