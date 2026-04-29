# Cloud Metadata Endpoint Abuse

## What it is
Imagine every hotel room has an intercom connecting directly to the front desk that only works *from inside the room* — except a clever guest figures out how to reroute calls through the intercom from outside. The cloud metadata endpoint (`http://169.254.169.254`) is a special internal HTTP service every major cloud provider (AWS, Azure, GCP) exposes to running instances, delivering configuration data, credentials, and instance identity — and attackers exploit SSRF vulnerabilities to reach it from the outside world.

## Why it matters
In the 2019 Capital One breach, a misconfigured WAF was exploited via SSRF to query AWS's metadata endpoint, returning IAM role credentials. The attacker used those temporary credentials to access S3 buckets containing over 100 million customer records — all without ever directly compromising a server.

## Key facts
- The magic IP `169.254.169.254` is a link-local address; requests must originate from the instance itself, making SSRF the primary attack vector
- AWS IMDSv1 requires no authentication; IMDSv2 (Instance Metadata Service version 2) mitigates abuse by requiring a session-oriented token via a PUT request first
- Returned data can include IAM role credentials (Access Key ID, Secret Access Key, Session Token) that are valid and rotatable
- Azure uses the same IP but requires the header `Metadata: true`; GCP uses `http://metadata.google.internal` with a similar header requirement
- Defense-in-depth includes: blocking outbound requests to 169.254.169.254 at the WAF/firewall, enforcing IMDSv2, and applying least-privilege IAM roles to instances

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[IAM Privilege Escalation]] [[Credential Theft]] [[Misconfigured Cloud Storage]]