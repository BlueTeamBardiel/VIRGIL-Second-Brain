# OWASP ModSecurity Core Rule Set

## What it is
Think of it as a pre-written rulebook for a nightclub bouncer — instead of writing your own rules for who gets rejected, you install an expertly curated list that already knows every known troublemaker's tricks. The OWASP ModSecurity Core Rule Set (CRS) is a free, open-source collection of generic attack detection rules for use with ModSecurity (and compatible WAFs), designed to protect web applications from a broad range of attacks with minimal false positives.

## Why it matters
In 2021, attackers exploited Log4Shell by sending malicious JNDI lookup strings in HTTP headers — a classic injection attack. Organizations running ModSecurity with CRS had rules (specifically in the REQUEST-944 Java Attack rules category) that detected and blocked these payloads at the WAF layer before they ever reached the vulnerable application, buying critical time during patch deployment.

## Key facts
- CRS is maintained by OWASP and covers all OWASP Top 10 attack categories, including SQLi, XSS, RCE, and path traversal
- Operates using a **paranoia level system (1–4)**: Level 1 catches obvious attacks with few false positives; Level 4 is highly aggressive and may block legitimate traffic
- Rules are organized into numbered files (e.g., REQUEST-941 for XSS, REQUEST-942 for SQLi), making targeted tuning straightforward
- Uses an **anomaly scoring model** — individual rule matches add to a score, and requests only get blocked when the total exceeds a configurable threshold
- CRS is the de facto standard ruleset referenced in PCI DSS compliance guidance for WAF implementations

## Related concepts
[[Web Application Firewall (WAF)]] [[ModSecurity]] [[OWASP Top 10]] [[SQL Injection]] [[Anomaly-Based Detection]]