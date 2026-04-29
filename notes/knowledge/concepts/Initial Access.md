# initial access

## What it is
Like a burglar finding the one unlocked window in an otherwise secure house, initial access is the moment an attacker first gains a foothold inside a target environment. It represents the first phase of active compromise — the transition from reconnaissance to execution — and encompasses every technique used to breach the perimeter, from phishing emails to exploiting public-facing applications.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors achieved initial access by injecting malicious code into a software build pipeline, causing approximately 18,000 organizations to voluntarily download a trojanized update. This case illustrates why defenders must monitor not just their own perimeter but also the integrity of trusted third-party software — because initial access doesn't always look like an attack.

## Key facts
- MITRE ATT&CK TA0001 catalogs initial access with techniques including phishing (T1566), valid accounts (T1078), and exploit public-facing application (T1190)
- Phishing is consistently the #1 initial access vector, appearing in over 36% of breaches according to Verizon DBIR data
- Valid accounts (stolen credentials) are particularly dangerous because they generate little anomalous traffic — the attacker looks like a legitimate user
- Drive-by compromise (T1189) delivers malware when a victim simply visits a malicious or compromised website, requiring zero interaction beyond browsing
- Initial access is distinct from execution — gaining a foothold does not automatically mean malicious code is running; establishing persistence often follows

## Related concepts
[[phishing]] [[supply chain attack]] [[exploit public-facing application]] [[valid accounts]] [[MITRE ATT&CK]]