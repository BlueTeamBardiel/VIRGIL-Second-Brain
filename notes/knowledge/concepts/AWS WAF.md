# AWS WAF

## What it is
Think of AWS WAF like a nightclub bouncer with a rulebook — it checks every HTTP/HTTPS request trying to enter your application and turns away anyone matching the ban list before they reach the door. Precisely, AWS WAF (Web Application Firewall) is a managed cloud service that inspects and filters web traffic to AWS-hosted applications based on configurable rules targeting malicious patterns in requests. It operates at Layer 7 (application layer) of the OSI model.

## Why it matters
In 2021, a wave of attacks exploited the Log4Shell vulnerability by injecting malicious strings into HTTP headers like `User-Agent`. Organizations using AWS WAF were able to deploy AWS Managed Rules within hours to block requests containing the `${jndi:ldap://...}` pattern, effectively stopping exploitation attempts against their applications before patches were available — buying critical remediation time.

## Key facts
- AWS WAF uses **Web ACLs** (Access Control Lists) containing rules that inspect request components: IP addresses, HTTP headers, body content, URI strings, and query parameters
- Rules can **allow, block, or count** matching requests; count mode is used for testing rule impact before enforcement
- Integrates natively with **CloudFront, Application Load Balancer (ALB), API Gateway, and AppSync**
- AWS provides **Managed Rule Groups** (pre-built by AWS and third-party vendors) covering OWASP Top 10, SQLi, XSS, and known bad IPs — reducing custom rule burden
- Pricing is based on **number of Web ACLs, rules deployed, and volume of requests inspected** — not a flat subscription fee
- Rate-based rules can automatically **block IPs exceeding a request threshold**, enabling basic DDoS mitigation at Layer 7

## Related concepts
[[Web Application Firewall]] [[OWASP Top 10]] [[DDoS Protection]] [[AWS Shield]] [[SQL Injection]] [[Network Access Control Lists]]