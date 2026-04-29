# MOVEit

## What it is
Think of MOVEit like a bank's pneumatic tube system for wiring money between branches — it's specifically designed to move valuable cargo securely and leave a receipt. MOVEit Transfer is a managed file transfer (MFT) platform developed by Progress Software, used by organizations to automate and audit the transfer of sensitive files between internal systems, partners, and customers. It supports SFTP, SCP, and HTTPS protocols with built-in compliance logging.

## Why it matters
In May–June 2023, the Cl0p ransomware group exploited a critical SQL injection vulnerability (CVE-2023-34362) in MOVEit Transfer's web-facing interface, deploying a web shell called LEMURLOOT to exfiltrate data from hundreds of organizations before patches existed. This became one of the largest mass-exploitation events in history, hitting government agencies, financial institutions, and universities simultaneously — not through ransomware encryption, but pure data theft and extortion. It demonstrated how a single vulnerability in a widely-used supply chain tool can create cascading breaches across unrelated organizations.

## Key facts
- **CVE-2023-34362**: A SQL injection flaw in MOVEit's HTTP/S interface allowing unauthenticated remote code execution — CVSS score 9.8 (Critical)
- **Cl0p** (also written "Clop") exploited this as a **zero-day**, meaning victims had no patch available at time of exploitation
- The attack vector was the **public-facing web interface** of MOVEit, not internal network access — internet exposure was the critical risk factor
- Organizations affected include **the BBC, British Airways, Shell, and the U.S. Department of Energy** — over 2,500 victims estimated
- Mitigation involved **blocking HTTP/HTTPS traffic** to MOVEit, applying emergency patches, and auditing for LEMURLOOT web shell artifacts

## Related concepts
[[SQL Injection]] [[Web Shell]] [[Supply Chain Attack]] [[Zero-Day Vulnerability]] [[Managed File Transfer]]