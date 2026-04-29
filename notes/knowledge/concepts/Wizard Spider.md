# Wizard Spider

## What it is
Think of a sophisticated crime family that rents out its muscle to other gangs while running its own heists on the side — that's Wizard Spider. It is a Russia-based financially motivated threat actor group responsible for developing and operating the TrickBot, Ryuk, and Conti malware ecosystems, functioning as both a criminal enterprise and a ransomware-as-a-service (RaaS) operator since at least 2016.

## Why it matters
In 2020, Wizard Spider launched coordinated Ryuk ransomware attacks against U.S. hospitals during the COVID-19 pandemic, encrypting patient records and demanding millions in ransom — the FBI issued an emergency alert calling it the most significant cyberthreat to U.S. healthcare at the time. Defenders responded by threat hunting for TrickBot's characteristic network scanning behavior and blocking its C2 infrastructure using published IOCs.

## Key facts
- **TrickBot** served as the primary initial access loader, harvesting credentials and enabling lateral movement before deploying Ryuk or Conti ransomware payloads
- Wizard Spider pioneered **double extortion** at scale — exfiltrating data before encrypting it, then threatening public release to pressure victims into paying
- The group operated **Conti as a RaaS platform**, leaking internal chat logs in 2022 revealed a corporate-style organizational structure with HR, management, and developer teams
- Uses **Cobalt Strike** beacons extensively for post-exploitation command-and-control, a common IOC signature defenders look for
- Linked to **MITRE ATT&CK Group G0102**; TTPs include spearphishing (T1566), credential dumping via Mimikatz (T1003), and service-based persistence (T1543)

## Related concepts
[[Ransomware-as-a-Service]] [[TrickBot]] [[Conti Ransomware]] [[Double Extortion]] [[Cobalt Strike]]