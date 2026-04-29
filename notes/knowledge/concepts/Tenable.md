# Tenable

## What it is
Think of Tenable like a building inspector who walks every floor of your skyscraper before a burglar does, cataloguing every cracked lock and broken window. Tenable is a cybersecurity company best known for **Nessus**, the industry-standard vulnerability scanner, and its enterprise platform **Tenable.io / Tenable.sc**, which continuously scans networks, systems, and cloud environments to identify and prioritize vulnerabilities before attackers exploit them.

## Why it matters
In 2021, organizations running unpatched Confluence servers were rapidly compromised via CVE-2021-26084. Teams with Tenable deployed received authenticated scan results flagging the vulnerability within hours of the advisory, allowing patch prioritization before mass exploitation. Organizations without continuous scanning discovered the breach only after threat actors had already established persistence.

## Key facts
- **Nessus** is the most widely deployed vulnerability scanner globally; Tenable spun it into commercial products while keeping a free **Nessus Essentials** tier (limited to 16 IPs)
- **Tenable.sc** (formerly SecurityCenter) is the on-premises enterprise platform; **Tenable.io** is the cloud-based equivalent — both aggregate scan data into risk-scored dashboards
- Uses **CVSS scores** combined with threat intelligence to calculate **Vulnerability Priority Rating (VPR)**, helping teams focus on exploitable vulns, not just high CVSS scores
- Supports **credentialed vs. uncredentialed scans** — credentialed scans log into hosts and find far more vulnerabilities (missing patches, misconfigurations) than port-based uncredentialed scans
- **Tenable OT Security** (formerly Tenable.ot) extends scanning to operational technology/ICS environments, critical for utilities and manufacturing

## Related concepts
[[Vulnerability Scanning]] [[Nessus]] [[CVSS Scoring]] [[Credentialed vs Uncredentialed Scanning]] [[Patch Management]]