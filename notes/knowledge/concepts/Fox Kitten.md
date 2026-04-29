# Fox Kitten

## What it is
Like a locksmith who breaks into buildings not to steal anything themselves, but to prop open the back door for a paying client — Fox Kitten is an Iranian state-sponsored threat actor (tracked as UNC757/Pioneer Kitten) that specializes in initial access brokering: compromising networks and selling or providing that access to other threat actors, including ransomware groups.

## Why it matters
In 2020, Fox Kitten exploited unpatched VPN vulnerabilities in Pulse Secure, Fortinet, and Citrix (CVE-2019-11510, CVE-2018-13379) to breach U.S. government and defense contractors. Defenders responded by prioritizing VPN patch cadence and hunting for webshells deployed as persistence mechanisms — a textbook example of why externally-facing infrastructure is the highest-priority attack surface.

## Key facts
- **Attribution**: Linked to Iranian intelligence; active since approximately 2017, targeting sectors including IT, defense, government, healthcare, and finance.
- **Primary TTPs**: Exploitation of known CVEs in VPN appliances and network devices, deployment of custom webshells (FRAMPTON, TALENTS), and use of legitimate tools like ngrok for tunneling.
- **Initial Access Broker role**: Fox Kitten has been observed collaborating with ransomware affiliates (e.g., NoEscape, Ransomhouse), monetizing access rather than solely conducting espionage.
- **MITRE ATT&CK alignment**: Heavily maps to T1190 (Exploit Public-Facing Application) and T1505.003 (Web Shell).
- **Defense priority**: Rapid patching of perimeter VPN/gateway devices and monitoring for anomalous outbound tunneling traffic are the primary mitigations flagged by CISA advisories.

## Related concepts
[[Initial Access Broker]] [[VPN Exploitation]] [[Webshell]] [[Advanced Persistent Threat]] [[CVE-2019-11510]]