# SURBL

## What it is
Think of SURBL as a bouncer holding a list of known troublemaker addresses — but instead of checking people, it checks URLs embedded inside emails. SURBL (Spam URI Realtime Blocklists) is a DNS-based blocklist that identifies malicious or spam-associated domains found within message bodies, rather than flagging the sending IP address itself. It allows mail filters to query whether a URL inside an email links to a known bad destination before the user ever clicks it.

## Why it matters
During a phishing campaign, an attacker may route email through a legitimate, unblacklisted mail server to bypass traditional IP-based reputation filters — SURBL catches what those filters miss by inspecting the payload links themselves. For example, a financial phishing email sent through a compromised university mail server could slip past IP reputation checks, but SURBL would flag the embedded credential-harvesting domain (e.g., `secure-bank-login[.]xyz`) before delivery. This URL-layer inspection is a critical defense layer in modern email security gateways.

## Key facts
- SURBL checks domains extracted from **message body URLs**, not the sending IP or envelope header — this is its key differentiator from RBLs (Realtime Blackhole Lists).
- Queries are made via **DNS lookups** (e.g., `domain.example.surbl.org`), making checks fast and scalable without heavy local processing.
- SURBL maintains multiple sub-lists: **SC** (SpamCop), **WS** (websites), **PH** (phishing), **MW** (malware), and **AB** (AbuseButler combined list).
- A domain typically appears in SURBL after being observed in **spam traps or reported phishing campaigns**, giving it retroactive but near-realtime coverage.
- SURBL is commonly integrated into **SpamAssassin, Postfix, and commercial email gateways** as a plugin check.

## Related concepts
[[DNS Blocklist (DNSBL)]] [[Email Header Analysis]] [[Phishing Detection]] [[SpamAssassin]] [[URL Reputation Filtering]]