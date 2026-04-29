# Threat Intelligence Feed

## What it is
Like a live traffic report that warns you about accidents before you hit them, a threat intelligence feed is a continuous stream of data about active threats — malicious IPs, domains, file hashes, and attack patterns — sourced from external providers and ingested into your security tools in real time. It transforms reactive defense into anticipatory defense by giving your SIEM, firewall, or EDR system up-to-the-minute adversary context.

## Why it matters
In 2020, during the SolarWinds supply chain attack, organizations subscribed to threat intelligence feeds that published the malicious Sunburst backdoor's command-and-control domains (e.g., `avsvmcloud[.]com`) were able to block outbound traffic to those endpoints and detect compromised hosts before manual investigation would have caught them. Those without feeds had no automated tripwire — they were flying blind.

## Key facts
- Feeds are categorized by type: **tactical** (IOCs like IPs and hashes), **operational** (TTPs and campaign details), and **strategic** (geopolitical threat actor trends)
- Common feed formats include **STIX** (Structured Threat Information Expression) and **TAXII** (Trusted Automated Exchange of Intelligence Information) — STIX is the language, TAXII is the transport protocol
- Sources include commercial providers (Recorded Future, CrowdStrike), open-source feeds (AlienVault OTX, Abuse.ch), and government-backed sharing communities like **ISACs**
- Feed quality is measured by **timeliness**, **accuracy**, and **relevance** — a feed full of stale IPs creates alert fatigue and false positives
- On the CySA+ exam, threat intelligence feeds are directly tied to **indicator of compromise (IOC)** management and **threat hunting** workflows

## Related concepts
[[Indicators of Compromise]] [[STIX/TAXII]] [[SIEM]] [[Threat Hunting]] [[Information Sharing and Analysis Centers (ISACs)]]