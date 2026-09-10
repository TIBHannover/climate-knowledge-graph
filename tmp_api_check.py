import requests, json
BASE = 'http://localhost:8080/w/api.php'
S = requests.Session(); H = {'User-Agent':'Mozilla/5.0'}
params = {'action':'query','meta':'allmessages','ammessages':'privacy|privacypage|aboutpage|disclaimerpage|disclaimers|terms','amlang':'en','format':'json','formatversion':'2'}
r = S.get(BASE, params=params, headers=H, timeout=30)
print(r.status_code)
print(r.text[:4000])
