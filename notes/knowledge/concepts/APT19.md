# APT19

## What it is
Think of a locksmith who specializes in breaking into law firms — not to steal cash, but to photograph every confidential file before quietly locking the door again. APT19 (also known as Codoso Team or C0d0so0) is a Chinese state-sponsored threat actor assessed to conduct cyber espionage primarily targeting legal, investment, and financial sectors to steal intellectual property and sensitive business information.

## Why it matters
In 2017, APT19 launched a spear-phishing campaign against U.S. law firms and investment companies, delivering macro-enabled Word documents that deployed Cobalt Strike beacon payloads. Defenders who monitored for unusual outbound HTTPS traffic to uncommon domains and flagged macro execution in Office documents were able to detect the intrusion before significant data exfiltration occurred.

## Key facts
- **Primary targets:** Legal firms, financial institutions, and government contractors — industries holding high-value intellectual property
- **Initial access method:** Spear-phishing emails with weaponized Office documents using malicious macros (a classic T1566.001 in MITRE ATT&CK)
- **Tooling:** Frequently deploys Cobalt Strike, custom backdoors like HTRAN, and leverages living-off-the-land binaries (LOLBins) to blend with normal traffic
- **Attribution:** Assessed with moderate-high confidence to be affiliated with the Chinese government, operating since approximately 2010
- **Defense evasion:** Uses HTTPS for C2 communications to disguise malicious traffic as legitimate encrypted web traffic, complicating network-based detection

## Related concepts
[[Spear Phishing]] [[Cobalt Strike]] [[Living off the Land Binaries]] [[Command and Control (C2)]] [[MITRE ATT&CK Framework]]