# HTTP Parameter Pollution

## What it is
Imagine handing a border agent two passports with different names — depending on which one they check, you become a different person. HTTP Parameter Pollution (HPP) works the same way: an attacker injects duplicate query parameters into an HTTP request, exploiting inconsistencies in how different components (web server, application, backend API) parse and prioritize repeated keys. For example, sending `?user=alice&user=attacker` may cause one layer to see "alice" while another acts on "attacker."

## Why it matters
In 2010, researchers demonstrated HPP against Google and PayPal, where duplicate parameters caused backend services to bypass signature validation in payment flows. An attacker could manipulate a transaction amount or recipient by injecting a second `amount` parameter that the payment processor honored over the one the frontend validated. Defense requires normalizing and strictly parsing parameters at every layer before processing.

## Key facts
- Different web technologies handle duplicate parameters differently: PHP/Apache use the **last** value, ASP.NET uses the **first**, and some frameworks concatenate them (e.g., `alice,attacker`)
- HPP can target both **server-side** (bypassing WAF rules, logic flaws) and **client-side** (injecting parameters into links rendered in the browser)
- WAFs are often bypassed because the malicious parameter is split across duplicates, with neither half triggering the signature alone
- HPP is distinct from HTTP Header Injection — it operates on query strings and POST body parameters, not headers
- Mitigation includes strict input validation, using allowlists for accepted parameters, and ensuring consistent parameter-parsing logic across all application tiers

## Related concepts
[[Input Validation]] [[Web Application Firewall (WAF) Evasion]] [[SQL Injection]] [[OWASP Top 10]] [[Query String Manipulation]]