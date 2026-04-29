# Boolean-based blind SQL injection

## What it is
Like asking a sealed box "is the number inside greater than 50?" and inferring its contents from whether the box glows green or red — you never see the data directly, only a true/false signal. Boolean-based blind SQL injection exploits applications that return different responses for true vs. false conditions, allowing attackers to extract database contents one bit at a time without ever seeing direct query output. The attacker crafts conditional payloads (e.g., `AND 1=1` vs. `AND 1=2`) and infers data from behavioral differences in the application's response.

## Why it matters
In the 2008 breach of Heartland Payment Systems, attackers used SQL injection techniques against web-facing applications to ultimately compromise 130 million credit card records. Boolean-based blind injection is particularly dangerous because it leaves minimal obvious error output, making WAF detection and log analysis harder than with error-based injection variants.

## Key facts
- **No output required**: Attackers infer data by observing response differences (page content, HTTP status codes, response length) — not database error messages
- **Payload pattern**: `' AND SUBSTRING(username,1,1)='a'--` — iterating character by character to reconstruct strings
- **Automation is essential**: Tools like `sqlmap` automate the binary-search process; manual extraction of a single field can require hundreds of requests
- **Detection indicator**: Unusually high volumes of nearly identical requests with slight parameter variations in access logs signal blind SQLi enumeration
- **Mitigation**: Parameterized queries (prepared statements) eliminate the vulnerability at the source; WAF rules targeting repeated conditional patterns provide defense-in-depth

## Related concepts
[[SQL Injection]] [[Error-based SQL Injection]] [[Time-based Blind SQL Injection]] [[sqlmap]] [[Parameterized Queries]]