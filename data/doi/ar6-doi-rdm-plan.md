# AR6 DOI Validation — RDM Plan

**Updated:** 2026-03-30 (Previous: 2026-03-29)

## Overview

- Source CSV: data/doi/ar6-doi-validation.csv
- Total DOIs checked: 95

## Data summary

### Types

Type | Count
--- | ---
book-chapter | 82
monograph | 5
other | 4
report | 2
edited-book | 1
report-component | 1

### Top publishers

Publisher | Count
--- | ---
Cambridge University Press | 92
Intergovernmental Panel on Climate Change (IPCC) | 3

### OpenAlex coverage

- OpenAlex IDs found: 95 / 95
- Not in OpenAlex: 0
- Lookup strategies used: OpenAlex API using direct URL endpoints (see data/doi/fetch_openalex.py).
- Nearly all IPCC book-chapters and monographs are indexed in OpenAlex.

### Copyright and Access Profile

License | Count
--- | ---
cc-by | 75
cc-by-nc-nd | 15
No license specified | 3
public-domain | 1
other-oa | 1

Open Access Status | Count
--- | ---
bronze | 68
hybrid | 18
green | 4
gold | 4
closed | 1

## Data management and reuse

- DOI metadata retrieved from CrossRef via data/doi/validate_dois.ps1.
- Publication dates fetched from CrossRef via data/doi/fetch_dates.py (Replaced data/doi/fetch_pub_dates.ps1).
- OpenAlex IDs retrieved via data/doi/fetch_openalex.py.
- Description cleanup and merging performed via data/doi/merge_desc_py.py and data/doi/update_descriptions.py.
- All scripts are included in data/doi/ for reproducibility.

## Full list of DOIs and metadata

DOI | Type | Published | Title | Publisher | Status | CrossRef URL | OpenAlex ID
--- | --- | --- | --- | --- | --- | --- | ---
10.1017/9781009157940 | monograph | 2022-06-09 | Global Warming of 1.5°C | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940 | https://openalex.org/W4281382652
10.1017/9781009157940.001 | other | 2022-06-09 | Summary for Policymakers | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940.001 | https://openalex.org/W4281385918
10.1017/9781009157940.002 | other | 2022-06-09 | Technical Summary | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940.002 | https://openalex.org/W4281400632
10.1017/9781009157940.003 | book-chapter | 2022-06-09 | Framing and Context | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940.003 | https://openalex.org/W4281383245
10.1017/9781009157940.004 | book-chapter | 2022-06-09 | Mitigation Pathways Compatible with 1.5°C in the Context of Sustainable Development | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940.004 | https://openalex.org/W4281383849
10.1017/9781009157940.005 | book-chapter | 2022-06-09 | Impacts of 1.5°C Global Warming on Natural and Human Systems | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940.005 | https://openalex.org/W4281384098
10.1017/9781009157940.006 | book-chapter | 2022-06-09 | Strengthening and Implementing the Global Response | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940.006 | https://openalex.org/W2935948450
10.1017/9781009157940.007 | book-chapter | 2022-06-09 | Sustainable Development, Poverty Eradication and Reducing Inequalities | Cambridge University Press | OK | https://doi.org/10.1017/9781009157940.007 | https://openalex.org/W2902431294
10.1017/9781009157988 | monograph | 2022-12-08 | Climate Change and Land | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988 | https://openalex.org/W4309402431
10.1017/9781009157988.001 | other | 2022-12-08 | Summary for Policymakers | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.001 | https://openalex.org/W4309372022
10.1017/9781009157988.002 | other | 2022-12-08 | Technical Summary | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.002 | https://openalex.org/W4309402493
10.1017/9781009157988.003 | book-chapter | 2022-12-08 | Framing and context | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.003 | https://openalex.org/W4309402413
10.1017/9781009157988.004 | book-chapter | 2022-12-08 | Land–climate interactions | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.004 | https://openalex.org/W3092635909
10.1017/9781009157988.005 | book-chapter | 2022-12-08 | Desertification | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.005 | https://openalex.org/W4309402514
10.1017/9781009157988.006 | book-chapter | 2022-12-08 | Land degradation | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.006 | https://openalex.org/W4309402409
10.1017/9781009157988.007 | book-chapter | 2022-12-08 | Food security | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.007 | https://openalex.org/W4309402428
10.1017/9781009157988.008 | book-chapter | 2022-12-08 | Interlinkages between desertification, land degradation, food security and greenhouse gas fluxes: Synergies, trade-offs and integrated response options | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.008 | https://openalex.org/W4309402499
10.1017/9781009157988.009 | book-chapter | 2022-12-08 | Risk management and decision-making in relation to sustainable development | Cambridge University Press | OK | https://doi.org/10.1017/9781009157988.009 | https://openalex.org/W3002866211
10.1017/9781009157964 | monograph | 2022-05-19 | The Ocean and Cryosphere in a Changing Climate | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964 | https://openalex.org/W4210363077
10.1017/9781009157964.001 | book-chapter | 2022-05-19 | Summary for Policymakers | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.001 | https://openalex.org/W4210811321
10.1017/9781009157964.002 | book-chapter | 2022-05-19 | Technical Summary | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.002 | https://openalex.org/W4210767500
10.1017/9781009157964.003 | book-chapter | 2022-05-19 | Framing and Context of the Report | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.003 | https://openalex.org/W4210320361
10.1017/9781009157964.004 | book-chapter | 2022-05-19 | High Mountain Areas | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.004 | https://openalex.org/W4210731414
10.1017/9781009157964.005 | book-chapter | 2022-05-19 | Polar Regions | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.005 | https://openalex.org/W4210623669
10.1017/9781009157964.006 | book-chapter | 2022-05-19 | Sea Level Rise and Implications for Low-Lying Islands, Coasts and Communities | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.006 | https://openalex.org/W4210654828
10.1017/9781009157964.007 | book-chapter | 2022-05-19 | Changing Ocean, Marine Ecosystems, and Dependent Communities | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.007 | https://openalex.org/W4210691114
10.1017/9781009157964.008 | book-chapter | 2022-05-19 | Extremes, Abrupt Changes and Managing Risks | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.008 | https://openalex.org/W4210611443
10.1017/9781009157964.009 | book-chapter | 2022-05-19 | Integrative Cross-Chapter Box on Low-lying Islands and Coasts | Cambridge University Press | OK | https://doi.org/10.1017/9781009157964.009 | https://openalex.org/W4210459585
10.59327/IPCC/AR6-9789291691647 | report | 2023-07-25 | IPCC, 2023: Climate Change 2023: Synthesis Report. Contribution of Working Groups I, II and III to the Sixth Assessment Report of the Intergovernmental Panel on Climate Change [Core Writing Team, H. Lee and J. Romero (eds.)]. IPCC, Geneva, Switzerland. | Intergovernmental Panel on Climate Change (IPCC) | OK | https://doi.org/10.59327/ipcc/ar6-9789291691647 | https://openalex.org/W4385118605
10.59327/IPCC/AR6-9789291691647.001 | report-component | 2023-07-25 | IPCC, 2023: Climate Change 2023: Synthesis Report, Summary for Policymakers. Contribution of Working Groups I, II and III to the Sixth Assessment Report of the Intergovernmental Panel on Climate Change [Core Writing Team, H. Lee and J. Romero (eds.)]. IPCC, Geneva, Switzerland. | Intergovernmental Panel on Climate Change (IPCC) | OK | https://doi.org/10.59327/ipcc/ar6-9789291691647.001 | https://openalex.org/W4385123314
10.59327/IPCC/AR6-9789291691647 | report | 2023-07-25 | IPCC, 2023: Climate Change 2023: Synthesis Report. Contribution of Working Groups I, II and III to the Sixth Assessment Report of the Intergovernmental Panel on Climate Change [Core Writing Team, H. Lee and J. Romero (eds.)]. IPCC, Geneva, Switzerland. | Intergovernmental Panel on Climate Change (IPCC) | OK | https://doi.org/10.59327/ipcc/ar6-9789291691647 | https://openalex.org/W4385118605
10.1017/9781009157896 | monograph | 2023-07-06 | Climate Change 2021 – The Physical Science Basis | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896 | https://openalex.org/W4382363623
10.1017/9781009157896.001 | book-chapter | 2023-07-06 | Summary for Policymakers | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.001 | https://openalex.org/W4382358979
10.1017/9781009157896.002 | book-chapter | 2023-07-06 | Technical Summary | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.002 | https://openalex.org/W4382358677
10.1017/9781009157896.003 | book-chapter | 2023-07-06 | Framing, Context, and Methods | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.003 | https://openalex.org/W4382358721
10.1017/9781009157896.004 | book-chapter | 2023-07-06 | Changing State of the Climate System | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.004 | https://openalex.org/W4382358980
10.1017/9781009157896.005 | book-chapter | 2023-07-06 | Human Influence on the Climate System | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.005 | https://openalex.org/W3196490087
10.1017/9781009157896.006 | book-chapter | 2023-07-06 | Future Global Climate: Scenario-based Projections and Near-term Information | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.006 | https://openalex.org/W4382358676
10.1017/9781009157896.007 | book-chapter | 2023-07-06 | Global Carbon and Other Biogeochemical Cycles and Feedbacks | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.007 | https://openalex.org/W3207732688
10.1017/9781009157896.008 | book-chapter | 2023-07-06 | Short-lived Climate Forcers | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.008 | https://openalex.org/W4382358634
10.1017/9781009157896.009 | book-chapter | 2023-07-06 | The Earth’s Energy Budget, Climate Feedbacks and Climate Sensitivity | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.009 | https://openalex.org/W4382358731
10.1017/9781009157896.010 | book-chapter | 2023-07-06 | Water Cycle Changes | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.010 | https://openalex.org/W4382358556
10.1017/9781009157896.011 | book-chapter | 2023-07-06 | Ocean, Cryosphere and Sea Level Change | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.011 | https://openalex.org/W4382358495
10.1017/9781009157896.012 | book-chapter | 2023-07-06 | Linking Global to Regional Climate Change | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.012 | https://openalex.org/W3198347438
10.1017/9781009157896.013 | book-chapter | 2023-07-06 | Weather and Climate Extreme Events in a Changing Climate | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.013 | https://openalex.org/W3215426448
10.1017/9781009157896.014 | book-chapter | 2023-07-06 | Climate Change Information for Regional Impact and for Risk Assessment | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.014 | https://openalex.org/W4382358998
10.1017/9781009157896.021 | book-chapter | 2023-07-06 | Atlas | Cambridge University Press | OK | https://doi.org/10.1017/9781009157896.021 | https://openalex.org/W4382358618
10.1017/9781009325844 | monograph | 2023-06-22 | Climate Change 2022 – Impacts, Adaptation and Vulnerability | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844 | https://openalex.org/W4382362038
10.1017/9781009325844.001 | book-chapter | 2023-06-22 | Summary for Policymakers | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.001 | https://openalex.org/W4382363608
10.1017/9781009325844.002 | book-chapter | 2023-06-22 | Technical Summary | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.002 | https://openalex.org/W4382363579
10.1017/9781009325844.003 | book-chapter | 2023-06-22 | Point of Departure and Key Concepts | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.003 | https://openalex.org/W4382362865
10.1017/9781009325844.004 | book-chapter | 2023-06-22 | Terrestrial and Freshwater Ecosystems and Their Services | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.004 | https://openalex.org/W4382363505
10.1017/9781009325844.005 | book-chapter | 2023-06-22 | Oceans and Coastal Ecosystems and Their Services | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.005 | https://openalex.org/W4382363666
10.1017/9781009325844.006 | book-chapter | 2023-06-22 | Water | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.006 | https://openalex.org/W4382363526
10.1017/9781009325844.007 | book-chapter | 2023-06-22 | Food, Fibre and Other Ecosystem Products | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.007 | https://openalex.org/W4382363604
10.1017/9781009325844.008 | book-chapter | 2023-06-22 | Cities, Settlements and Key Infrastructure | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.008 | https://openalex.org/W4382363503
10.1017/9781009325844.009 | book-chapter | 2023-06-22 | Health, Wellbeing and the Changing Structure of Communities | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.009 | https://openalex.org/W4382361937
10.1017/9781009325844.010 | book-chapter | 2023-06-22 | Poverty, Livelihoods and Sustainable Development | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.010 | https://openalex.org/W2991859140
10.1017/9781009325844.011 | book-chapter | 2023-06-22 | Africa | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.011 | https://openalex.org/W4382361932
10.1017/9781009325844.012 | book-chapter | 2023-06-22 | Asia | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.012 | https://openalex.org/W4382362799
10.1017/9781009325844.013 | book-chapter | 2023-06-22 | Australasia | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.013 | https://openalex.org/W4382363397
10.1017/9781009325844.014 | book-chapter | 2023-06-22 | Central and South America | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.014 | https://openalex.org/W3109144505
10.1017/9781009325844.015 | book-chapter | 2023-06-22 | Europe | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.015 | https://openalex.org/W4382363568
10.1017/9781009325844.016 | book-chapter | 2023-06-22 | North America | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.016 | https://openalex.org/W4382363059
10.1017/9781009325844.017 | book-chapter | 2023-06-22 | Small Islands | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.017 | https://openalex.org/W4382363037
10.1017/9781009325844.018 | book-chapter | 2023-06-22 | Biodiversity Hotspots | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.018 | https://openalex.org/W4382363636
10.1017/9781009325844.019 | book-chapter | 2023-06-22 | Cities and Settlements by the Sea | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.019 | https://openalex.org/W4382361936
10.1017/9781009325844.020 | book-chapter | 2023-06-22 | Deserts, Semiarid Areas and Desertification | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.020 | https://openalex.org/W4382363669
10.1017/9781009325844.021 | book-chapter | 2023-06-22 | Mediterranean Region | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.021 | https://openalex.org/W4382363683
10.1017/9781009325844.022 | book-chapter | 2023-06-22 | Mountains | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.022 | https://openalex.org/W4382363207
10.1017/9781009325844.023 | book-chapter | 2023-06-22 | Polar Regions | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.023 | https://openalex.org/W4382361926
10.1017/9781009325844.024 | book-chapter | 2023-06-22 | Tropical Forests | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.024 | https://openalex.org/W4382361947
10.1017/9781009325844.025 | book-chapter | 2023-06-22 | Key Risks across Sectors and Regions | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.025 | https://openalex.org/W4382362903
10.1017/9781009325844.026 | book-chapter | 2023-06-22 | Decision-Making Options for Managing Risk | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.026 | https://openalex.org/W4382363544
10.1017/9781009325844.027 | book-chapter | 2023-06-22 | Climate Resilient Development Pathways | Cambridge University Press | OK | https://doi.org/10.1017/9781009325844.027 | https://openalex.org/W4382361919
10.1017/9781009157926 | edited-book | 2023-08-17 | Climate Change 2022 - Mitigation of Climate Change | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926 | https://openalex.org/W3216798413
10.1017/9781009157926.001 | book-chapter | 2023-08-17 | Summary for Policymakers | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.001 | https://openalex.org/W4385168292
10.1017/9781009157926.002 | book-chapter | 2023-08-17 | Technical Summary | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.002 | https://openalex.org/W4385229598
10.1017/9781009157926.003 | book-chapter | 2023-08-17 | Introduction and Framing | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.003 | https://openalex.org/W4385159767
10.1017/9781009157926.004 | book-chapter | 2023-08-17 | Emissions Trends and Drivers | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.004 | https://openalex.org/W4385228868
10.1017/9781009157926.005 | book-chapter | 2023-08-17 | Mitigation Pathways Compatible with Long-term Goals | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.005 | https://openalex.org/W4385160319
10.1017/9781009157926.006 | book-chapter | 2023-08-17 | Mitigation and Development Pathways in the Near to Mid-term | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.006 | https://openalex.org/W4385229201
10.1017/9781009157926.007 | book-chapter | 2023-08-17 | Demand, Services and Social Aspects of Mitigation | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.007 | https://openalex.org/W4315969330
10.1017/9781009157926.008 | book-chapter | 2023-08-17 | Energy Systems | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.008 | https://openalex.org/W4385162120
10.1017/9781009157926.009 | book-chapter | 2023-08-17 | Agriculture, Forestry and Other Land Uses (AFOLU) | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.009 | https://openalex.org/W4385159963
10.1017/9781009157926.010 | book-chapter | 2023-08-17 | Urban Systems and Other Settlements | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.010 | https://openalex.org/W4385168567
10.1017/9781009157926.011 | book-chapter | 2023-08-17 | Buildings | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.011 | https://openalex.org/W4385228992
10.1017/9781009157926.012 | book-chapter | 2023-08-17 | Transport | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.012 | https://openalex.org/W4385159924
10.1017/9781009157926.013 | book-chapter | 2023-08-17 | Industry | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.013 | https://openalex.org/W4385168299
10.1017/9781009157926.014 | book-chapter | 2023-08-17 | Cross-sectoral Perspectives | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.014 | https://openalex.org/W4385229562
10.1017/9781009157926.015 | book-chapter | 2023-08-17 | National and Sub-national Policies and Institutions | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.015 | https://openalex.org/W4385159746
10.1017/9781009157926.016 | book-chapter | 2023-08-17 | International Cooperation | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.016 | https://openalex.org/W4385168399
10.1017/9781009157926.017 | book-chapter | 2023-08-17 | Investment and Finance | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.017 | https://openalex.org/W4385228317
10.1017/9781009157926.018 | book-chapter | 2023-08-17 | Innovation, Technology Development and Transfer | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.018 | https://openalex.org/W4385168330
10.1017/9781009157926.019 | book-chapter | 2023-08-17 | Accelerating the Transition in the Context of Sustainable Development | Cambridge University Press | OK | https://doi.org/10.1017/9781009157926.019 | https://openalex.org/W4385228336

## Provenance and reproducibility

- Validator script: data/doi/validate_dois.ps1
- Type summary script: data/doi/summarize_doi_types.ps1
- OpenAlex checker: data/doi/fetch_openalex.py
- RDM plan generator: data/doi/generate_rdm_plan.ps1

## Licensing and access

- Metadata harvested from CrossRef (their terms apply).
- This RDM plan and validation CSV are released with the repository under the repository license.
