# Axiom

## What it is
Think of Axiom as a prefabricated attack base camp that you can summon anywhere in the cloud, use for an operation, and then tear down before anyone traces it back to you. Axiom is an open-source dynamic infrastructure framework used by penetration testers and red teams to rapidly deploy, manage, and destroy cloud-based attack infrastructure across multiple providers. It automates spinning up fleets of VPS instances pre-loaded with offensive tools like Nmap, Nuclei, and Metasploit for distributed scanning and exploitation.

## Why it matters
During a red team engagement, defenders may block or rate-limit scans originating from a single IP. Axiom solves this by distributing a port scan across 50 simultaneous cloud nodes, making detection and blocking exponentially harder since the traffic appears to originate from dozens of unrelated addresses. Blue teams hunting for this behavior look for synchronized low-volume scanning patterns across geographically diverse IPs hitting the same targets in coordinated timeframes.

## Key facts
- Axiom uses cloud providers (DigitalOcean, AWS, Linode, Azure) to provision disposable "axiom instances" via Packer-built images
- Supports **fleet operations** — splitting a target list across N instances so each node handles a fraction of the workload (called "split" mode)
- Legitimate red teams use it; threat actors use identical TTPs, making attacker infrastructure attribution significantly harder
- Defenders can identify axiom-style campaigns through netflow analysis: brief instance lifespans (under 24 hours), uniform tool signatures, and sequential IP block sourcing
- Relevant to **CySA+ Domain**: Threat Intelligence and Threat Hunting — recognizing ephemeral infrastructure as a hallmark of advanced adversary tradecraft

## Related concepts
[[Red Team Infrastructure]] [[C2 Infrastructure]] [[Cloud Security]] [[Distributed Scanning]] [[Attribution]]