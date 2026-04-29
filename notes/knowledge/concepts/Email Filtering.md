# Email Filtering

## What it is
Think of email filtering as a bouncer at a club with a clipboard — checking every message against a list of rules before deciding who gets through the door, who gets redirected to the velvet rope (quarantine), and who gets thrown out entirely. Technically, it is the process of analyzing inbound and outbound email messages using rule-based, heuristic, and reputation-based techniques to detect and block spam, phishing, malware, and policy violations before they reach end users.

## Why it matters
In a 2023 Business Email Compromise (BEC) scenario, attackers spoofed a CFO's email domain to request a $240,000 wire transfer. A properly configured email gateway with DMARC enforcement and anomaly-based filtering would have flagged the spoofed sender domain and quarantined the message before it ever reached the accounts payable team — preventing the loss entirely.

## Key facts
- **SPF, DKIM, and DMARC** are the three core email authentication protocols; DMARC enforces policy when SPF/DKIM checks fail (quarantine or reject)
- **Content filtering** scans message body and attachments for malicious payloads, keywords, and suspicious URLs using signatures and heuristics
- **Reputation-based filtering** blocks mail from IP addresses or domains with known poor sending histories, maintained by threat intelligence feeds
- **Secure Email Gateways (SEGs)** sit inline between the internet and the mail server, acting as an MX record intermediary — distinct from native cloud filtering like Microsoft Defender for Office 365
- **Data Loss Prevention (DLP)** integrated with email filtering can block outbound emails containing PII, credit card numbers, or intellectual property matching regex patterns

## Related concepts
[[Phishing]] [[DMARC]] [[Data Loss Prevention]] [[Secure Email Gateway]] [[Business Email Compromise]]