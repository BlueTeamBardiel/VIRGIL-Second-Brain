# Cloud Metadata Service Abuse

## What it is
Imagine a hotel concierge desk that hands out master keys, Wi-Fi passwords, and staff schedules to *anyone* who calls from inside the building — no ID required. The cloud metadata service (most famously AWS's Instance Metadata Service at `169.254.169.254`) is exactly that: a local HTTP endpoint every cloud VM can query to retrieve instance configuration, IAM role credentials, and initialization scripts. Attackers who achieve SSRF or code execution on a cloud instance can silently query this endpoint and harvest credentials without ever touching external infrastructure.

## Why it matters
In the 2019 Capital One breach, the attacker exploited an SSRF vulnerability in a misconfigured WAF running on AWS EC2 to query the metadata service, retrieve temporary IAM role credentials, and exfiltrate over 100 million customer records from S3. The entire chain required no stolen passwords — just one misdirected HTTP request.

## Key facts
- The magic IP `169.254.169.254` is a link-local address accessible only from within the instance; it does **not** require authentication by default in IMDSv1.
- AWS IMDSv2 (Instance Metadata Service version 2) mitigates SSRF attacks by requiring a session-oriented token obtained via a `PUT` request before `GET` queries are honored — a one-time-password-style handshake.
- GCP and Azure have equivalent services at the same IP but with different URL paths and optional header-based authentication requirements.
- Metadata endpoints can expose IAM role credentials (Access Key ID + Secret + Session Token), which are temporary but fully functional until they expire.
- Detection strategy: alert on any process or network call originating from application-tier hosts targeting `169.254.169.254` — legitimate apps rarely need direct metadata queries.

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[IAM Privilege Escalation]] [[Credential Theft]] [[IMDS Security Controls]]