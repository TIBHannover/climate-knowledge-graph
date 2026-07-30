# Climate Knowledge Graph (ClimateKG)

ClimateKG is a climate science literature resource intended for use by the public, policymakers, and scientists. Knowledge graph software is used to help navigate complex corpora, answer questions, and access documents.

To start with ClimateKG has imported the 10,000 page corpus [IPCC Sixth Assessment Report (AR6)](https://www.ipcc.ch/assessment-report/ar6/).

## Foundational datasets

AR6 was broken down into six foundational datasets and imported into ClimateKG:

1. Corpus full text -- 7,524,958 words, 2,153 image files
2. Corpus structure -- 88 chapters
3. Bibliographic information -- 95 DOIs
4. Glossary -- 1,274 terms
5. Acronyms -- 1,910
6. Authors -- 932

The knowledge graph breaks text corpora into datasets and connects the data. For example, a question such as:

> 'How many South American or Indian authors contributed to the report?'

The knowledge graph knows the answer and can retrieve the relevant chapter texts:

> 'AR6 author distribution is 71 from South America and 43 from India.'

ClimateKG connects these datasets using an **entity-relationship model**, forming the **knowledge graph**:

```
WORK  <---- Corpus structure
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

## Roadmap

See: [Roadmap](https://tibhannover.github.io/climate-knowledge-graph/roadmap.html)

## Background

ClimateKG comes out of the #semanticClimate (#sC) open research group founded by Dr. Gitanjali Yadav of [NIPGR](https://nipgr.ac.in/home/home.php), Delhi, Dr Peter Murray-Rust of Cambridge University, and Simon Worthington (TIB). #semanticClimate supports an India-wide internship programme, hackathon series, and youth outreach programme.

- Web: [https://semanticclimate.github.io/](https://semanticclimate.github.io/)
- Worthington, Simon, et al. 2024. 'The #SemanticClimate Community: Making Open-Source Software for Knowledge Liberation'. *Annals of Library and Information Studies* 71 (4): 480-95. [https://doi.org/10.56042/alis.v71i4.14285](https://doi.org/10.56042/alis.v71i4.14285)

TIB is one of the largest science libraries in the world and a global hub for knowledge graph R&D, especially the [Open Research Knowledge Graph](https://orkg.org/) (ORKG). ClimateKG partners with Lab Knowledge Infrastructures led by Dr Markus Stocker, and draws on expertise from NFDI4Culture projects: [Wikibase4Research](https://nfdi4culture.de/services/details/wikibase4research.html), [Computational Publishing Service](https://nfdi4culture.de/de/dienste/details/computational-publishing-service.html), and [Antelope](https://service.tib.eu/annotation/) (terminology service).

**TIB Team:** Project lead, Simon Worthington -- [simon.worthington@tib.eu](mailto:simon.worthington@tib.eu) | Mastodon: [@mrchristian](https://openbiblio.social/@mrchristian) | Laura Oldenbourg -- data modeling and publishing specialist. With support from Markus Stocker, lead of Lab Knowledge Infrastructures.

--

ClimateKG has been funded by TIB Innovation fund.

ClimateKG is an R&D project hosted at [TIB](https://www.tib.eu/en) -- Leibniz Information Centre for Science and Technology and University Library -- Germany, in partnership with [#semanticClimate](https://semanticclimate.github.io/p/en/) and the National Institute of Plant Genome Research [(NIPGR)](https://nipgr.ac.in/nipgrv2/index.html) -- India.

[Documentation and Development Log](https://tibhannover.github.io/climate-knowledge-graph/) | [Git repository](https://github.com/TIBHannover/climate-knowledge-graph) | #ClimateKG

Thank you for support and contributions to TIB colleagues and #semanticClimate members, volunteers, interns, and hackathon participants.

