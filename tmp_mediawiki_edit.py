import json
import requests

BASE = 'http://localhost:8080/w/api.php'
S = requests.Session()
H = {'User-Agent': 'Mozilla/5.0'}

# 1) get login token and log in
r = S.get(BASE, params={'action': 'query', 'meta': 'tokens', 'type': 'login', 'format': 'json', 'formatversion': '2'}, headers=H, timeout=30)
r.raise_for_status()
logintoken = r.json()['query']['tokens']['logintoken']
login = S.post(BASE, data={'action': 'login', 'lgname': 'admin', 'lgpassword': 'adminpass123!', 'lgtoken': logintoken, 'format': 'json', 'formatversion': '2'}, headers=H, timeout=30)
login.raise_for_status()
print('LOGIN_RESULT', login.json()['login']['result'])

# 2) get CSRF token
r = S.get(BASE, params={'action': 'query', 'meta': 'tokens', 'type': 'csrf', 'format': 'json', 'formatversion': '2'}, headers=H, timeout=30)
r.raise_for_status()
csrf = r.json()['query']['tokens']['csrftoken']

# 3) update Main Page
page_text = '''__NOTOC__
<div class="climatekg-home-intro">

[[File:world.png|frameless|450x300px]]

=== '''ClimateKG''' is a community knowledge graph for climate change science literature. ===

==== The IPCC's Sixth Assessment Report (AR6) has been converted into structured data for metadata enrichment, document distribution, and data analysis. ClimateKG is open to policymakers, citizen science projects, and scientists. ====
'''[[Learn-More|Learn more]]'''
</div>

<div class="climatekg-home-grid">

<div class="climatekg-home-card">

'''Policymakers'''

IPCC AR6 is now browsable and machine-readable through APIs, open document formats, and structured access for evidence-based policy work.

'''[[IPCC:AR6|Browse Full Text]]'''
</div>

<div class="climatekg-home-card">
'''Citizen Science Projects'''

Youth citizen science activities are led by &#35;semanticClimate, with workshops, Wikidata curation, and public engagement across climate knowledge projects.

'''[[Citizen-Science|Explore Projects]]'''
</div>

<div class="climatekg-home-card">
'''Scientists'''

AR6 datasets are available through SPARQL, APIs, and XML, enabling researchers to query, contribute, and extend the knowledge graph through Wikibase and Data Bench.

'''[[IPCC-Data|Access Data]]'''
</div>
</div>

<div class="climatekg-footer">
* [[Data protection|Data protection]]
* [[Terms of Use|Terms of Use]]
* [[Imprint|Imprint]]
* [[Copyright and Licenses|Copyright and Licenses]]
</div>
'''

edit = S.post(BASE, data={'action':'edit','title':'Main_Page','text':page_text,'summary':'Update homepage and footer links','format':'json','formatversion':'2','token':csrf}, headers=H, timeout=30)
print('MAIN_EDIT', edit.status_code)
print(edit.text[:800])

# 4) create legal pages
legal_pages = {
    'Data protection': '== Data protection ==\n\nThis is a placeholder page for the ClimateKG data protection notice.\n\nThe page can be expanded with the project\'s final legal and privacy text.',
    'Terms of Use': '== Terms of Use ==\n\nThis is a placeholder page for the ClimateKG terms of use.\n\nThe page can be expanded with the project\'s final usage conditions.',
    'Imprint': '== Imprint ==\n\nThis is a placeholder page for the ClimateKG imprint.\n\nThe page can be expanded with the final institutional contact and legal information.',
    'Copyright and Licenses': '== Copyright and Licenses ==\n\nThis is a placeholder page for the ClimateKG copyright and licenses information.\n\nThe page can be expanded with the project\'s licensing details and rights statements.'
}
for title, text in legal_pages.items():
    resp = S.post(BASE, data={'action':'edit','title':title,'text':text,'summary':'Create placeholding legal page','format':'json','formatversion':'2','token':csrf}, headers=H, timeout=30)
    print(title, resp.status_code)
    print(resp.text[:500])
