# Regex Pattern Matching

## What it is
Think of regex like a metal detector at an airport — instead of scanning for physical threats, it scans text for specific shapes of characters. Regex (Regular Expressions) is a sequence of characters that defines a search pattern, used to find, match, or manipulate strings within data based on structural rules rather than exact values.

## Why it matters
SIEM tools and IDS/IPS systems rely heavily on regex to detect malicious patterns in log data — for example, a rule like `\b(?:\d{1,3}\.){3}\d{1,3}\b` can extract suspicious IP addresses from thousands of log lines in milliseconds. Poorly written regex also creates vulnerabilities: a ReDoS (Regular Expression Denial of Service) attack exploits catastrophically backtracking regex engines by feeding them carefully crafted input, causing CPU exhaustion and service outages.

## Key facts
- **ReDoS attacks** exploit exponential backtracking in "evil regex" patterns — patterns with nested quantifiers like `(a+)+` are classic culprits
- SIEM platforms like Splunk use regex in search queries and field extractions to correlate events across log sources
- Regex is used in **input validation** to whitelist acceptable characters and reject injection payloads (SQLi, XSS)
- The **OWASP input validation guidelines** recommend regex-based allow-listing over deny-listing because attackers can always find bypass strings not in your blocklist
- Common metacharacters to know: `.` (any char), `*` (zero or more), `^` (start of line), `$` (end of line), `[]` (character class), `\d` (digit)

## Related concepts
[[Input Validation]] [[SIEM Log Analysis]] [[Denial of Service]] [[SQL Injection]] [[Intrusion Detection System]]
