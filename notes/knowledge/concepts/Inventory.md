# Inventory

## What it is
Like a ship's manifest that lists every crate in the cargo hold — if you don't know what's aboard, you can't secure it. Asset inventory is the systematic, maintained catalog of every hardware device, software application, and data resource an organization owns, operates, or is responsible for protecting.

## Why it matters
In 2017, the WannaCry ransomware outbreak devastated organizations that had no idea they were still running unpatched Windows XP systems — machines that weren't even on their radar. A complete, accurate asset inventory would have flagged those legacy endpoints as critical vulnerabilities requiring immediate attention or network isolation before the worm ever reached them.

## Key facts
- **CIS Control #1 and #2** establish hardware and software inventory as the foundational security controls — you cannot protect what you don't know exists
- Asset inventories must include: IP addresses, OS versions, installed software, hardware owner, and system criticality/data classification
- **Shadow IT** — unauthorized devices and apps employees install without IT knowledge — represents the largest gap in most inventories and is a primary attack vector
- Tools used for active inventory include Nmap (network scanning), Nessus (vulnerability scanning), and SIEM agents; passive methods include DHCP log analysis
- Inventory ties directly into **vulnerability management**: CVEs can only be triaged and patched if you know which assets are running the affected software versions

## Related concepts
[[Asset Management]] [[Configuration Management Database (CMDB)]] [[Vulnerability Scanning]] [[Shadow IT]] [[Attack Surface]]