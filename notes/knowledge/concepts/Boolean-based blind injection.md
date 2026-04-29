# Boolean-based blind injection

## What it is
Imagine interrogating a witness who can only nod or shake their head — you can still extract the truth by asking yes/no questions carefully enough. Boolean-based blind SQL injection works the same way: an attacker submits queries that cause the application to behave differently (page loads vs. error, or different content) based on whether a condition is TRUE or FALSE, extracting data one bit at a time without ever seeing raw query output.

## Why it matters
In 2008, attackers used blind SQL injection techniques against Heartland Payment Systems to enumerate database structures before exfiltrating 130 million credit card records — the application never returned direct query results, yet the data was fully compromised. Defenders counter this by implementing parameterized queries and WAF rules that flag repeated near-identical requests differing only in conditional logic.

## Key facts
- Relies on **observable application behavior differences** (response length, HTTP status code, page content) rather than error messages or in-band data output
- Data is extracted **character by character** using binary search logic, e.g., `ASCII(SUBSTRING(password,1,1)) > 77` — making it slow but effective
- Requires **many HTTP requests** per extracted byte (typically 7–8 with binary search), making it detectable via anomalous traffic volume in SIEM logs
- Distinct from **error-based injection** (which reads data from error messages) and **time-based blind injection** (which uses `SLEEP()` delays instead of response differences)
- Automated tools like **sqlmap** handle boolean-based blind injection automatically, lowering the skill threshold for attackers significantly

## Related concepts
[[SQL Injection]] [[Time-based Blind Injection]] [[Parameterized Queries]] [[Web Application Firewall]] [[Out-of-band SQL Injection]]