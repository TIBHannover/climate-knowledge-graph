# Wikibase Manifests — IPCC Climate Reports Knowledge Graph

Documentation for the OpenRefine Wikibase manifest and schema created for the
[IPCC Climate Reports Knowledge Graph](https://kg-ipclimatec-reports.wikibase.cloud/wiki/Main_Page).

## Files

| File | Purpose |
|------|---------|
| `kg-ipclimatec-reports-manifest.json` | Wikibase manifest for OpenRefine — tells OpenRefine how to connect to this Wikibase instance |
| `kg-ipclimatec-reports-schema.json` | OpenRefine Wikibase schema — maps CSV column names to Wikibase properties for batch import |

## Manifest

### How it was created

The manifest follows the [OpenRefine Wikibase manifest v1 specification](https://github.com/OpenRefine/OpenRefine/wiki/Write-a-Wikibase-manifest).

Values were discovered by querying the Wikibase API:

1. **MediaWiki metadata** — retrieved via the `action=query&meta=siteinfo` API endpoint, which returned the site name ("IPCC"), server URL, and the `wikibase-conceptbaseuri` (`https://kg-ipclimatec-reports.wikibase.cloud/entity/`).

2. **Property IDs** — discovered using `action=wbsearchentities`:
   - `P1` = "instance of"
   - `P6` = "subclass of"

3. **Extensions** — the list of installed extensions was retrieved via `action=query&meta=siteinfo&siprop=extensions`:
   - **OAuth** is installed → `oauth` section included.
   - **WikibaseQualityConstraints** is _not_ installed → `constraints` section omitted.
   - **EditGroups** service is not available → `editgroups` section omitted.

4. **Reconciliation** — endpoint set to the wikibase.cloud convention (`/tools/openrefine-wikibase/${lang}/api`). Note: at last check this endpoint was returning a bot-protection page and may not be deployed. If you run your own reconciliation service (e.g. via [openrefine-wikibase](https://gitlab.com/nfdi4culture/ta1-data-enrichment/openrefine-wikibase)), update the endpoint URL.

### Manifest contents

| Field | Value |
|-------|-------|
| version | `1.0` |
| mediawiki.name | IPCC Climate Reports Knowledge Graph |
| mediawiki.root | `https://kg-ipclimatec-reports.wikibase.cloud/wiki/` |
| mediawiki.api | `https://kg-ipclimatec-reports.wikibase.cloud/w/api.php` |
| wikibase.site_iri | `https://kg-ipclimatec-reports.wikibase.cloud/entity/` |
| wikibase.maxlag | `5` |
| wikibase.properties.instance_of | `P1` |
| wikibase.properties.subclass_of | `P6` |
| oauth.registration_page | `https://kg-ipclimatec-reports.wikibase.cloud/wiki/Special:OAuthConsumerRegistration/propose` |
| reconciliation.endpoint | `https://kg-ipclimatec-reports.wikibase.cloud/tools/openrefine-wikibase/${lang}/api` |

### How to use the manifest

In OpenRefine:

1. Go to the **Wikidata** extension menu.
2. Select **Select Wikibase instance…**
3. Click **Add Wikibase**.
4. Either paste the raw URL of `kg-ipclimatec-reports-manifest.json` (if hosted) or paste the JSON content directly.
5. OpenRefine will validate the manifest format on import.

## Schema

### How it was created

All 28 properties (P1–P28) were discovered by listing namespace 122 (Property pages) via `action=query&list=allpages&apnamespace=122`, then fetching their labels, descriptions, and datatypes in a single batch call using `action=wbgetentities`.

Each property was mapped to a statement group in the schema using the correct value type:

- **`wikibase-item`** properties use `wbentityvariable` (expects a reconciled Wikibase item in the column).
- **`string`**, **`url`**, **`quantity`**, and **`commonsMedia`** properties use `wbstringvariable` (expects a plain text value).
- **`monolingualtext`** properties use `wbmonolingualexpr` wrapping a `wbstringvariable` (language hardcoded to `en`).
- **`entity-schema`** (P24) was excluded as it is not supported by OpenRefine's standard schema import.

### Property-to-column mapping

The schema expects a CSV/spreadsheet with the following column names. Only include columns for
properties you are actually importing — OpenRefine will skip empty or missing columns.

| PID | Property | Datatype | CSV Column |
|-----|----------|----------|------------|
| — | _(item label)_ | — | `WB name` |
| — | _(item description)_ | — | `description` |
| P1 | instance of | wikibase-item | `instance_of` |
| P2 | exact match | url | `exact_match` |
| P3 | has the IPCC statement | monolingualtext | `ipcc_statement` |
| P4 | part of | wikibase-item | `part_of` |
| P5 | confidence level | wikibase-item | `confidence_level` |
| P6 | subclass of | wikibase-item | `subclass_of` |
| P7 | role | wikibase-item | `role` |
| P8 | series ordinal | quantity | `series_ordinal` |
| P9 | spatial scope | wikibase-item | `spatial_scope` |
| P10 | impact | wikibase-item | `impact` |
| P11 | cites | wikibase-item | `cites` |
| P12 | topic | wikibase-item | `topic` |
| P13 | follows | wikibase-item | `follows` |
| P14 | followed by | wikibase-item | `followed_by` |
| P15 | short name | monolingualtext | `short_name` |
| P16 | pyami ID | string | `pyami_id` |
| P17 | has title | string | `title` |
| P18 | driver | wikibase-item | `driver` |
| P19 | pressure | wikibase-item | `pressure` |
| P20 | state | wikibase-item | `state` |
| P21 | response | wikibase-item | `response` |
| P22 | of | wikibase-item | `of` |
| P23 | chemical structure | commonsMedia | `chemical_structure` |
| P25 | official website | url | `official_website` |
| P26 | wikitext URL | url | `wikitext_url` |
| P27 | Report | wikibase-item | `report` |
| P28 | Chapter | wikibase-item | `chapter` |

### How to use the schema

1. Open a project in OpenRefine with column names matching those listed above.
2. Make sure the IPCC Wikibase is selected as the active Wikibase instance (using the manifest).
3. Go to the **Wikidata** extension menu → **Import schema**.
4. Select `kg-ipclimatec-reports-schema.json`.
5. The schema will appear in the Wikibase schema editor. Review and adjust as needed.
6. Use **Edit Wikibase schema → Preview** to inspect the edits before uploading.

### Notes on `wikibase-item` columns

Columns mapped to `wikibase-item` properties (e.g. `instance_of`, `part_of`, `topic`) should contain
**reconciled values** — either Wikibase item IDs (e.g. `Q42`) or values that have been reconciled
against the Wikibase using OpenRefine's reconciliation feature.

## Validation tests performed

The following tests were run against the live Wikibase API on 2026-03-25:

| Test | Result |
|------|--------|
| MediaWiki API reachable | **PASS** |
| P1 label = "instance of" | **PASS** |
| P6 label = "subclass of" | **PASS** |
| `site_iri` matches API `wikibase-conceptbaseuri` | **PASS** |
| Reconciliation endpoint available | **WARN** — returned bot-check page |

## References

- [Write a Wikibase manifest](https://github.com/OpenRefine/OpenRefine/wiki/Write-a-Wikibase-manifest) — OpenRefine wiki
- [Wikibase manifests repository](https://github.com/OpenRefine/wikibase-manifests) — OpenRefine community manifests
- [wikibase-manifest-schema-v1.json](https://github.com/afkbrb/wikibase-manifest/blob/master/wikibase-manifest-schema-v1.json) — JSON schema for validation
- [OpenRefine Wikibase documentation](https://docs.openrefine.org/next/manual/wikibase/configuration) — configuration guide
