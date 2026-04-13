
import csv

replacement_map = {
    "Technical Summary": "This chapter provides a technical summary of the assessment report, detailing the core scientific, technical, and socio-economic findings across all domains assessed.",
    "Summary for Policymakers": "This summary presents the key findings of the assessment in a non-technical format, intended to inform policymakers and guide climate action.",
    "Strengthening and Implementing the Global Response": "This chapter evaluates options for strengthening and implementing global responses to climate change, emphasizing policy frameworks, capacity building, and sustainable transition.",
    "Desertification": "This chapter explores the relationship between climate change and desertification, assessing the drivers, risks, and strategies for sustainable land management in arid regions.",
    "Land degradation": "This chapter assesses the drivers and impacts of land degradation exacerbated by climate change, alongside potential mitigation and adaptation responses.",
    "Changing Ocean, Marine Ecosystems, and Dependent Communities": "This chapter reviews the impacts of climate change on ocean systems, marine biodiversity, and the human communities that rely on marine resources.",
    "Linking Global to Regional Climate Change": "This chapter connects global climate change projections to regional climatic impacts, evaluating downscaling methodologies and localized climate phenomena.",
    "Atlas": "The Atlas maps the spatial distribution of key climate variables, offering visual representations of observed and projected global and regional climate changes.",
    "Food, Fibre and Other Ecosystem Products": "This chapter assesses climate change impacts on the production of food, fibre, and other ecosystem services, evaluating risks to global food security and agriculture.",
    "Asia": "This chapter assesses the specific climate change impacts, vulnerabilities, and adaptation strategies across various sub-regions in Asia.",
    "North America": "This chapter evaluates observed and projected climate impacts across North America, focusing on related risks and adaptation measures.",
    "Biodiversity Hotspots": "This section highlights the vulnerabilities of global biodiversity hotspots to climate change, emphasizing species loss risks and conservation priorities.",
    "Cities and Settlements by the Sea": "This chapter assesses the unique vulnerabilities of coastal cities and settlements to sea-level rise and extreme climate events, along with adaptation options.",
    "Deserts, Semiarid Areas and Desertification": "This cross-chapter paper investigates the amplified vulnerabilities of deserts and semiarid regions to climate change and specific desertification risks.",
    "Mediterranean Region": "This section explores the distinct climate challenges facing the Mediterranean region, including compound risks from drought, heat, and altered precipitation.",
    "Polar Regions": "This chapter covers the significant and rapid changes occurring in polar regions due to climate change, including ice loss and impacts on native ecosystems.",
    "Tropical Forests": "This section assesses climate impacts on tropical forest ecosystems, analyzing risks of deforestation, ecological shifts, and the implications for carbon sinks.",
    "Key Risks across Sectors and Regions": "This chapter aggregates and synthesizes the critical climate risks across various societal sectors and geographical regions, assessing their multi-dimensional impacts.",
    "Climate Resilient Development Pathways": "This chapter details integrated pathways for climate-resilient development, aligning mitigation, adaptation, and sustainable development goals.",
    "Introduction and Framing": "This chapter introduces the structural framework and core concepts guiding the assessment report on climate change mitigation and adaptation.",
    "Urban Systems and Other Settlements": "This chapter examines the role of urban systems in climate mitigation, addressing emissions trends, infrastructure development, and policy interventions.",
    "Buildings": "This chapter analyzes greenhouse gas emissions from the buildings sector and explores pathways for rapid decarbonization and energy efficiency improvements.",
    "Cross-sectoral Perspectives": "This section provides a cross-sectoral analysis of climate change impacts and mitigation options, highlighting interdependencies and synergistic responses.",
    "National and Sub-national Policies and Institutions": "This chapter evaluates the effectiveness and design of national and sub-national climate policies, institutions, and governance structures.",
    "International Cooperation": "This chapter explores the status and role of international cooperation and mechanisms in facilitating global climate change mitigation and adaptation.",
    "Investment and Finance": "This chapter analyzes the financial flows and investments required for climate action, assessing gaps and mechanisms for scaling up climate finance.",
    "Innovation, Technology Development and Transfer": "This chapter investigates the critical role of technological innovation and transfer in enabling effective global climate responses and emission reductions.",
    "Accelerating the Transition in the Context of Sustainable Development": "This chapter investigates the systemic changes and enabling conditions needed to accelerate the transition to sustainable, low-carbon societies."
}

rows = []
modified_count = 0
with open("data/doi/ar6-doi-validation.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    fields = list(reader.fieldnames)
    for row in reader:
        desc = row.get("description", "")
        if "summary is not available" in desc:
            title = row["title"].strip()
            if title in replacement_map:
                new_desc = replacement_map[title]
                if len(new_desc) > 250:
                    print(f"WARNING: Title \"{title}\" description is > 250 chars!")
                row["description"] = new_desc
                modified_count += 1
            else:
                print(f"No mapping found for title: {title}")
        rows.append(row)

with open("data/doi/ar6-doi-validation.csv", "w", encoding="utf-8", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(rows)

print(f"Replaced {modified_count} descriptions.")

