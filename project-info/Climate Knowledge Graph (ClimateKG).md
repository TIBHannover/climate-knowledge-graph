### Climate Knowledge Graph (ClimateKG)

ClimateKG is a climate science literature resource intended for use by the public, policymakers, and scientists.

Knowledge graph software is used to help navigate complex corpora, answer questions, and access documents.

The IPCC Assessment Report (AR6) was broken down into six foundational datasets and imported into ClimateKG:

1. Corpus full text – 7,524,958 Words, 2,153 Image files  
2. Corpus structure – 88 Chapters  
3. Bibliographic information \- 95 DOIs   
4. Glossary – 1,274  
5. Acronyms – 1,910  
6. Authors – 932

The knowledge graph breaks text corpora into datasets and connects the data. For example, a question such as:

‘How many South American or Indian authors contributed to the report?’

The knowledge graph knows the answer and can retrieve the relevant chapter texts: 

'AR6 author distribution is 71 from South America and 43 from India.' 

ClimateKG is composed of a set of foundational datasets that describe a text corpus. The knowledge graph connects these data sets, enabling questions to be asked of the corpus and allowing data scientists to contribute and enrich data for ClimateKG.

Then, an **entity-relationship model** is used to connect the data sets, forming the **knowledge graph:**

`WORK  <──── Corpus structure`  
 `└── REPORT_SERIES`  
      `└── REPORT  <──── Bibliographic information`  
           `|      <──── Glossary`    
           `|      <──── Acronyms`    
           `└── TEXT_DIVISION`  
                `└── CHAPTER  <──── Authors`    
                             `<──── Bibliographic information`  
                             `<──── Corpus full text`

### The ClimateKG platform

* **ClimateKG:** Browse the full text and data, including full text, foundational datasets, and community data.

* **ClimateKG Data Bench:** Data analysis and visualisation – A platform that enables the community to enrich the corpus, analyse the contents, share results and use AI LLMs and modern data science tools. 

### ClimateKG activities

* **Document distribution:** The data provides a map of the internal structure of the corpus documents, enabling any section or piece of data to be retrieved and delivered to the user.

* **Extended metadata:** Questions can be answered quickly and reliably. Metadata is distributed to library systems and the Data Commons on Wikidata.

* **Citizen science:** ClimateKG collaborates with Youth Data Champions interns from the \#SemanticClimate organisation on a global scale.

* **Data science community:** Contributors can enrich the corpus while maintaining the integrity of the original documents. 