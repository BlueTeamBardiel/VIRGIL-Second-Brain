# OWASP API Security Top 10

## What it is
Like a building inspector's checklist for skyscrapers — except the skyscraper is your API and the inspector is an attacker looking for unlocked doors. The OWASP API Security Top 10 is a ranked list of the most critical API vulnerability categories, published by the Open Web Application Security Project to standardize how developers and security teams identify and mitigate API-specific risks.

## Why it matters
In 2019, attackers exploited a **Broken Object Level Authorization (BOLA)** flaw in the Venmo API, allowing any authenticated user to query another user's private transaction history simply by changing a numeric ID in the request. This is API1:2023 (BOLA) in action — the API authenticated the user but never verified *ownership* of the requested resource. Proper object-level authorization checks on every endpoint would have prevented mass data exposure.

## Key facts
- **API1 - BOLA (Broken Object Level Authorization)** is consistently ranked #1 and is the root cause of most API data breaches; it's an IDOR vulnerability at the object level
- **API3 - Broken Object Property Level Authorization** covers *mass assignment* and *excessive data exposure* — APIs returning more fields than the client needs
- **API6 - Unrestricted Access to Sensitive Business Flows** targets abuse of legitimate functionality (e.g., scraping, credential stuffing bots exploiting login endpoints)
- **API8 - Security Misconfiguration** includes unpatched systems, verbose error messages, and open cloud storage — overlaps heavily with CWE-16
- The list was **updated in 2023**, splitting older categories and adding new ones like **API9 - Improper Inventory Management** (shadow/zombie APIs)

## Related concepts
[[Broken Access Control]] [[IDOR (Insecure Direct Object Reference)]] [[Mass Assignment Vulnerability]] [[Security Misconfiguration]] [[Rate Limiting]]