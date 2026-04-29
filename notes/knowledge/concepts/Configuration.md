# Configuration

## What it is
Like the settings panel on a new phone that ships with Bluetooth on, location sharing enabled, and a default PIN of "0000" — configuration is the collection of settings, parameters, and options that define how a system or application behaves. Precisely: configuration encompasses all adjustable values (ports, permissions, authentication requirements, service states) that control a system's security posture and functionality.

## Why it matters
In 2021, a misconfigured Amazon S3 bucket exposed sensitive data from thousands of organizations — the bucket's configuration allowed public read access, a default setting that was never changed. This class of vulnerability, called a **security misconfiguration**, is consistently ranked in the OWASP Top 10 because defenders often harden code while leaving infrastructure settings at insecure defaults.

## Key facts
- **Default configurations are attack surface** — default credentials (admin/admin), open ports, and enabled unnecessary services are primary footholds for attackers
- **Security misconfiguration** is the direct CySA+/Security+ term; it includes unpatched systems, verbose error messages, and unnecessary features left enabled
- **Baseline configuration** refers to a documented, approved secure starting state — deviations from baseline are indicators of tampering or drift
- **Configuration management** tools (Ansible, Puppet, Chef) enforce consistent, auditable settings across fleets of systems, reducing human error
- **CIS Benchmarks** provide vendor-specific, scored configuration hardening guides and are a common compliance reference for Security+ exam scenarios

## Related concepts
[[Hardening]] [[Baseline]] [[Patch Management]] [[Least Privilege]] [[Vulnerability Management]]