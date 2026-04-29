# Snipe-IT

## What it is
Think of it as a library card catalog system, but instead of books, it tracks every laptop, server, software license, and USB drive your organization owns. Snipe-IT is an open-source IT asset management (ITAM) platform that maintains an inventory of hardware and software assets, their assigned users, locations, and lifecycle status.

## Why it matters
During a ransomware incident response, security teams often discover unpatched machines they didn't know existed — shadow assets that fell outside patch management cycles. A properly maintained Snipe-IT deployment gives incident responders an authoritative asset list, enabling them to quickly identify which systems are affected, who owns them, and whether they're end-of-life devices that shouldn't be on the network at all.

## Key facts
- Snipe-IT supports **SAML and LDAP integration**, allowing organizations to tie asset ownership directly to Active Directory user accounts for access correlation
- It tracks **software license compliance**, helping organizations avoid both over-licensing costs and under-licensing audit risk — a control relevant to CIS Control 2 (Software Asset Management)
- Snipe-IT can generate **audit trails and check-in/check-out logs**, which serve as supporting evidence during compliance audits (SOC 2, ISO 27001)
- It maps directly to **CIS Control 1 (Hardware Asset Inventory)** and **Control 2 (Software Asset Inventory)** — two foundational controls that precede effective vulnerability management
- Deployed as a **self-hosted web application** (Laravel/PHP stack), meaning the organization retains full control of asset data — relevant for data sovereignty and insider threat containment

## Related concepts
[[Asset Management]] [[Configuration Management Database (CMDB)]] [[CIS Controls]] [[Vulnerability Management]] [[Software License Compliance]]