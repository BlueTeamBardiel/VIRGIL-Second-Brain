# ET OPEN

## What it is
Think of ET OPEN like a community-maintained field guide to criminal behavior patterns — the way ornithologists share bird identification notes so everyone can spot the same rare species. ET OPEN (Emerging Threats Open) is a free, publicly maintained ruleset for intrusion detection systems (IDS) like Snort and Suricata, containing signatures that identify known malicious network traffic patterns. It is developed by Proofpoint and continuously updated by the security community to detect threats such as malware command-and-control (C2) communication, exploit attempts, and scanning activity.

## Why it matters
During a ransomware investigation, a SOC analyst running Suricata with ET OPEN rules might receive an alert like `ET OPEN Trojan Cobalt Strike Beacon Checkin` — immediately flagging that an infected endpoint is communicating with an attacker's C2 server. Without this ruleset, that encrypted-looking beacon traffic would blend into normal HTTPS noise, buying the attacker critical dwell time to move laterally before detection.

## Key facts
- ET OPEN rules are written in the Snort rule syntax and are compatible with both **Snort** and **Suricata** IDS/IPS engines
- Rules are released under an **open-source license**, making them freely available — contrast with ET PRO, the commercial subscription version with faster, more comprehensive updates
- Each rule contains a **signature ID (SID)**, metadata fields, and a detection pattern (content match, PCRE, etc.) used to inspect packet payloads and headers
- ET OPEN is hosted and maintained by **Proofpoint's Emerging Threats** team with contributions from the broader community
- Rule categories include: malware, exploit kits, policy violations, DNS anomalies, and **Tor/proxy detection** — making it broad-spectrum rather than single-threat focused

## Related concepts
[[Snort]] [[Suricata]] [[Intrusion Detection System]] [[YARA Rules]] [[Network Security Monitoring]]