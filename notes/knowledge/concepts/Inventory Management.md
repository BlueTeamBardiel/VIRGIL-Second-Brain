# Inventory Management

## What it is
Like a chef who can't protect ingredients they don't know are in the pantry, a security team cannot defend assets they haven't catalogued. Inventory management is the continuous process of discovering, documenting, and tracking every hardware device, software application, and data asset within an organization's environment. It forms the foundation of any security program — you cannot patch, monitor, or protect what you don't know exists.

## Why it matters
In the 2017 Equifax breach, attackers exploited an unpatched Apache Struts vulnerability in a system that had fallen off the security team's radar entirely — an asset not in their inventory. If Equifax had maintained an accurate, up-to-date inventory with automated scanning, the unpatched system would have been flagged during routine vulnerability management cycles, potentially preventing the exposure of 147 million records.

## Key facts
- **CIS Control 1 and 2** specifically mandate hardware and software asset inventory as the first foundational security controls — if you don't know what you have, nothing else works
- A **Configuration Management Database (CMDB)** is the structured repository used to store asset inventory data, often integrated with ITSM tools like ServiceNow
- **Passive vs. active discovery**: active scanning (e.g., Nmap) probes the network to find assets; passive discovery listens to traffic to identify devices without generating noise
- **Shadow IT** — unauthorized devices and applications employees install without IT knowledge — represents the most dangerous inventory gap in modern enterprises
- Inventory management directly enables **vulnerability management**, **patch management**, and **incident response** by providing the asset context required for each

## Related concepts
[[Configuration Management]] [[Vulnerability Management]] [[Asset Management]] [[Shadow IT]] [[CMDB]]