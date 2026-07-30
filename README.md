# Climate Knowledge Graph (ClimateKG)

ClimateKG is a climate science literature resource intended for use by the public, policymakers, and scientists. Knowledge graph software is used to help navigate complex corpora, answer questions, and access documents.

To start with ClimateKG has imported the 10,000 page corpus [IPCC Sixth Assessment Report (AR6)](https://www.ipcc.ch/assessment-report/ar6/).

## Foundational datasets

AR6 was broken down into five foundational datasets and imported into ClimateKG:

1. Corpus full text & structure -- 7,524,958 words; 2,153 image files; 88 chapters
2. Bibliographic information -- 95 DOIs
3. Glossary -- 1,274 terms
4. Acronyms -- 1,910
5. Authors -- 932

The knowledge graph breaks text corpora into datasets and connects the data. For example, a question such as:

> 'How many South American or Indian authors contributed to the report?'

The knowledge graph knows the answer and can retrieve the relevant chapter texts:

> 'AR6 author distribution is 71 from South America and 43 from India.'

ClimateKG connects these datasets using an **entity-relationship model**, forming the **knowledge graph**:

```
WORK  <---- Corpus full text & structure
 +-- REPORT_SERIES
      +-- REPORT  <---- Bibliographic information
           |      <---- Glossary
           |      <---- Acronyms
           +-- TEXT_DIVISION
                +-- CHAPTER  <---- Authors
                             <---- Bibliographic information
                             <---- Corpus full text
```

## Platform

- **ClimateKG:** Browse the full text and data, including full text, foundational datasets, and community data.
- **ClimateKG Data Bench:** Data analysis and visualisation -- a platform that enables the community to enrich the corpus, analyse the contents, share results, and use AI LLMs and modern data science tools.

## Activities

- **Document distribution:** The data provides a map of the internal structure of the corpus documents, enabling any section or piece of data to be retrieved and delivered to the user.
- **Extended metadata:** Questions can be answered quickly and reliably. Metadata is distributed to library systems and the Data Commons on Wikidata.
- **Citizen science:** ClimateKG collaborates with Youth Data Champions interns from the #SemanticClimate organisation on a global scale.
- **Data science community:** Contributors can enrich the corpus while maintaining the integrity of the original documents.

## Dcoumentation and Roadmap 

[Documentation and Development Log](https://tibhannover.github.io/climate-knowledge-graph/) 

See: [Roadmap](https://tibhannover.github.io/climate-knowledge-graph/roadmap.html)

## Funding and support

ClimateKG has been funded by TIB Innovation fund.

ClimateKG is an R&D project hosted at [TIB](https://www.tib.eu/en) -- Leibniz Information Centre for Science and Technology and University Library -- Germany, in partnership with [#semanticClimate](https://semanticclimate.github.io/p/en/) and the National Institute of Plant Genome Research [(NIPGR)](https://nipgr.ac.in/nipgrv2/index.html) -- India.

## Background

ClimateKG comes out of the #semanticClimate (#sC) open research group founded by Dr. Gitanjali Yadav of [NIPGR](https://nipgr.ac.in/home/home.php), Delhi, Dr Peter Murray-Rust of Cambridge University, and Simon Worthington (TIB). #semanticClimate supports an India-wide internship programme, hackathon series, and youth outreach programme.

Web: [https://semanticclimate.github.io/](https://semanticclimate.github.io/)

TIB is one of the largest science libraries in the world and a global hub for knowledge graph R&D, especially the [Open Research Knowledge Graph](https://orkg.org/) (ORKG). ClimateKG partners with Lab Knowledge Infrastructures led by Dr Markus Stocker, and draws on expertise from NFDI4Culture projects: [Wikibase4Research](https://nfdi4culture.de/services/details/wikibase4research.html), [Computational Publishing Service](https://nfdi4culture.de/de/dienste/details/computational-publishing-service.html), and [Antelope](https://service.tib.eu/annotation/) (terminology service).

## Team

**TIB Team:** Project lead, Simon Worthington -- [simon.worthington@tib.eu](mailto:simon.worthington@tib.eu) | Mastodon: [@mrchristian](https://openbiblio.social/@mrchristian) | Laura Oldenbourg -- data modeling and publishing specialist. With support from Markus Stocker, lead of Lab Knowledge Infrastructures.

Thank you for support and contributions to TIB colleagues and #semanticClimate members, volunteers, interns, and hackathon participants.

## Copyright and licences

### IPCC Reports

The Climate Knowledge Graph imports content from the seven reports of the IPCC Sixth Assessment Report (AR6) cycle. Reports 1--6 are published by Cambridge University Press under [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 (CC BY-NC-ND 4.0)](https://creativecommons.org/licenses/by-nc-nd/4.0/). Report 7 (the Synthesis Report) is published by the IPCC directly with all rights reserved; short extracts may be reproduced with full source attribution. See also the [IPCC copyright notice](https://www.ipcc.ch/copyright/).

---

**1. Global Warming of 1.5°C (SR15)**
Special Report on the impacts of global warming of 1.5°C above pre-industrial levels.
Copyright © 2018 Intergovernmental Panel on Climate Change (IPCC).
Published by Cambridge University Press.
License: [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
DOI: [10.1017/9781009157940](https://doi.org/10.1017/9781009157940) | [Report](https://www.ipcc.ch/sr15/)

---

**2. Climate Change and Land (SRCCL)**
Special Report on climate change, desertification, land degradation, sustainable land management, food security, and greenhouse gas fluxes in terrestrial ecosystems.
Copyright © 2019 Intergovernmental Panel on Climate Change (IPCC).
Published by Cambridge University Press.
License: [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
DOI: [10.1017/9781009157988](https://doi.org/10.1017/9781009157988) | [Report](https://www.ipcc.ch/report/srccl/)

---

**3. The Ocean and Cryosphere in a Changing Climate (SROCC)**
Special Report on observed and projected changes to the ocean and cryosphere and their impacts.
Copyright © 2019 Intergovernmental Panel on Climate Change (IPCC).
Published by Cambridge University Press.
License: [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
DOI: [10.1017/9781009157964](https://doi.org/10.1017/9781009157964) | [Report](https://www.ipcc.ch/report/srocc/)

---

**4. Climate Change 2021: The Physical Science Basis (AR6 WGI)**
Working Group I contribution to the Sixth Assessment Report.
Copyright © 2021 Intergovernmental Panel on Climate Change (IPCC).
Published by Cambridge University Press.
License: [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
DOI: [10.1017/9781009157896](https://doi.org/10.1017/9781009157896) | [Report](https://www.ipcc.ch/report/sixth-assessment-report-working-group-i/)

---

**5. Climate Change 2022: Impacts, Adaptation and Vulnerability (AR6 WGII)**
Working Group II contribution to the Sixth Assessment Report.
Copyright © 2022 Intergovernmental Panel on Climate Change (IPCC).
Published by Cambridge University Press.
License: [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
DOI: [10.1017/9781009325844](https://doi.org/10.1017/9781009325844) | [Report](https://www.ipcc.ch/report/sixth-assessment-report-working-group-ii/)

---

**6. Climate Change 2022: Mitigation of Climate Change (AR6 WGIII)**
Working Group III contribution to the Sixth Assessment Report.
Copyright © 2022 Intergovernmental Panel on Climate Change (IPCC).
Published by Cambridge University Press.
License: [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
DOI: [10.1017/9781009157926](https://doi.org/10.1017/9781009157926) | [Report](https://www.ipcc.ch/report/sixth-assessment-report-working-group-3/)

---

**7. Climate Change 2023: Synthesis Report (AR6 SYR)**
Synthesis Report integrating findings from the three Working Group reports and three Special Reports.
Copyright © Intergovernmental Panel on Climate Change, 2023.
ISBN: 978-92-9169-164-7
Published by the IPCC.
License: All rights reserved. The right of publication in print, electronic and any other form and in any language is reserved by the IPCC. Short extracts from this publication may be reproduced without authorization provided that the complete source is clearly indicated. Requests to publish, reproduce or translate should be addressed to: IPCC c/o WMO, 7bis avenue de la Paix, P.O. Box 2300, CH-1211 Geneva 2, Switzerland. E-mail: IPCC-Sec@wmo.int
DOI: [10.59327/IPCC/AR6-9789291691647](https://doi.org/10.59327/IPCC/AR6-9789291691647) | [Report](https://www.ipcc.ch/report/sixth-assessment-report-cycle/)

## Data

ClimateKG data is licensed under [Creative Commons Zero v1.0 Universal (CC0 1.0)](https://creativecommons.org/publicdomain/zero/1.0/) -- dedicated to the public domain.

## Code of ClimateKG

Code in this repository is licensed under the [GNU General Public License v3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.html). See [LICENSE](LICENSE).

## Design and fonts of ClimateKG

Fonts are licensed under the [SIL Open Font License (OFL)](https://openfontlicense.org/).

Design assets are licensed under [Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/).


---

[![TIB – Leibniz Information Centre for Science and Technology](images/tib-logo.png)](https://www.tib.eu/en)&nbsp;&nbsp;&nbsp;[![#semanticClimate](images/semanticclimate-logo.jpg)](https://semanticclimate.github.io/p/en/)

