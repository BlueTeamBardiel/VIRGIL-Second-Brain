```yaml
---
domain: "1.0 - General Security Concepts"
section: "1.2"
tags: [security-plus, sy0-701, domain-1, deception, disruption, threat-detection]
---
```

# 1.2 - Deception and Disruption

## Overview

Deception and disruption techniques are defensive strategies that create fake systems, data, and networks to detect, trap, and mislead attackers. This section covers [[Honeypots]], [[Honeynets]], [[Honeyfiles]], and [[Honeytokens]]—all designed to identify malicious activity, gather threat intelligence, and waste attacker time on decoys rather than real assets. For the Security+ exam, understanding these deception tactics demonstrates a sophisticated grasp of proactive threat detection and represents a shift from purely reactive (firewall/IDS) to active threat hunting methodologies.

---

## Key Concepts

- **[[Honeypot]]**: A decoy system or application deliberately exposed to attackers to study their behavior, techniques, and tools. Intentionally vulnerable with limited real value—designed to be attractive bait.

- **[[Honeynet]]**: An entire network of honeypots (multiple decoys) that simulates a real environment with servers, workstations, routers, switches, and firewalls. Provides layered deception and more comprehensive threat intelligence.

- **[[Honeyfile]]**: A fake file planted on a network (e.g., `passwords.txt`, `admin_creds.xlsx`) with attractive names designed to lure attackers. When accessed, an alert is triggered—like a "virtual bear trap."

- **[[Honeytoken]]**: Traceable data embedded in a honeynet that identifies how attackers move through a network and who exfiltrates it. Examples include:
  - **Fake API credentials** that don't grant access but trigger notifications when used
  - **Bogus email addresses** added to contact lists to detect harvesting and spam campaigns
  - **Database records, browser cookies, web page pixels** that leave a trail when stolen

- **Deception vs. Detection**: Honeypots are **active deception** (attracting attackers to a known environment), while [[IDS]]/[[IPS]] are **passive detection** (monitoring real traffic).

- **Attribution and Forensics**: Honeytokens and honeypots enable security teams to track attacker origin, tools, techniques, and objectives—feeding into [[MITRE ATT&CK]] frameworks and [[Incident Response]] playbooks.

---

## How It Works (Feynman Analogy)

Imagine you own a store and you want to catch shoplifters. Instead of watching every customer, you place a **fake security camera** in a blind spot (honeypot) and a **marked $100 bill** on a shelf (honeytoken). When a thief steals the marked bill, you know exactly who took it and can trace their movements.

**Technical reality**: A honeypot is a fake server (e.g., running [[Metasploit]] or Cowrie SSH emulator) that logs every command an attacker runs. A honeytoken is a database record or credential that doesn't work for access but **triggers an alert** when used. When an attacker exfiltrates this token, your [[SIEM]] (like [[Wazuh]]) detects its use on the internet and you've caught them—and learned their tactics.

The "bad guys" are often automated scanners and bots, not humans. They blindly probe for vulnerabilities and grab whatever looks valuable. Honeypots turn their reconnaissance into **your** intelligence gathering.

---

## Exam Tips

- **Honeypots vs. Honeynets**: A honeypot is a *single decoy system*; a honeynet is a *network of decoys*. The exam may ask which is appropriate for a larger infrastructure (answer: honeynet).

- **Honeyfile vs. Honeytoken distinction**: 
  - **Honeyfiles** = fake files on disk (static bait)
  - **Honeytokens** = traceable data (active tracking). Honeytokens are more sophisticated because they follow the attacker after theft.

- **Common exam scenario**: "An attacker downloads a file named `admin_credentials.txt` from a network share. Which deception technique detected this?" → **Honeyfile** (triggered an alert on access).

- **Honeytokens in the wild**: Exam may ask about **fake API keys** or **email addresses added to contact lists**. These are honeytokens because they track when/where the attacker uses them (you monitor if the email is posted online or the API is called).

- **Open-source focus**: The exam may ask which honeypot tools are freely available. Know that many honeypot frameworks (Cowrie, Dionaea, Modern Honey Network) are open-source—relevant for budget-conscious sysadmins.

- **Alert mechanism**: Always remember: honeypots and honeyfiles only work if **you're monitoring them**. No alert = no detection. Link this to [[SIEM]], [[IDS]], and [[Wazuh]].

---

## Common Mistakes

- **Thinking honeypots are only for large enterprises**: Small labs and homelabs use honeypots too. A Raspberry Pi running Cowrie SSH honeypot is as valid as a large honeynet.

- **Confusing honeypots with actual security controls**: Honeypots do NOT prevent attacks—they *detect* them. They should complement [[Firewall]], [[IDS]]/[[IPS]], and [[VPN]], not replace them.

- **Assuming attackers know they're in a honeypot**: Attackers often don't realize they've been lured into a decoy. This is the entire point—they waste time in a fake environment while you observe. However, advanced attackers may detect sandbox/honeypot signatures (anti-analysis evasion).

---

## Real-World Application

In Morpheus's [YOUR-LAB] homelab, a [[Wazuh]] agent could monitor for honeypot access and trigger alerts when fake credentials or honeyfiles are touched—integrating deception into the broader [[SOC]] workflow. For example, planting a fake LDAP service account password in a text file on an [[Active Directory]] domain controller allows you to catch lateral movement; if that password appears in a breach database, you've confirmed exfiltration and can correlate it with [[Forensics]] logs and [[MITRE ATT&CK]] techniques.

---

## Wiki Links

**Core Concepts:**
- [[Honeypot]]
- [[Honeynet]]
- [[Honeyfile]]
- [[Honeytoken]]
- [[Deception]]
- [[Disruption]]

**Detection & Response:**
- [[IDS]]
- [[IPS]]
- [[SIEM]]
- [[Wazuh]]
- [[Incident Response]]
- [[Forensics]]
- [[DFIR]]

**Infrastructure:**
- [[Active Directory]]
- [[LDAP]]
- [[Firewall]]
- [[VPN]]
- [[Tailscale]]

**Threat Intelligence & Frameworks:**
- [[MITRE ATT&CK]]
- [[NIST]]
- [[Metasploit]]
- [[Kali Linux]]

**Monitoring Tools:**
- [[Splunk]]
- [[Wireshark]]
- [[Nmap]]

---

## Tags

#domain-1 #security-plus #sy0-701 #honeypot #honeynet #threat-detection #deception #disruption #active-defense #threat-intelligence

---

## Study Checklist

- [ ] Define honeypot, honeynet, honeyfile, honeytoken in one sentence each
- [ ] Explain the difference between honeypots (passive) and active defense mechanisms
- [ ] Describe how honeytokens track attacker movement post-exfiltration
- [ ] Identify which deception technique fits a scenario (single decoy vs. network vs. file vs. traceable data)
- [ ] Understand that honeypots require monitoring/alerting to be effective
- [ ] Know common honeypot tools are open-source
- [ ] Practice distinguishing honeypots from [[IDS]]/[[IPS]]/firewalls

---

**Last Updated**: 2025 | **Difficulty**: Medium | **Exam Weight**: ~3–5 questions in Domain 1.0

---
_Ingested: 2026-04-15 23:25 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
