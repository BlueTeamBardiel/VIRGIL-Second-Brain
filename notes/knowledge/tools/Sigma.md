# Sigma

## What it is
Think of Sigma as a universal recipe card for threat detection — just as a recipe written in English can be cooked in any kitchen worldwide, a Sigma rule written once can be converted into queries for Splunk, Elastic, Microsoft Sentinel, or any other SIEM. Sigma is an open, vendor-neutral signature format for describing log-based detection rules using YAML syntax. It abstracts the *what to detect* away from the *how each platform searches*, solving the fragmentation problem across security tools.

## Why it matters
During a ransomware investigation, a threat hunter finds a detection rule for Cobalt Strike beacon activity shared on GitHub as a Sigma rule. Instead of manually rewriting the logic for their specific Splunk environment, they run it through a Sigma converter (`sigmac` or `pySigma`) and deploy it in minutes — what would have taken hours of SIEM-specific query writing becomes a one-line command. This dramatically accelerates threat intelligence operationalization.

## Key facts
- Sigma rules are written in **YAML** and describe detection logic using fields like `title`, `logsource`, `detection`, and `condition`
- The **MITRE ATT&CK** framework is commonly referenced in Sigma rules via the `tags` field (e.g., `attack.t1059`), enabling technique-level mapping
- Rules are converted to platform-specific query languages using tools like **`sigmac`** (legacy) or **`pySigma`** (current standard)
- Sigma is to **log detection** what Snort/Suricata rules are to **network traffic detection** — both are open, shareable, community-maintained signature formats
- The **SigmaHQ GitHub repository** is the canonical community library containing thousands of curated, peer-reviewed detection rules

## Related concepts
[[SIEM]] [[MITRE ATT&CK]] [[Threat Intelligence]] [[YARA]] [[Detection Engineering]]