# CloudTrail Logging

## What it is
Think of CloudTrail as the lobby security camera footage for your entire AWS account — every time someone badges through a door (calls an API), the timestamp, identity, and action are recorded permanently. CloudTrail is AWS's native auditing service that captures every API call made within an account, including who made it, from which IP, at what time, and what parameters were passed. It covers actions taken through the console, CLI, SDKs, and other AWS services.

## Why it matters
In the 2019 Capital One breach, the attacker used a compromised EC2 role to call `ListBuckets` and `GetObject` across thousands of S3 buckets — actions that CloudTrail would have logged in full detail. Organizations with CloudTrail feeding into a SIEM could have detected the anomalous enumeration pattern within minutes and triggered an automated response before mass exfiltration occurred.

## Key facts
- CloudTrail logs **Management Events** (control-plane actions like creating an S3 bucket) by default; **Data Events** (object-level S3 reads/writes) must be explicitly enabled and cost extra
- Logs are delivered to S3 within approximately **15 minutes** of the API call occurring
- To prevent log tampering, enable **Log File Validation** — this uses SHA-256 hashing and digital signatures to detect deletion or modification of log files
- CloudTrail can be integrated with **CloudWatch Logs** to set metric filters and alarms (e.g., alert on root account usage)
- CloudTrail is **regional by default**; you must enable a **multi-region trail** to capture global service events (IAM, STS, Route 53) comprehensively

## Related concepts
[[S3 Security]] [[IAM Roles and Policies]] [[SIEM Integration]] [[AWS Config]] [[Log Integrity Monitoring]]