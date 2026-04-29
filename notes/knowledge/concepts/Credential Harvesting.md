# credential harvesting

## What it is
Like a farmer collecting ripe fruit from many trees in a single pass, an attacker systematically gathers username/password pairs from multiple victims rather than targeting one at a time. Credential harvesting is the bulk collection of authentication credentials through techniques like phishing pages, keyloggers, or database breaches, with the goal of reusing them at scale across services.

## Why it matters
In the 2020 SolarWinds campaign, attackers harvested credentials from compromised environments to pivot laterally across networks for months undetected. Defenders monitor for credential stuffing attempts — automated logins using harvested lists — which often appear as distributed, low-rate authentication failures across many source IPs, specifically to evade lockout thresholds.

## Key facts
- **Credential stuffing** is the downstream attack: harvested credentials are tested at scale against other services, exploiting password reuse (success rates typically 0.1–2%)
- **Typosquatting + fake login pages** (e.g., "paypa1.com") are a primary harvesting vector; tools like **SET (Social Engineering Toolkit)** can clone legitimate login portals in minutes
- Harvested credentials frequently appear on paste sites (Pastebin) or dark web markets within hours of a breach
- **MFA significantly degrades harvested credential value** — even valid username/password pairs become largely useless without the second factor
- On Security+/CySA+: credential harvesting is categorized under **social engineering** and **reconnaissance** phases; look for it in phishing simulation and threat hunting questions

## Related concepts
[[phishing]] [[credential stuffing]] [[password spraying]] [[social engineering]] [[multi-factor authentication]]