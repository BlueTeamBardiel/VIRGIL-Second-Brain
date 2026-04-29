# AWS CloudFront

## What it is
Think of CloudFront as a network of postal sorting offices scattered worldwide — instead of every letter traveling from one central warehouse, copies are pre-staged at the nearest hub so delivery is nearly instant. Precisely, CloudFront is AWS's Content Delivery Network (CDN) that caches and distributes web content (HTML, images, APIs, video) from global edge locations, reducing latency and offloading traffic from origin servers.

## Why it matters
Attackers frequently weaponize CDNs for **domain fronting** — routing malicious C2 traffic through CloudFront's trusted HTTPS infrastructure so it appears as legitimate AWS traffic, bypassing firewall rules and DLP tools that whitelist *.cloudfront.net. Defenders must inspect SNI headers and payload content rather than relying solely on IP reputation or domain allowlists to detect this technique.

## Key facts
- CloudFront sits between users and origin servers (S3 buckets, EC2, ALBs), making it a natural enforcement point for **AWS WAF** and **Shield** (DDoS protection)
- **Origin Access Control (OAC)** restricts S3 bucket access so content is only reachable through CloudFront, preventing direct bucket exposure — a misconfiguration frequently tested on exams
- CloudFront supports **field-level encryption**, protecting sensitive form data (e.g., credit card numbers) end-to-end beyond HTTPS termination at the edge
- Geo-restriction (geo-blocking) can be enforced at the CloudFront layer to deny requests from specific countries, satisfying compliance requirements
- All CloudFront access logs and API calls integrate with **CloudTrail** and **S3 access logs**, critical for forensic investigation and audit trails

## Related concepts
[[Content Delivery Network (CDN)]] [[AWS WAF]] [[Domain Fronting]] [[AWS Shield]] [[TLS/SSL Inspection]]