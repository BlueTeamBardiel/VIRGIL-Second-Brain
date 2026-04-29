# LAB_HOST

## What it is
Like a thief who copies your house key while shaking your hand, LAB_HOST is a sophisticated credential-harvesting trojan that intercepts and exfiltrates authentication data during normal user activity. Specifically, LAB_HOST is a modular malware family attributed to the FIN7 threat group, designed to steal credentials, capture screenshots, and maintain persistent backdoor access on compromised Windows systems.

## Why it matters
In documented FIN7 campaigns targeting the hospitality and financial sectors, LAB_HOST was deployed after initial spearphishing compromise to silently harvest point-of-sale credentials and banking data over extended dwell periods averaging months. Defenders analyzing network traffic identified LAB_HOST's command-and-control communications by their distinctive HTTP header patterns and Base64-encoded beacon intervals — a signature now used in threat hunting rules.

## Key facts
- LAB_HOST is attributed to **FIN7** (also known as Carbanak Group), a financially motivated APT responsible for over $1 billion in losses globally
- Uses **modular architecture**, allowing operators to load additional plugins (keyloggers, screenshot capturers, lateral movement tools) post-infection
- Achieves **persistence** via scheduled tasks and Windows Registry Run keys — common MITRE ATT&CK techniques T1053 and T1547
- Communicates with C2 servers over **HTTP/HTTPS**, often masquerading as legitimate web traffic to evade perimeter detection
- Associated with **spearphishing attachments** as the primary delivery vector, frequently using weaponized Word documents with malicious macros

## Related concepts
[[FIN7]] [[Command and Control (C2)]] [[Credential Harvesting]] [[Spearphishing]] [[Persistence Mechanisms]]