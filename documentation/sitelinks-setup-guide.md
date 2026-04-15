# Wikibase Sitelinks Setup Guide

This guide explains how to register a MediaWiki site with a Wikibase instance so that Wikibase items can be linked to wiki pages via sitelinks. It is written for the **ClimateKG** project but the steps are generic and apply to any Wikibase deployment.

## Background

A **sitelink** connects a Wikibase item (e.g. `Q42`) to a specific page on a registered MediaWiki site. Before a sitelink can be created, the MediaWiki site must be:

1. Registered in the MediaWiki **sites table** (database).
2. Declared as an allowed **sitelink group** in the Wikibase PHP configuration.
3. Assigned a human-readable **label** in the UI.

The three files that drive this configuration are:

| File | Purpose |
|---|---|
| `sites.xml` | Defines the site(s) to import into the sites table |
| `LocalSettings.sitelinks.php` | PHP settings enabling the sitelink group |
| `WikibaseSitelinksMessages.php` | i18n labels for the sitelink group in the UI |

---

## Step 1 — Choose a Site ID

Pick a short, lowercase, unique identifier for the wiki. This value is used as both the **global site ID** and the **sitelink group name**. It must match across all three configuration files and the database.

For the ClimateKG project the site ID is:

```
climatekgwiki
```

---

## Step 2 — Create the Site Definition File (`sites.xml`)

The XML file describes the site to be imported. Replace `<WIKI_BASE_URL>` with the public base URL of your wiki (e.g. `https://dev-climatekg.semanticclimate.org`).

```xml
<?xml version="1.0"?>
<sites version="1.0">
  <site type="mediawiki">
    <globalid>climatekgwiki</globalid>
    <group>climatekgwiki</group>
    <localid type="interwiki">climatekgwiki</localid>
    <path type="link"><WIKI_BASE_URL>/wiki/$1</path>
    <path type="page_path"><WIKI_BASE_URL>/wiki/$1</path>
    <path type="file_path"><WIKI_BASE_URL>/w/$1</path>
  </site>
</sites>
```

Key attributes:

- `globalid` — unique identifier used by Wikibase when resolving sitelinks.
- `group` — must match the value declared in `$wgWBRepoSettings['siteLinkGroups']`.
- `path type="link"` — URL template for article links; `$1` is replaced with the page name.
- `path type="file_path"` — URL template for the MediaWiki script path.

---

## Step 3 — Configure Wikibase PHP Settings

Add the following to `LocalSettings.php` (or to a dedicated include file that is sourced from `LocalSettings.php`):

```php
<?php
// Allow the climatekgwiki group to be used for sitelinks
$wgWBRepoSettings['siteLinkGroups'] = [ 'climatekgwiki' ];

// Register the i18n label file for the sitelink group
$wgExtensionMessagesFiles['WikibaseSitelinks'] = __DIR__ . '/WikibaseSitelinksMessages.php';

// Tell the Wikibase client the global ID of this wiki
$wgWBClientSettings['siteGlobalID'] = 'climatekgwiki';

// Point the client back to the repo (when repo and client are the same instance)
$wgWBClientSettings['repoUrl']         = $wgServer;
$wgWBClientSettings['repoScriptPath']  = '/w';
$wgWBClientSettings['repoArticlePath'] = '/wiki/$1';
```

> **Note:** If the Wikibase repo and client are separate MediaWiki instances, set `repoUrl`, `repoScriptPath`, and `repoArticlePath` to point to the repo instance rather than `$wgServer`.

---

## Step 4 — Add UI Labels (`WikibaseSitelinksMessages.php`)

Without this file the sitelink group heading in the Wikibase item UI will show a raw message key (e.g. `⧼wikibase-sitelinks-climatekgwiki⧽`).

Create `WikibaseSitelinksMessages.php` alongside `LocalSettings.php`:

```php
<?php
$messages = [];

$messages['en'] = [
    'wikibase-sitelinks-climatekgwiki' => 'ClimateKG wiki',
    'wikibase-group-climatekgwiki'     => 'climatekgwiki',
];
```

Add further language keys as needed for additional interface languages.

---

## Step 5 — Import the Site into the Database

MediaWiki ships with a maintenance script that reads `sites.xml` and writes the site record to the `sites` database table.

Run from the MediaWiki root directory (typically `/var/www/html`):

```bash
php maintenance/run.php importSites /path/to/sites.xml
```

On older MediaWiki versions (before 1.40) use the legacy script path:

```bash
php maintenance/importSites.php /path/to/sites.xml
```

Expected output:

```
Importing site climatekgwiki ...
Done.
```

Verify the record was written:

```bash
php maintenance/run.php sql --query \
  "SELECT site_global_key, site_group, site_language FROM sites WHERE site_global_key = 'climatekgwiki';"
```

---

## Step 6 — Set the Site Language

The `site_language` column must not be empty or null; if it is, the sitelink view in the item editor will fail to render correctly. Set it with a direct SQL update via the maintenance script:

```bash
php maintenance/run.php sql --query \
  "UPDATE sites SET site_language = 'en' \
   WHERE site_global_key = 'climatekgwiki' \
   AND (site_language IS NULL OR site_language = '');"
```

Replace `'en'` with the appropriate BCP 47 language code for the wiki.

---

## Step 7 — Reload the Application

PHP configuration changes (Steps 3 and 4) are not picked up until the PHP process cache is cleared or the web server is restarted.

```bash
# For Apache
sudo systemctl reload apache2

# For Nginx + PHP-FPM
sudo systemctl reload php8.x-fpm
sudo systemctl reload nginx
```

---

## Step 8 — Verify Sitelinks Are Working

### 8a — Check the Special:Sites page

Navigate to:

```
https://<WIKI_BASE_URL>/wiki/Special:Sites
```

The entry for `climatekgwiki` should appear in the table.

### 8b — Test SetSiteLink

Navigate to:

```
https://<WIKI_BASE_URL>/wiki/Special:SetSiteLink
```

- **Item ID**: enter any existing item (e.g. `Q1`)
- **Site ID**: enter `climatekgwiki`
- **Page name**: enter the name of a page that exists on the wiki

If the save succeeds without the error "site ID climatekgwiki is unknown", sitelinks are correctly configured.

### 8c — Confirm via item view

Open the item in the Wikibase UI. The "Sitelinks" section should display a heading **ClimateKG wiki** (from Step 4) and allow adding links.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `site ID climatekgwiki is unknown` on SetSiteLink | Site not in DB, or PHP cache stale | Re-run Step 5; reload web server (Step 7) |
| Sitelink heading shows `⧼wikibase-sitelinks-climatekgwiki⧽` | i18n file missing or not included | Check Step 3 and Step 4; verify file path |
| SetSiteLink saves but link renders broken | Wrong URL paths in `sites.xml` | Re-import `sites.xml` with corrected paths (Step 5) |
| `site_language` error in logs | `site_language` column is null | Re-run Step 6 |

---

## Summary of Files

```
LocalSettings.php          ← add require_once for sitelinks config
LocalSettings.sitelinks.php ← Wikibase sitelink group settings
WikibaseSitelinksMessages.php ← UI labels for the group
sites.xml                  ← site definition to import into the DB
```

All four files should be placed in (or accessible from) the MediaWiki installation root so that relative `__DIR__` references resolve correctly.
