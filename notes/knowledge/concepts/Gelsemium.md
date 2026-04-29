# Gelsemium

## What it is
Like a surgeon who only operates once a year but never misses, Gelsemium is an advanced persistent threat (APT) group known for rare, precisely targeted cyberespionage campaigns. Active since at least 2014, it is a China-nexus threat actor that focuses on government, military, religious, and telecommunications targets across Southeast Asia and the Middle East.

## Why it matters
In 2021, Gelsemium was linked to a supply chain attack targeting a Southeast Asian government, where the group leveraged the ProxyLogon Microsoft Exchange vulnerability (CVE-2021-26855) to deploy a previously undocumented backdoor called "OwlProxy." This campaign demonstrated the group's ability to pivot from public exploits to custom-built malware, making them difficult to detect and attribute using standard signature-based tools.

## Key facts
- Gelsemium uses a modular malware ecosystem including **Gelsemine** (dropper), **Gelsenicine** (loader), and **Gelsevirine** (core plugin backdoor) — named after components of the poisonous gelsemium plant
- The group practices extreme operational discipline, deploying payloads only when confident in target value, which severely limits forensic evidence collection
- Attributed to China-nexus activity based on targeting patterns, TTPs, and infrastructure overlaps with other PRC-aligned groups
- Their malware can adapt based on Windows privilege level — automatically switching between a kernel driver and a user-mode DLL depending on available permissions
- Gelsemium has targeted religious organizations (including the Vatican network) in addition to traditional government and military sectors, reflecting likely intelligence collection tied to diplomatic interests

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Supply Chain Attack]] [[ProxyLogon]] [[Modular Malware]] [[Living off the Land (LotL)]]