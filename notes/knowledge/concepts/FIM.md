# FIM

## What it is
Like a librarian who memorizes the exact weight of every book and notices instantly when a page has been torn out or added, File Integrity Monitoring watches over critical system files by recording cryptographic hashes and alerting when those hashes change. FIM continuously or periodically compares the current state of files against a known-good baseline to detect unauthorized modifications. It answers the question: *has anything been tampered with?*

## Why it matters
During the Target breach investigation, attackers modified memory-scraping malware on POS systems — a robust FIM solution monitoring those endpoints could have flagged the changed binaries before 40 million card numbers were exfiltrated. FIM is also a mandatory control under PCI DSS Requirement 11.5, meaning retailers and payment processors must deploy it or fail compliance audits. Defenders use it to detect rootkits, web shell drops, and ransomware staging activity before full detonation.

## Key facts
- FIM generates a **cryptographic hash** (typically SHA-256) of each monitored file and stores it in a secure baseline database for comparison
- **PCI DSS Requirement 11.5** explicitly mandates FIM on critical system files, configuration files, and content files
- FIM can operate in **real-time (agent-based)** or **scheduled scan** modes — real-time catches changes faster but consumes more resources
- Common monitored targets: `/etc/passwd`, `/etc/shadow`, Windows registry hives, web root directories, and kernel modules
- FIM alone does **not prevent** changes — it detects and alerts; response is a separate process
- Tools include **Tripwire** (the original FIM tool), OSSEC, Wazuh, and built-in options like Windows File Auditing

## Related concepts
[[Integrity]] [[HIDS]] [[Log Management]] [[Baseline Configuration]] [[PCI DSS]]