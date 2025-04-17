# Climate Knowledge Graph

## A publishing knowledge graph for UN IPCC reports

\#ClimateKG 🌏🌍🌎

Climate Knowledge Graph is an R\&D project hosted at TIB – Leibniz Information Centre for Science and Technology and organised partnership with \#semanticClimate.

Git repository: [https://github.com/TIBHannover/climate-knowledge-graph](https://github.com/TIBHannover/climate-knowledge-graph)

Project lead: Simon Worthington, Open Science Lab, TIB, Hanover – e-mail: [simon.worthington@tib.eu](mailto:simon.worthington@tib.eu) | Mastodon: [https://openbiblio.social/@mrchristian](https://openbiblio.social/@mrchristian)

Project status: 12 month development phase to start in May 2025 supported by TIB.

Climate Knowledge Graph (ClimateKG) mission is to support the dissemination of the IPCC Reports.

The IPCC is the Intergovernmental Panel on Climate Change and is a body of the United Nations. The IPCC Reports are one of the definitive climate change science and policy knowledge sources – which map out pathways into a future where the harmful effects of climate are potentially mitigated.

Currently IPCC Reports are published as PDF and, with some reports available as webpages.

The ClimateKG project will create a knowledge graph of the reports, initially with the open access parts of *IPCC Sixth Assessment Report (AR6)*, to provide two open web resources for others to use: firstly, a modern open web index for searching IPCC Reports, and: secondly a publishing engine that can package search results. A knowledge graph is a database that precisely describes entities and relationships, enabling search and logical reasoning, for example if the following question was asked:

‘How to design a city climate action plan to mitigate against extreme weather such as floods and fires — what are the mitigation policy options — and where are the authoring scientists geographically based?’.

ClimateKG would be able to return a search result that gives links to all the related IPCC Report chapters, but also provide a list of authors, their global locations, the related research paper citations used in the report — all as neat search results and as a full text publication package. The derivative publications would be automatically typeset, available multi-format, and as semantically marked up outputs.

ClimateKG specialised in semantic and linked open data enrichment of large scale fixed scientific corpora using RDF/Semantic Web design models and Wikibase/data technology to create model open science based indexing and cataloguing.

## Roadmap

| Task area | Status | Link | Q1 | Q2 | Q3 | Q4 |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| 1\. AR6 report as semantified HTML w/IDs | Alpha | [Git](https://github.com/petermr/amilib/tree/pmr_aug/test/resources/ipcc/cleaned_content) | X |  |  |  |
| 2\. Table of contents of AR6 70 chapters | Alpha | [Git](https://github.com/semanticClimate/internship_sC/tree/MEBIN/TOC) | X |  |  |  |
| 3\. IPCC Glossary (800 terms) to Wikibase (WB) | Done | [WB](https://climatekg.semanticclimate.net/index.php?title=IPCC_Begriffe) | X |  |  |  |
| 4\. Data relationship model | Pre-alpha | [WB](https://kg-ipclimatec-reports.wikibase.cloud/wiki/Main_Page) | X | X |  |  |
| 5\. Infrastructure | Done | NA |  |  |  |  |
| 6\. Publishing pipeline | Production | [Git](https://nfdi4culture.de/services/details/computational-publishing-service.html) |  | X |  |  |
| 7\. ClimateKG \- Index Service (dev) | Prototype (PoC) | [WB](https://kg-ipclimatec-reports.wikibase.cloud/wiki/Main_Page) |  | X | X |  |
| 8\. ClimateKG \- Publishing Service (dev) | Prototype (PoC) | [Git](https://semanticclimate.github.io/city-open-climate-reader/) |  |  | X | X |
| 9\. Software: Dictionaries, machine learning, etc | Production | [JN](https://colab.research.google.com/github/semanticClimate/sC-tools-demo/blob/main/TTWW_demo_sC_tools.ipynb) |  | X |  |  |
| 10\. PDF/Web to HTML Corpus Transformer | Prod./Custom | [Git](https://github.com/petermr/amilib) |  |  |  |  |

## Background

ClimateKG comes directly out of the five year old \#semanticClimate (\#sC) open research group founded by Dr. Gitanjali Yadav of the National Institute of Plant Genome Research (NIPGR), Delhi, Dr Peter Murray-Rust of Cambridge University, and Simon Worthington which works on software tool development for semantic enrichment. \#semanticClimate is active on a daily basis as a community and NIPGR supports an India wide internship programme, hackathon series, and youth outreach programme. Additionally \#sC presents globally from Beijing, Montevideo, to Berlin.

* Web: [https://semanticclimate.github.io/](https://semanticclimate.github.io/)  
* Journal Article: Worthington, Simon, Gitanjali Yadav, Shweata Hegde, Renu Kumari, Neeraj Kumari, and Peter Murray-Rust. 2024\. ‘The \#SemanticClimate Community: Making Open-Source Software for Knowledge Liberation’. *Annals of Library and Information Studies* 71 (4): 480–95. [https://doi.org/10.56042/alis.v71i4.14285](https://doi.org/10.56042/alis.v71i4.14285).

TIB is a global hub for knowledge graph R\&D, service development, and infrastructure provision — especially the [Open Research Knowledge Graph](https://orkg.org/) (ORKG). ClimateKG partners with and is supported in knowledge graph expertise by Lab Knowledge Infrastructures led by Dr Markus Stocker. At TIB ClimateKG is based in the Open Science Lab and makes use of expertise from the NFDI4Culture (cultural heritage consortium of the larger German National Research Data Infrastructure Consortium) projects: Wikibase4Research, Computational Publishing Service, and Antelope (terminology service).

* [Open Research Knowledge Graph](https://orkg.org/) (ORKG)  
* [Lab Knowledge Infrastructures](https://www.tib.eu/en/research-development/research-groups-and-labs/knowledge-infrastructures)  
* [Open Science Lab](https://www.tib.eu/en/research-development/research-groups-and-labs/open-science)  
* [NFDI4Culture](https://nfdi4culture.de/) (cultural heritage consortium of the larger German National Research Data Infrastructure Consortium)  
* [Wikibase4Research](https://nfdi4culture.de/services/details/wikibase4research.html)  
* [Computational Publishing Service](https://nfdi4culture.de/de/dienste/details/computational-publishing-service.html)  
* [Antelope](https://service.tib.eu/annotation/) (terminology service)

Thank you for support and contributions to TIB colleagues and \#semanticClimate members, interns, and hackathon participants.