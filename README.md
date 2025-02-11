# Climate Knowledge Graph

## A publishing knowledge graph for UN IPCC reports

### A software development project

Coordinator and lead, contact: Simon Worthington, [simon.worthington@tib.eu](mailto:simon.worthington@tib.eu). 2025-02-11

The project is to build a ‘publishing’ knowledge graph for the UN [IPCC Assessment Reports](https://www.ipcc.ch/report/sixth-assessment-report-cycle/). The knowledge graph would be used for frictionless dissemination of the reports, and include:

* cataloguing the literature corpora;   
* word search;   
* content publishing and reuse, and   
* address the needs of the IPCC. 

The technology used is Wikibase, Jupyter Notebooks, \#semanticClimate software, and TIB services: Wikibase4Reseach, Computational Publishing Services, Terminology Services (Antelope), Open Research Knowledge Graph (ORKG), Renate, and PID and Metadata services.

The IPCC reports are the gold standard of climate science, but the publishing is not machine readable, only being released as PDF and some HTML. The solution to this issue is to semantically structure the content as many semi-structured pre-existing parts just need connecting — authors, data, citations, and glossaries, etc.

The goal would be to have the UN IPCC Assessment Report 6 (AR6) available for public use. The *‘*publishing’ knowledge graph allows for queries that can collated and exported publications. See prototypes: [IPCC Glossary](https://tibhannover.github.io/semantic-glossar/ipcc-terms.html) and [City Climate Change Plans: Open Climate Reader](https://semanticclimate.github.io/city-open-climate-reader/).

The project is based on a cooperation with [‘\#semanticClimate’](https://docs.google.com/document/d/1ihhso6gfldWFdR1o8pP0W7Orbk7j2zcMCwyfv-qN1wY/edit) an open research community and TIB Wikibase4Reseach services run by the Consortium for Research Data on Material and Immaterial Cultural Heritage (NFDI4Culture) team at the Open Science Lab — TIB, in cooperation with Lab Knowledge Infrastructures — TIB. Partners are National Institute of Plant Genome Research (NIPGR), Delhi, India.

The following has been prepared for semantification of the UN IPCC Assessment Report 6: TDM conversion to HTML of all [70 chapters](https://github.com/semanticClimate/ipcc/tree/main/cleaned_content), [2000 climate terms aligned with Wikidata](https://github.com/petermr/semanticClimate/blob/main/ipcc/ar6/test/total_glossary/glossaries/total/acronyms_wiki.csv), and extraction of the [Glossary of 600 terms](https://vivliostyle.vercel.app/#src=https://raw.githubusercontent.com/semanticClimate/glossary-demo/main/ipccglossary.jsonld) by team \#semanticClimate.

The project is guided by the [UNESCO Recommendation on Open Science](https://unesdoc.unesco.org/ark:/48223/pf0000379949.locale=en) principles and values: quality and integrity, collective benefit, equity and fairness, and diversity and inclusiveness.

Goals and outcomes

* Create a sustainable service to support the IPCC in their work  
* Import all of IPCC Assessment Report 6 (AR6) into Wikibase with a granular LOD data model.  
* Co-create prototypes with IPCC that address their core needs and challenges.  
* Connect the Jupyter Notebooks publishing pipeline to Wikibase for search and republishing with CSS Paged Media styles.  
* Demonstrate the importance of digital capability — upskilling — for knowledge organisation and access to address Climate Change.  
* Explore the cost and benefit financials of ‘Opportunity Cost’ where semantification is of use for a legacy corpora to create increased access for industry, policy, and public use.  
* Focus TIB services Wikibase4Reseach to use the Wikibase LOD resource being created to demonstrate use value.    
* Using trustable AI. Machine learning forms the foundation of many tools used in the semantification space and Open Science based AI will be explored in the project. 


