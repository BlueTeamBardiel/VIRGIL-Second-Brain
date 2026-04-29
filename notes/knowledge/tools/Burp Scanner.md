# Burp Scanner

## What it is
Like a home inspector who systematically taps every wall, tests every outlet, and jiggles every door handle looking for defects — Burp Scanner is an automated web application vulnerability scanner built into Burp Suite Professional. It crawls target web applications and actively probes discovered endpoints for vulnerabilities such as SQL injection, XSS, XXE, and insecure deserialization.

## Why it matters
During a penetration test engagement, a security team can point Burp Scanner at a client's e-commerce portal and within hours receive a prioritized report showing that three product search fields are vulnerable to blind SQL injection — vulnerabilities that manual testing alone might have taken days to uncover. This accelerates the assessment cycle and ensures consistent coverage across hundreds of input parameters that humans might overlook.

## Key facts
- **Active vs. Passive scanning**: Active scanning sends crafted malicious payloads to the target (potentially disruptive); passive scanning analyzes traffic already flowing through Burp Proxy without injecting new requests.
- **Crawl + Audit pipeline**: Burp Scanner first maps application content and functionality (crawl phase), then systematically tests discovered attack surface (audit phase).
- **Issue confidence and severity**: Findings are rated by severity (High/Medium/Low/Informational) and confidence (Certain/Firm/Tentative), helping testers prioritize remediation.
- **Only in Burp Suite Professional**: The full automated scanner is not available in the free Community Edition, which is a common exam distractor.
- **OWASP Top 10 coverage**: Burp Scanner is specifically designed to detect categories from the OWASP Top 10, making it a standard tool referenced in web application security assessments and CySA+ exam contexts.

## Related concepts
[[Burp Suite]] [[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[OWASP Top 10]] [[Dynamic Application Security Testing (DAST)]]