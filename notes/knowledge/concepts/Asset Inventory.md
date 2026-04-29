# Asset Inventory

## What it is
Like a librarian who can't protect books she doesn't know exist, a security team can't defend systems it hasn't catalogued. An asset inventory is a comprehensive, maintained record of every hardware device, software application, and data resource an organization owns or operates — including their owners, locations, configurations, and criticality levels.

## Why it matters
In the 2020 SolarWinds breach, attackers moved laterally through networks for months partly because organizations had no clear picture of which systems were running the compromised Orion software. A current asset inventory would have allowed security teams to immediately identify and isolate affected hosts the moment the vulnerability was disclosed, cutting response time from months to hours.

## Key facts
- Asset inventory is the **first control** in the CIS Critical Security Controls (CIS Control 1 covers hardware assets; Control 2 covers software assets) — you cannot secure what you don't know you have
- Passive discovery finds assets by monitoring network traffic; **active discovery** (e.g., Nmap scans) actively probes the network — both methods together provide the most complete picture
- Assets should be classified by **criticality and sensitivity** (e.g., crown jewels vs. commodity hardware) to prioritize patching and monitoring efforts
- Shadow IT — unauthorized devices and applications employees introduce — is the primary reason inventories become stale and incomplete
- Asset inventories feed directly into **vulnerability management** workflows: you cannot run a meaningful scan without a target list, and you cannot prioritize patches without knowing asset criticality

## Related concepts
[[Configuration Management Database (CMDB)]] [[Vulnerability Management]] [[Network Discovery]] [[Shadow IT]] [[Risk Assessment]]