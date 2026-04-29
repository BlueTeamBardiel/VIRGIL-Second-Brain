# Hannotog

## What it is
Like a silent groundskeeper who unlocks back doors and props them open before the main crew arrives, Hannotog is a backdoor malware used as a stager — establishing persistent access and preparing the environment for follow-on payloads. Technically, it is a sophisticated backdoor attributed to the Chinese state-sponsored threat actor APT41 (also tracked as Winnti), designed to maintain long-term covert access to compromised networks while downloading and executing additional malicious tools.

## Why it matters
In observed APT41 intrusions against healthcare and technology companies, Hannotog was deployed early in the attack chain to establish persistence and create a foothold before the more destructive Speculoos backdoor or Cobalt Strike beacons were dropped. This staging behavior allowed attackers to quietly maintain access for months while conducting reconnaissance, making it a textbook example of why defenders must hunt for low-and-slow persistence mechanisms — not just active exploitation.

## Key facts
- Attributed to **APT41 (Winnti/Barium)**, a Chinese threat group known for both espionage and financially motivated operations
- Functions as a **first-stage backdoor/stager**, primarily tasked with persistence establishment and downloading secondary payloads
- Achieves persistence via **Windows services and registry run keys**, common techniques mapped to MITRE ATT&CK T1543.003 and T1547.001
- Communicates with C2 infrastructure using **encrypted channels**, making network-based detection difficult without SSL inspection
- Observed in campaigns targeting **healthcare, telecoms, and technology sectors** — industries holding high-value IP and PII
- Often used in conjunction with **Speculoos**, another APT41 backdoor, as part of a layered intrusion toolkit

## Related concepts
[[APT41]] [[Backdoor Malware]] [[Persistence Mechanisms]] [[Command and Control (C2)]] [[Speculoos]]