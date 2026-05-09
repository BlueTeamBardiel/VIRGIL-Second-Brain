# Misconfiguration Vulnerabilities

## What it is

In Escape from Tarkov, you spawn into a raid with your secure container, your armor, your weapon — and you forgot to zip the rig closed, left a Labs keycard in your pocket, and your gamma container is bound to the wrong key. You didn't get killed by a hacker. You got killed by yourself, three menus ago. That's exactly what a misconfiguration vulnerability is — a weakness created not by a software bug, but by a human leaving a setting wrong.

A **misconfiguration vulnerability** is a security weakness introduced when a system, application, network device, or cloud resource is deployed or maintained with insecure settings, default credentials, unnecessary services, or permissive access controls.

## Why it matters

Misconfigurations are the single most boring and most common cause of breaches — exposed S3 buckets, default admin/admin on a switch, RDP open to 0.0.0.0/0, verbose error pages leaking stack traces. They violate frameworks like PCI-DSS, HIPAA, and CIS Benchmarks, and they hand attackers a free pass without requiring a single zero-day. For SY0-701 Objective **2.3** ("Explain various types of vulnerabilities"), candidates must recognize misconfiguration as a distinct vulnerability class, separate from software flaws or supply chain attacks. CompTIA's favorite trap: confusing **misconfiguration** with **default configuration** — default creds *are* a misconfiguration when left in production, but the broader category includes any deviation from a secure baseline.

## Key facts

### Common misconfiguration types

| Type | Example | Typical Impact |
|---|---|---|
| **Default credentials** | Router admin/admin, Tomcat manager creds | Full device takeover |
| **Open permissions** | Public S3 bucket, world-readable shares | Data exposure |
| **Unsecured protocols** | [[Telnet]] (23), [[FTP]] (21), [[HTTP]] (80) for admin | Credential sniffing |
| **Open ports/services** | RDP (3389) exposed to internet | Brute force, ransomware |
| **Verbose error messages** | Stack traces, SQL errors in HTTP responses | Reconnaissance gold |
| **Disabled security controls** | UAC off, SELinux permissive, [[firewall]] disabled | Defense bypass |
| **Excessive privileges** | Service accounts as Domain Admin | Lateral movement |
| **Missing patches via config** | Auto-update disabled | Known CVE exploitation |

### Cloud-specific misconfigurations

- **Public storage buckets** — [[Amazon S3]], Azure Blob, GCS left world-readable. The classic Capital One / Verizon / Accenture breach pattern.
- **Overly permissive [[IAM]] policies** — `"Action": "*"` on `"Resource": "*"`. The cloud equivalent of giving every NPC the keys to your stash.
- **Unrestricted security groups** — `0.0.0.0/0` on port 22 or 3389.
- **Disabled logging** — [[CloudTrail]], [[VPC Flow Logs]], or audit logs turned off "for cost reasons."
- **Unencrypted resources** — EBS volumes, RDS instances, S3 buckets without encryption-at-rest.

### Network device misconfigurations

- Unchanged **SNMP community strings** (`public`/`private`)
- **VLAN hopping** enabled via auto-trunking on access ports
- Missing **ACLs** on management interfaces
- **Spanning Tree** without BPDU Guard
- Routing protocols without authentication

### Application misconfigurations

- Debug mode enabled in production
- Directory listing enabled
- Default sample apps left installed (Tomcat examples, phpMyAdmin)
- CORS set to `Access-Control-Allow-Origin: *`
- Missing security headers (HSTS, CSP, X-Frame-Options)

### Defenses and controls

| Control | Function |
|---|---|
| **[[Configuration Baselines]]** | Documented "known good" state |
| **[[CIS Benchmarks]]** / [[STIG]] | Industry-standard hardening guides |
| **[[Hardening]]** | Disable unused services, close ports, enforce least privilege |
| **[[Configuration Management]]** (Ansible, Puppet, Chef) | Enforce baselines as code |
| **[[Vulnerability Scanning]]** (Nessus, OpenVAS) | Detect drift from baseline |
| **[[CSPM]]** (Cloud Security Posture Management) | Continuous cloud config audit |
| **[[Change Management]]** | Prevents ad-hoc config drift |
| **[[Infrastructure as Code]]** | Reviewable, version-controlled configs |

### Exam-precise distinctions

- **Misconfiguration** ≠ **vulnerability in code**. A buffer overflow is a code flaw; an unpatched system is a *patch management* failure that *becomes* a misconfiguration when patching is disabled.
- **Default configuration** is a *subset* of misconfiguration.
- **Weak configuration** is the SY0-701 umbrella term — expect it phrased that way.

## Related concepts

[[Hardening]] · [[CIS Benchmarks]] · [[Configuration Baselines]] · [[Default Credentials]] · [[Open Permissions]] · [[CSPM]] · [[Attack Surface]] · [[Least Privilege]] · [[Change Management]] · [[Infrastructure as Code]] · [[Vulnerability Scanning]]

---
*Source: VIRGIL knowledge base — 2026-05-08*