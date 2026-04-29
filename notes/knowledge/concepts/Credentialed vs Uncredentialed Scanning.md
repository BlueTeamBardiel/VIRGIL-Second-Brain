# Credentialed vs Uncredentialed Scanning

## What it is
Think of a building inspector who either has a master key (credentialed) or must judge the building's safety only from the sidewalk (uncredentialed). Credentialed scanning provides the scanner with valid login credentials to authenticate directly to target systems, allowing deep inspection of installed software, patches, and configurations. Uncredentialed scanning probes systems externally, inferring vulnerabilities only from exposed network services and responses.

## Why it matters
An organization runs monthly uncredentialed scans and feels confident — but an attacker with stolen credentials exploits an unpatched local privilege escalation vulnerability that was never visible from the network perimeter. A credentialed scan would have enumerated the exact software version and flagged the missing patch, closing the gap before exploitation.

## Key facts
- Credentialed scans produce significantly fewer false positives because they read actual registry entries, package managers, and file versions rather than guessing from banners
- Uncredentialed scans are prone to **false negatives** — vulnerabilities exist but aren't detected because the scanner lacks internal visibility
- Credentialed scanning requires careful **least-privilege account management**; the scanning credential itself becomes a high-value attack target if compromised
- On the Security+/CySA+ exam, credentialed scans are associated with **agent-based** scanning (software installed locally) or providing credentials directly to the scanner console
- CVSS scores don't change based on scan type, but **exploitability** context and remediation prioritization heavily depend on whether internal configuration data was collected

## Related concepts
[[Vulnerability Scanning]] [[Agent-Based vs Agentless Scanning]] [[False Positives and False Negatives]] [[Patch Management]] [[Least Privilege]]