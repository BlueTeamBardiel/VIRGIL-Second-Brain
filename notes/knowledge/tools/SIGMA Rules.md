# Sigma Rules

## What it is
Like a universal recipe card that any kitchen can follow regardless of brand of oven, Sigma Rules are a vendor-agnostic, open-source detection rule format that can be converted into queries for any SIEM platform (Splunk, Elastic, Microsoft Sentinel, etc.). They describe *what suspicious log activity looks like* in a standardized YAML syntax, decoupling the detection logic from any specific tool.

## Why it matters
During the 2021 Log4Shell exploitation wave, threat hunters needed to rapidly deploy detection logic across organizations running wildly different SIEM stacks. Sigma Rules allowed teams to write one rule detecting the malicious JNDI lookup strings in HTTP headers and compile it into Splunk SPL, KQL, or Elasticsearch queries within minutes — dramatically compressing detection deployment time across heterogeneous environments.

## Key facts
- Sigma is to log detection what Snort rules are to network traffic detection — a readable, shareable standard format
- Rules are written in **YAML** and contain fields: `title`, `logsource`, `detection`, `condition`, and `falsepositives`
- The `logsource` block specifies *where* to look (e.g., Windows Security Event Logs, web server logs), making rules platform-portable
- Tools like **sigmac** and **pySigma** serve as compilers, translating Sigma into platform-specific query languages
- Sigma rules are actively maintained in the community repository **SigmaHQ/sigma** on GitHub, making them a living threat intelligence resource relevant to CySA+ threat hunting objectives
- The `condition` field uses boolean logic (e.g., `keywords and not filter`) to define what constitutes a true positive match

## Related concepts
[[SIEM]] [[YARA Rules]] [[Threat Hunting]] [[Indicators of Compromise]] [[Log Analysis]]