# Decommissioning

## What it is
Like demolishing an old building without properly sealing the gas lines — if you don't formally retire systems the right way, you leave dangerous connections open. Decommissioning is the structured process of securely retiring hardware, software, or services from an environment, including data sanitization, credential revocation, and documentation updates. It ensures that end-of-life assets don't become unpatched, unmonitored attack surfaces.

## Why it matters
In 2021, attackers exploited a forgotten, unpatched Pulse Secure VPN appliance that an organization believed was offline — it was still network-reachable and running vulnerable firmware. This is the classic decommissioning failure: the asset left inventory records but stayed on the network, received no patches, and had no one watching its logs. Proper decommissioning would have included firewall rule removal, credential revocation, and physical disconnection before it dropped off the asset register.

## Key facts
- **Data sanitization methods** matter: clearing, purging (cryptographic erase or DoD 5220.22-M overwrite), and destroying are recognized tiers — destroying is the only guarantee for highly sensitive media
- **Credential revocation** must accompany hardware retirement; service accounts and API keys tied to decommissioned systems are frequently overlooked and remain valid attack vectors
- **Asset inventory updates** are mandatory — a system not in the CMDB receives no patch cycles, no vulnerability scans, and no incident monitoring
- **Certificate and key retirement** is required; orphaned TLS certificates tied to dead servers can be hijacked or cause outages if they expire ungracefully
- **Regulated environments** (HIPAA, PCI-DSS) require documented evidence of data destruction with chain-of-custody records for media disposal

## Related concepts
[[Data Sanitization]] [[Asset Management]] [[Patch Management]] [[Configuration Management Database (CMDB)]] [[Media Disposal]]