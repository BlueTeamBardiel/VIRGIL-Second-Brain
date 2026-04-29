# Automatic Updates

## What it is
Think of automatic updates like a building's sprinkler system — you don't want to wait until a fire starts to install it. Automatic updates are mechanisms that allow software, operating systems, and firmware to download and apply patches without requiring manual intervention from the user or administrator. They operate on scheduled intervals or event-driven triggers, pulling fixes from vendor-controlled distribution servers.

## Why it matters
In May 2017, the WannaCry ransomware cryptoworm devastated hundreds of thousands of Windows systems globally — but the critical SMB vulnerability it exploited (MS17-010) had been patched by Microsoft two months earlier. Organizations that had automatic updates disabled or delayed — including hospitals running legacy systems — suffered catastrophic downtime, demonstrating that patch latency directly translates to exploitable attack surface.

## Key facts
- **Patch Tuesday** is Microsoft's monthly scheduled release of security updates; attackers track these releases to reverse-engineer vulnerabilities and target unpatched systems ("Exploit Wednesday").
- Automatic updates can themselves be attack vectors — **SolarWinds (2020)** weaponized the legitimate update mechanism of Orion software to distribute malicious code to ~18,000 organizations.
- **WSUS (Windows Server Update Services)** allows enterprise environments to centrally control and test updates before automatic deployment, balancing speed with stability.
- The **CVE scoring system (CVSS)** helps organizations prioritize which patches are critical enough to justify emergency deployment outside normal automatic update cycles.
- Disabling automatic updates is a common misconfiguration finding in **CIS Benchmark** and **NIST SP 800-40** patch management guidelines, both of which recommend automated patching for internet-facing systems.

## Related concepts
[[Patch Management]] [[Vulnerability Management]] [[Supply Chain Attacks]] [[CVE/CVSS Scoring]] [[Configuration Management]]