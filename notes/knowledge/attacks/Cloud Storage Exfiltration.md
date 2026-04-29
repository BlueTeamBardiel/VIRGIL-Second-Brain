# Cloud Storage Exfiltration

## What it is
Think of cloud storage like a massive public library where anyone with the right card number can walk in and photocopy everything — exfiltration happens when an attacker finds that card number, or worse, discovers the library left its doors unlocked. Cloud storage exfiltration is the unauthorized transfer of sensitive data from cloud platforms (S3 buckets, Azure Blob Storage, Google Cloud Storage) to attacker-controlled destinations, exploiting misconfigured permissions, stolen credentials, or insecure APIs.

## Why it matters
In 2019, Capital One suffered a breach where a misconfigured AWS WAF allowed a former AWS employee to query EC2 metadata, steal IAM credentials, and exfiltrate over 100 million customer records directly from S3 buckets. The attacker used legitimate AWS CLI commands — making the activity blend in with normal traffic and evading signature-based detection entirely.

## Key facts
- **Misconfigured ACLs are the #1 vector**: Publicly accessible S3 buckets with no authentication required have exposed billions of records; AWS now blocks public access by default but legacy configs remain dangerous
- **SSRF → Metadata API → Cloud credentials** is a classic attack chain: Server-Side Request Forgery targeting `169.254.169.254` yields temporary IAM tokens usable for bulk downloads
- **DLP and CASB tools** (Cloud Access Security Broker) are the primary defensive controls for detecting and blocking unauthorized cloud data transfers
- **Data egress anomalies** (sudden spikes in outbound transfer, unusual geographic destinations, off-hours API calls) are key detection indicators monitored via CloudTrail (AWS), Azure Monitor, or GCP Audit Logs
- **Signed URLs and pre-authenticated links** can be weaponized — attackers who steal these temporary access tokens can exfiltrate without triggering credential alerts

## Related concepts
[[Server-Side Request Forgery]] [[Cloud Access Security Broker]] [[IAM Privilege Escalation]] [[Data Loss Prevention]] [[Insecure Direct Object Reference]]