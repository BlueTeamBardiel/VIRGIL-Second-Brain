# Security Concepts — Index

> Knowledge index for [[VIRGIL]] security notes | Links to notes/mitre/, CySA+ study material, and tooling references

---

## CIA Triad

The foundation of information security risk assessment.

| Property | Definition | Threat example |
|----------|-----------|---------------|
| **Confidentiality** | Data is accessible only to authorized parties | Credential theft, eavesdropping |
| **Integrity** | Data is accurate and unmodified | Tampering, injection attacks |
| **Availability** | Systems and data are accessible when needed | DDoS, ransomware |

A control that improves one property can degrade another — document trade-offs when designing defenses.

---

## Attack Frameworks

### MITRE ATT&CK
Adversary tactics, techniques, and procedures mapped to real-world intrusion campaigns.

- **Tactics** — the adversary's goal (e.g., Initial Access, Persistence, Exfiltration)
- **Techniques** — how they achieve it (e.g., T1566 Phishing)
- **Sub-techniques** — specific implementation (e.g., T1566.001 Spearphishing Attachment)
- Notes: [[notes/mitre/]] — individual technique notes written by [[virgil-url]]
- Reference: attack.mitre.org

### Cyber Kill Chain (Lockheed Martin)
Linear 7-stage model of an intrusion:

1. Reconnaissance
2. Weaponization
3. Delivery
4. Exploitation
5. Installation
6. Command & Control (C2)
7. Actions on Objectives

Useful for: understanding at which stage a control breaks the chain. Weaker than ATT&CK for mapping lateral movement or multi-stage campaigns.

### Diamond Model
Analytical framework with four vertices: Adversary, Capability, Infrastructure, Victim. Focuses on relationships between components rather than a linear kill chain. Used in threat intelligence and attribution analysis.

---

## Tool Categories

### Detection & Monitoring
| Tool | Category | Where deployed |
|------|----------|---------------|
| [[Wazuh]] | SIEM / HIDS | [[LAB_HOST]] manager, agents fleet-wide |
| [[Grafana]] | Metrics dashboard | [[LAB_HOST]] |
| [[Prometheus]] | Metrics collection | [[LAB_HOST]] + node exporters |
| [[Greenbone]] / OpenVAS | Vulnerability scanner | [[LAB_HOST]] (Phase 2.4) |
| Zeek | Network forensics | [[LAB_HOST]] (Phase 2.5, planned) |
| Suricata | Network IDS | [[LAB_HOST]] (Phase 2.5, planned) |

### Offense / Red Team
| Tool | Category | Notes |
|------|----------|-------|
| [[Nmap]] | Port scanner | Fleet port-scan playbook deployed |
| [[YOUR_KALI_VM]] ([[Kali Linux]]) | Pentest VM | On [[YOUR_JUMP_SERVER]], needs upgrades |
| [[CAIM]] (WiFi Pineapple MK7) | Wireless audit | wlan MACs pending |

### Hardening & Access Control
| Tool | Category | Notes |
|------|----------|-------|
| [[UFW]] | Host firewall | Deployed fleet-wide |
| [[fail2ban]] | Brute-force mitigation | Deployed fleet-wide |
| [[Tailscale]] | Zero-trust mesh VPN | All lab hosts |

---

## Common Attack Surfaces

### Network
- Open ports (scan with Nmap; VIRGIL port-scan playbook)
- Weak firewall rules (UFW applied, verify with `ufw status verbose`)
- Unencrypted protocols: Telnet, FTP, HTTP management interfaces

### Authentication
- Default credentials on network devices (YOUR_SWITCH, YOUR_ROUTER, CAIM)
- Password reuse across services
- Missing MFA on admin interfaces

### Endpoint
- Unpatched OS / packages — `apt-upgrade.yml` runs Mon/Thu 3am fleet-wide
- Unnecessary services listening (use `ss -tlnp`)
- SUID binaries, writable cron jobs

---

## CySA+ Domain Map

See [[notes/knowledge/cysa/]] and [[CySA+]] study tracker in memory-semantic.md.

| CySA+ Domain | Coverage here |
|-------------|--------------|
| Threat & Vulnerability Management | ATT&CK, Greenbone/OpenVAS |
| Software & Systems Security | Hardening, UFW, fail2ban |
| Security Operations & Monitoring | Wazuh, Grafana, SIEM |
| Incident Response | See notes/knowledge/security/incident-response.md |
| Compliance & Assessment | NIST notes in notes/knowledge/nist/ |

---

## Related

- [[notes/mitre/]] — individual ATT&CK technique notes
- [[notes/cve/]] — CVE ingest pipeline output
- [[notes/knowledge/networking/README]] — networking concepts index
- [[VIRGIL]] ingest pipeline — `virgil-url`, `virgil-cve`, `pdf-ingest`