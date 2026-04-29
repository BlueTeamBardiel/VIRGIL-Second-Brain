# PhishTank

## What it is
Think of it as a Yelp for dangerous websites — where the community collectively reviews and confirms which URLs are actively trying to steal your credentials. PhishTank is a free, community-driven online database that aggregates reported phishing URLs, allowing users to submit suspected phishing sites and vote on whether submissions are legitimate threats. It functions as a crowdsourced threat intelligence feed maintained by Cisco Talos.

## Why it matters
A security analyst integrating threat intelligence into a SIEM can pull PhishTank's verified phishing URL feed via its API and automatically block those domains at the proxy or firewall level before any user clicks them. For example, during a targeted spear-phishing campaign mimicking a company's VPN login page, defenders can cross-reference suspicious URLs against PhishTank to confirm malicious intent and accelerate incident response without waiting for a vendor signature update.

## Key facts
- PhishTank is operated by **Cisco Talos** and provides a **free public API** that returns phishing verdicts in JSON or XML format
- Submitted URLs go through a **community voting process** — a URL is marked "verified phish" only after enough users confirm it, reducing false positives
- The database is updated in **near real-time**, making it useful for active threat intelligence workflows
- PhishTank feeds are commonly integrated into **web proxies, email gateways, and SIEM platforms** as an open-source threat intelligence source (OSINT)
- It is a recognized **Open Threat Intelligence** resource referenced in CySA+ objectives alongside similar feeds like URLhaus and OpenPhish

## Related concepts
[[Threat Intelligence Feeds]] [[OSINT]] [[Phishing]] [[SIEM Integration]] [[Indicator of Compromise]]