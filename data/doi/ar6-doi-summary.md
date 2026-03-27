# AR6 DOI Validation Summary

- Validated file: `data/doi/ar6-doi-validation.csv`
- Total DOIs checked: 95
- Valid: 95
- Invalid / Not found: 0

## Unique publishers (from CrossRef)
- Cambridge University Press
- Intergovernmental Panel on Climate Change (IPCC)

## Sample of validated DOIs and titles (first 12)

1. 10.1017/9781009157940 — Global Warming of 1.5°C
2. 10.1017/9781009157940.001 — Summary for Policymakers
3. 10.1017/9781009157940.002 — Technical Summary
4. 10.1017/9781009157940.003 — Framing and Context
5. 10.1017/9781009157940.004 — Mitigation Pathways Compatible with 1.5°C in the Context of Sustainable Development
6. 10.1017/9781009157940.005 — Impacts of 1.5°C Global Warming on Natural and Human Systems
7. 10.1017/9781009157940.006 — Strengthening and Implementing the Global Response
8. 10.1017/9781009157940.007 — Sustainable Development, Poverty Eradication and Reducing Inequalities
9. 10.1017/9781009157988 — Climate Change and Land
10. 10.1017/9781009157988.001 — Summary for Policymakers
11. 10.1017/9781009157988.002 — Technical Summary
12. 10.1017/9781009157988.003 — Framing and context

## Notes
- The CrossRef `published` field was returned as an array by the API; the validator script preserved the raw structure as `System.Object[]`. If you want precise publication dates, I can update the script to extract `date-parts` into a YYYY-MM-DD string.

Generated: 2026-03-27
