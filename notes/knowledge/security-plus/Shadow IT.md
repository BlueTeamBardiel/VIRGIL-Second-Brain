# Shadow IT

## What it is
Like a rogue kitchen in a restaurant where line cooks order their own ingredients from unapproved suppliers — bypassing health inspections entirely — Shadow IT refers to hardware, software, or services employees deploy and use without the knowledge or approval of the IT or security department. These assets operate outside organizational policy, monitoring, and patch management cycles.

## Why it matters
In 2020, a financial services firm suffered a data breach when an employee stored sensitive client data in a personal Dropbox account to "work more efficiently from home." The unsanctioned cloud service lacked the firm's required encryption controls, and the account was later compromised through credential stuffing — an exposure the security team couldn't detect because they didn't know the asset existed.

## Key facts
- Shadow IT dramatically expands the **attack surface** because unmanaged assets receive no security patches, logging, or DLP enforcement
- Common forms include personal cloud storage (Google Drive, Dropbox), unauthorized SaaS apps, browser extensions, and rogue Wi-Fi hotspots
- **Cloud Access Security Brokers (CASBs)** are the primary technical control used to discover and govern unsanctioned cloud service usage
- On CySA+ and Security+, Shadow IT is directly tied to **asset inventory** gaps — you can't protect what you don't know exists
- Discovery methods include network traffic analysis, DNS query monitoring, and reviewing firewall/proxy logs for unknown destinations

## Related concepts
[[Attack Surface Management]] [[Cloud Access Security Broker]] [[Asset Inventory]] [[Data Loss Prevention]] [[Acceptable Use Policy]]