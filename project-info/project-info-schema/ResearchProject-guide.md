# ResearchProject DTD — Filling Guide / Ausfüllhilfe

**Schema:** [schema.org/ResearchProject](https://schema.org/ResearchProject)  
**DTD file:** `ResearchProject.dtd`  
**Schema version:** 30.0 (2026-03-19)  
**Type hierarchy:** `Thing > Organization > Project > ResearchProject`

---

## Quick Start / Schnellstart

Reference the DTD at the top of your XML file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE ResearchProject SYSTEM "ResearchProject.dtd">
```

Then open your root element with a language declaration:

```xml
<!-- English instance -->
<ResearchProject xml:lang="en">
  ...
</ResearchProject>

<!-- German instance / Deutsche Instanz -->
<ResearchProject xml:lang="de">
  ...
</ResearchProject>
```

> **Only `name` is required.** All other elements are optional (`?` = 0 or 1, `*` = 0 or more).

---

## Root Element Attributes

| Attribute | Values | Description (EN) | Beschreibung (DE) |
|-----------|--------|------------------|-------------------|
| `xml:lang` | `en` \| `de` | Primary language of the document | Hauptsprache des Dokuments |
| `id` | any XML ID | Optional unique identifier for the element | Optionaler eindeutiger Bezeichner |
| `typeof` | fixed: `schema:ResearchProject` | RDF type — set automatically | RDF-Typ — wird automatisch gesetzt |
| `vocab` | fixed: `https://schema.org/` | Schema vocabulary — set automatically | Schema-Vokabular — wird automatisch gesetzt |

---

## Element Reference

### 1 · Core Identity / Kernidentität

#### `<name>` *(required / erforderlich)*

The primary name of the research project.

```xml
<name xml:lang="en">Quantum Materials Research Initiative</name>
<name xml:lang="de">Initiative zur Erforschung von Quantenmaterialien</name>
```

> Use `xml:lang` on individual elements to override the document-level language when providing multilingual values.

---

#### `<description>`

A full textual description of the project.

```xml
<description xml:lang="en">
  A four-year project investigating the electronic properties of 
  topological insulators at cryogenic temperatures.
</description>
```

---

#### `<alternateName>`

Abbreviations, acronyms, or other names the project is known by. Repeat the element for each alias.

```xml
<alternateName>QMRI</alternateName>
<alternateName xml:lang="de">IQEM</alternateName>
```

---

#### `<disambiguatingDescription>`

A short phrase (1–2 sentences) to distinguish this project from similar ones. Useful when names overlap.

```xml
<disambiguatingDescription xml:lang="en">
  Focuses on topological insulators, distinct from the QMRI-II project 
  which covers superconductors.
</disambiguatingDescription>
```

---

#### `<url>`

The canonical webpage for this project.

```xml
<url>https://example.org/research/qmri</url>
```

---

#### `<sameAs>`

Links to authoritative reference pages (Wikidata, ORCID, ROR, etc.). Repeat for each.

```xml
<sameAs>https://www.wikidata.org/wiki/Q12345678</sameAs>
<sameAs>https://ror.org/0abcdef12</sameAs>
```

---

#### `<identifier>`

Structured identifier using a property/value pair, or plain text/URL.

```xml
<!-- Plain text -->
<identifier>PROJ-2023-0042</identifier>

<!-- Structured (PropertyValue) -->
<identifier propertyID="grantNumber" value="ERC-2023-ADG-101234"/>
```

---

#### `<additionalType>`

A more specific type URI from an external vocabulary.

```xml
<additionalType>https://euroscivoc.europa.eu/thesaurus/100023</additionalType>
```

---

### 2 · Legal & Regulatory / Rechtliches & Regulatorisches

| Element | Format / Example | Notes (EN) | Hinweis (DE) |
|---------|-----------------|------------|--------------|
| `<legalName>` | `Max-Planck-Institut für Physik e.V.` | Registered organisation name | Eingetragener Organisationsname |
| `<taxID>` | `DE123456789` | National tax/fiscal ID | Nationale Steueridentifikationsnummer |
| `<vatID>` | `DE123456789` | VAT ID with country prefix | Umsatzsteuer-ID mit Länderpräfix |
| `<leiCode>` | `5299000J2N45DDNE4Y28` | 20-char ISO 17442 code | 20-stelliger ISO 17442-Code |
| `<duns>` | `123456789` | 9-digit D&B DUNS number | 9-stellige D&B DUNS-Nummer |
| `<globalLocationNumber>` | `4012345000009` | 13-digit GS1 GLN | 13-stellige GS1 GLN |
| `<isicV4>` | `7210` | ISIC Rev. 4 industry code | ISIC Rev. 4 Branchencode |
| `<naics>` | `541715` | North American industry code | Nordamerikanischer Branchencode |
| `<iso6523Code>` | `0199:LEI0abcdef12` | ISO 6523 formatted identifier | ISO 6523-formatierter Bezeichner |

---

### 3 · Dates / Datumsangaben

Use **ISO 8601** format: `YYYY-MM-DD`

```xml
<foundingDate>2023-01-15</foundingDate>
<dissolutionDate>2027-12-31</dissolutionDate>
```

---

### 4 · Contact & Location / Kontakt & Standort

#### `<address>`

```xml
<address xml:lang="de">
  <streetAddress>Boltzmannstraße 3</streetAddress>
  <addressLocality>Garching</addressLocality>
  <addressRegion>Bayern</addressRegion>
  <postalCode>85748</postalCode>
  <addressCountry>DE</addressCountry>
</address>
```

> `<addressCountry>` should use the **ISO 3166-1 alpha-2** code (e.g. `DE`, `US`, `FR`, `GB`).

---

#### `<contactPoint>`

```xml
<contactPoint>
  <contactType xml:lang="en">Administrative Contact</contactType>
  <telephone>+49 89 32905-0</telephone>
  <email>info@example.org</email>
  <url>https://example.org/contact</url>
  <availableLanguage>en</availableLanguage>
  <availableLanguage>de</availableLanguage>
  <areaServed>DE</areaServed>
</contactPoint>
```

---

#### `<location>`

Accepts free text, a structured `<address>`, a `<place>`, or a `<virtualLocation>`.

```xml
<!-- Physical place -->
<location>
  <place>
    <name>Max Planck Campus Garching</name>
    <address>
      <addressLocality>Garching</addressLocality>
      <addressCountry>DE</addressCountry>
    </address>
    <url>https://example.org/campus</url>
  </place>
</location>

<!-- Virtual / online -->
<location>
  <virtualLocation>
    <url>https://meet.example.org/qmri</url>
    <name xml:lang="en">Online Collaboration Platform</name>
  </virtualLocation>
</location>
```

---

### 5 · People & Structure / Personen & Struktur

#### `<founder>`

```xml
<founder typeof="schema:Person" href="https://orcid.org/0000-0001-2345-6789">
  Prof. Dr. Anna Müller
</founder>
```

#### `<employee>` / `<member>`

```xml
<employee href="https://orcid.org/0000-0002-3456-7890">Dr. James Smith</employee>
<member typeof="schema:Person" href="https://example.org/people/chen">Dr. Li Chen</member>
```

#### `<legalRepresentative>`

The person(s) legally authorised to act on behalf of the project/organisation.

```xml
<legalRepresentative href="https://example.org/people/mueller">
  Prof. Dr. Anna Müller
</legalRepresentative>
```

#### `<department>` / `<parentOrganization>` / `<subOrganization>`

```xml
<parentOrganization href="https://ror.org/01hhn8329">
  Max-Planck-Gesellschaft
</parentOrganization>

<department href="https://example.org/dept/phys">
  Department of Condensed Matter Physics
</department>
```

---

### 6 · Funding & Sponsorship / Förderung & Sponsoring

#### `<funder>`

The organisation or person providing financial support.

```xml
<funder typeof="schema:Organization" href="https://ror.org/0472cxd90">
  European Research Council
</funder>
```

#### `<funding>`

A specific grant associated with the project.

```xml
<funding>
  <name xml:lang="en">ERC Advanced Grant 2023</name>
  <identifier propertyID="grantNumber" value="ERC-2023-ADG-101234"/>
  <funder typeof="schema:Organization" href="https://ror.org/0472cxd90">
    European Research Council
  </funder>
  <url>https://cordis.europa.eu/project/id/101234</url>
</funding>
```

#### `<sponsor>`

Non-financial or in-kind support (differs from `funder`).

```xml
<sponsor typeof="schema:Organization">Helmholtz Association</sponsor>
```

---

### 7 · Discovery & Classification / Auffindbarkeit & Klassifizierung

#### `<keywords>`

Comma-separated or repeated per entry. Add `xml:lang` for multilingual keywords.

```xml
<keywords xml:lang="en">quantum materials, topological insulators, condensed matter</keywords>
<keywords xml:lang="de">Quantenmaterialien, topologische Isolatoren, Festkörperphysik</keywords>
```

#### `<knowsAbout>`

Topics or domains the project covers.

```xml
<knowsAbout xml:lang="en">Topological quantum computing</knowsAbout>
<knowsAbout>https://www.wikidata.org/wiki/Q12345</knowsAbout>
```

#### `<knowsLanguage>`

Languages used by the project team. Use **IETF BCP 47** codes.

```xml
<knowsLanguage languageCode="en">English</knowsLanguage>
<knowsLanguage languageCode="de">Deutsch</knowsLanguage>
```

---

### 8 · Media / Medien

#### `<logo>`

```xml
<!-- Simple URL -->
<logo>https://example.org/assets/qmri-logo.png</logo>

<!-- Full ImageObject -->
<logo>
  <imageObject>
    <contentUrl>https://example.org/assets/qmri-logo.png</contentUrl>
    <caption xml:lang="en">QMRI Project Logo</caption>
    <width>512</width>
    <height>512</height>
  </imageObject>
</logo>
```

#### `<image>`

Same structure as `<logo>` — used for general images rather than the brand logo.

---

### 9 · Certifications & Credentials / Zertifizierungen & Nachweise

#### `<hasCertification>`

```xml
<hasCertification>
  <name xml:lang="en">ISO 9001:2015 Quality Management</name>
  <certificationIdentification>ISO-9001-2015</certificationIdentification>
  <issuedBy href="https://example.org/certbody">TÜV SÜD</issuedBy>
  <certificationStatus>Active</certificationStatus>
  <validFrom>2024-01-01</validFrom>
  <validThrough>2027-01-01</validThrough>
</hasCertification>
```

#### `<hasCredential>`

```xml
<hasCredential>
  <name xml:lang="en">Open Research Data Certificate</name>
  <description xml:lang="en">Awarded for compliance with FAIR data principles.</description>
  <url>https://example.org/credentials/ord-42</url>
  <validFrom>2024-06-01</validFrom>
</hasCredential>
```

---

### 10 · Events & Reviews / Veranstaltungen & Bewertungen

#### `<event>`

```xml
<event>
  <name xml:lang="en">Annual Project Symposium 2025</name>
  <startDate>2025-09-10</startDate>
  <endDate>2025-09-12</endDate>
  <location>
    <place>
      <name>Ludwig Maximilian University, Munich</name>
      <address>
        <addressLocality>Munich</addressLocality>
        <addressCountry>DE</addressCountry>
      </address>
    </place>
  </location>
  <url>https://example.org/events/symposium2025</url>
</event>
```

#### `<review>`

```xml
<review>
  <reviewBody xml:lang="en">
    Highly commended for interdisciplinary approach and open data practices.
  </reviewBody>
  <reviewRating ratingValue="5" bestRating="5" worstRating="1"/>
  <author typeof="schema:Organization" href="https://example.org/review-panel">
    ERC Review Panel
  </author>
</review>
```

---

## Complete Minimal Examples / Vollständige Minimalbeispiele

### English (EN)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE ResearchProject SYSTEM "ResearchProject.dtd">
<ResearchProject xml:lang="en">
  <name>Quantum Materials Research Initiative</name>
  <description>
    A four-year project investigating novel quantum materials 
    at the interface of condensed matter physics and quantum computing.
  </description>
  <url>https://example.org/research/qmri</url>
  <foundingDate>2023-01-15</foundingDate>
  <dissolutionDate>2027-01-14</dissolutionDate>
  <funder typeof="schema:Organization" href="https://ror.org/0472cxd90">
    European Research Council
  </funder>
  <funding>
    <name>ERC Advanced Grant 2023</name>
    <identifier propertyID="grantNumber" value="ERC-2023-ADG-101234"/>
    <url>https://cordis.europa.eu/project/id/101234</url>
  </funding>
  <keywords xml:lang="en">quantum materials, topological insulators</keywords>
  <address>
    <streetAddress>Boltzmannstraße 3</streetAddress>
    <addressLocality>Garching</addressLocality>
    <postalCode>85748</postalCode>
    <addressCountry>DE</addressCountry>
  </address>
  <knowsLanguage languageCode="en">English</knowsLanguage>
  <knowsLanguage languageCode="de">Deutsch</knowsLanguage>
</ResearchProject>
```

### German (DE)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE ResearchProject SYSTEM "ResearchProject.dtd">
<ResearchProject xml:lang="de">
  <name>Initiative zur Erforschung von Quantenmaterialien</name>
  <description>
    Ein vierjähriges Projekt zur Untersuchung neuartiger Quantenmaterialien 
    an der Schnittstelle von Festkörperphysik und Quantencomputing.
  </description>
  <url>https://example.org/research/qmri</url>
  <foundingDate>2023-01-15</foundingDate>
  <dissolutionDate>2027-01-14</dissolutionDate>
  <funder typeof="schema:Organization" href="https://ror.org/0472cxd90">
    Europäischer Forschungsrat
  </funder>
  <funding>
    <name xml:lang="de">ERC Advanced Grant 2023</name>
    <identifier propertyID="Förderkennzeichen" value="ERC-2023-ADG-101234"/>
    <url>https://cordis.europa.eu/project/id/101234</url>
  </funding>
  <keywords xml:lang="de">Quantenmaterialien, topologische Isolatoren</keywords>
  <address xml:lang="de">
    <streetAddress>Boltzmannstraße 3</streetAddress>
    <addressLocality>Garching</addressLocality>
    <postalCode>85748</postalCode>
    <addressCountry>DE</addressCountry>
  </address>
  <knowsLanguage languageCode="de">Deutsch</knowsLanguage>
  <knowsLanguage languageCode="en">English</knowsLanguage>
</ResearchProject>
```

---

## Common Mistakes / Häufige Fehler

| Issue (EN) | Problem (DE) | Fix (EN) | Lösung (DE) |
|---|---|---|---|
| Missing `<name>` | Fehlendes `<name>` | Always include `<name>` — it is the only required element | `<name>` immer angeben — es ist das einzige Pflichtfeld |
| Wrong date format | Falsches Datumsformat | Use `YYYY-MM-DD` (ISO 8601) | `JJJJ-MM-TT` (ISO 8601) verwenden |
| Country as full name | Land als ausgeschriebener Name | Use ISO 3166-1 alpha-2 code (`DE`, `US`) | ISO 3166-1 alpha-2-Code verwenden (`DE`, `US`) |
| Duplicate element where only one allowed | Element doppelt angegeben, obwohl nur eines erlaubt | Check DTD `?` vs `*` — `?` = max 1, `*` = unlimited | DTD `?` vs. `*` prüfen: `?` = max. 1, `*` = beliebig viele |
| Missing `xml:lang` on text | Fehlendes `xml:lang` bei Text | Add `xml:lang="en"` or `xml:lang="de"` to each text element | `xml:lang="en"` oder `xml:lang="de"` zu Textelementen hinzufügen |
| `vatID` without country prefix | `vatID` ohne Länderpräfix | Prefix required: `DE123456789` not `123456789` | Präfix erforderlich: `DE123456789` statt `123456789` |

---

## Element Cardinality Reference / Kardinalitätsübersicht

| Symbol | Meaning (EN) | Bedeutung (DE) |
|--------|-------------|----------------|
| *(no symbol)* | Exactly 1 — **required** | Genau 1 — **Pflichtfeld** |
| `?` | 0 or 1 — optional, non-repeatable | 0 oder 1 — optional, nicht wiederholbar |
| `*` | 0 or more — optional, repeatable | 0 oder mehr — optional, wiederholbar |
| `+` | 1 or more — required, repeatable | 1 oder mehr — erforderlich, wiederholbar |

---

*Generated for `ResearchProject.dtd` · schema.org v30.0 · 2026-03-19*
