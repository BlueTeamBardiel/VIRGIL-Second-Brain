# Fleet Automation

## What it is
Think of it like a single conductor leading a thousand-piece orchestra — one signal, synchronized action across every instrument simultaneously. Fleet automation is the practice of using centralized tooling (such as Ansible, Puppet, Chef, or Microsoft Endpoint Manager) to deploy configurations, patches, and security policies across an entire inventory of endpoints, servers, or network devices without manual intervention per host.

## Why it matters
In 2021, the Kaseya VSA supply chain attack demonstrated the devastating double-edged nature of fleet automation: attackers who compromise a fleet management platform can push malicious updates to thousands of downstream endpoints within hours. Defenders, conversely, use the same capability to emergency-patch a zero-day across 50,000 endpoints before attackers can exploit it — turning a liability into a force multiplier.

## Key facts
- **Attack surface amplification**: A compromised fleet automation controller (a "single pane of glass") can become a lateral movement launchpad with domain-wide reach — making it a high-value target requiring privileged access management (PAM) controls.
- **Configuration drift prevention**: Automation enforces a known-good baseline state (CIS Benchmarks, STIG hardening) and automatically remediates unauthorized changes — directly supporting integrity goals in the CIA triad.
- **Idempotency**: Properly written automation scripts produce the same secure state regardless of how many times they run — a key property ensuring reliability in security configurations.
- **Agent vs. agentless**: Agent-based tools (Puppet, Chef) maintain persistent presence on endpoints; agentless tools (Ansible via SSH/WinRM) reduce persistent footprint but require network access and valid credentials at execution time.
- **Compliance reporting**: Fleet automation platforms generate audit logs of what was deployed, when, and to which systems — critical evidence for SOC 2, PCI-DSS, and NIST 800-53 audits.

## Related concepts
[[Supply Chain Attacks]] [[Configuration Management]] [[Patch Management]] [[Privileged Access Management]] [[Infrastructure as Code]]