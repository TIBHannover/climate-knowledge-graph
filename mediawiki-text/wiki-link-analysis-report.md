# MediaWiki XML Export — Internal Page Link Analysis

**Source file:** `KEWL-20260322093018.xml` (≈ 61 MB)
**Wiki:** KEWL — `https://test.kewl.org/`
**MediaWiki version:** 1.45.1
**Export date:** 2026-03-22
**Analysis date:** 2026-03-26

---

## Summary

The XML export contains **89 wiki pages** and a total of **136,783** `[[…]]`
wikitext constructs. Of these, **3,374 are internal page links** — links that
point to another page within the same wiki.

| Category | Count |
| --- | ---: |
| **Page links (internal wiki pages)** | **3,374** |
| Anchor / footnote links (`[[#…]]`) | 131,138 |
| File / image embeds (`[[File:…]]`) | 2,271 |
| Category links | 0 |
| Media links | 0 |
| **Total `[[…]]` constructs** | **136,783** |

The 3,374 page links resolve to **1,143 unique link targets**, all in the
`IPCC:` namespace.

---

## Page links by IPCC report group

| Report | Unique targets | Total links |
| --- | ---: | ---: |
| IPCC WG I | 466 | 1,665 |
| IPCC WG II | 430 | 1,112 |
| IPCC WG III | 214 | 559 |
| IPCC SR1.5 | 12 | 17 |
| IPCC SRCCL | 11 | 11 |
| IPCC SROCC | 9 | 9 |
| IPCC SYR | 1 | 1 |
| **Total** | **1,143** | **3,374** |

---

## Top 20 most-linked targets

| # Links | Target page |
| ---: | --- |
| 70 | `IPCC:Wg1:Chapter:Atlas` |
| 42 | `IPCC:Wg1:Chapter:Chapter-2` |
| 38 | `IPCC:Wg1:Chapter:Chapter-9` |
| 37 | `IPCC:Wg1:Chapter:Chapter-11#11.9` |
| 35 | `IPCC:Wg1:Chapter:Chapter-2#2.3.3.3` |
| 35 | `IPCC:Wg1:Chapter:Chapter-7` |
| 32 | `IPCC:Wg1:Chapter:Chapter-11` |
| 30 | `IPCC:Wg1:Chapter:Chapter-4` |
| 27 | `IPCC:Wg1:Chapter:Chapter-6` |
| 26 | `IPCC:Wg2:Chapter:Chapter-5` |
| 24 | `IPCC:Wg1:Chapter:Chapter-12` |
| 24 | `IPCC:Wg1:Chapter:Chapter-3` |
| 24 | `IPCC:Wg2:Chapter:Chapter-2` |
| 24 | `IPCC:Wg3:Chapter:Chapter-3` |
| 23 | `IPCC:Wg3:Chapter:Chapter-2` |
| 22 | `IPCC:Wg3:Chapter:Chapter-6` |
| 22 | `IPCC:Wg3:Chapter:Chapter-7` |
| 21 | `IPCC:Wg1:Chapter:Chapter-8` |
| 21 | `IPCC:Wg1:Chapter:Chapter-5` |
| 21 | `IPCC:Wg3:Chapter:Chapter-5` |

---

## Methodology

All `[[…]]` constructs were extracted from the `<text>` elements of the
MediaWiki XML export using the regex pattern `\[\[([^\]]+?)\]\]`. Each match
was classified by inspecting the link target (the portion before any `|`
display-text separator):

| Prefix | Classification |
| --- | --- |
| `#` | Anchor / footnote link (same-page) |
| `File:` or `Image:` | File or image embed |
| `Category:` | Category assignment |
| `Media:` | Media link |
| *(anything else)* | **Internal page link** |

The analysis script is saved alongside this report as
`analyse_wiki_links.py`.

---

## Reproducing the analysis

```bash
python mediawiki-text/analyse_wiki_links.py mediawiki-text/KEWL-20260322093018.xml
```
