# Knowledge Base — Master Index
> Practical reference for IT professionals transitioning into security. Dense, opinionated, hands-on.

This knowledge base is built for help desk workers breaking into security. Every note is written for someone who already understands computers but needs to go deeper — not beginner fluff, not dry textbook content.

---

## Core Categories

### [[Threat Actors]] — `threat-actors/`
Nation-state APTs, criminal groups, hacktivists, insiders — who is actually attacking you and how.

| Note | Description |
|---|---|
| **`README.md`** | [[APT28]], Lazarus, Sandworm, [[APT41]] profiles, TTPs vs IOCs, intelligence-driven defense |

### [[Malware]] — `malware/`
How the most dangerous malware families actually work — from delivery to detection.

| Note | Description |
|---|---|
| **`README.md`** | [[Emotet]], Ryuk, Cobalt Strike, Mimikatz, [[BloodHound]], NotPetya — mechanics and detection |

### [[DFIR]] — `dfir/`
Digital forensics and incident response — finding what happened after the breach.

| Note | Description |
|---|---|
| **`README.md`** | Windows artifacts, prefetch/registry/MFT, memory forensics with Volatility, chain of custody, timeline analysis, Eric Zimmerman tools |

### [[Network Security]] — `network-security/`
Defending the wire — NSM, IDS/IPS, segmentation, zero trust, forensics.

| Note | Description |
|---|---|
| **`README.md`** | NSM sensor placement, Snort/Suricata/Zeek comparison, firewall types, VLAN/DMZ/zero trust, Wireshark filters, NetFlow analysis |

### [[Web Security]] — `web-security/`
OWASP Top 10 and beyond — the #1 attack surface explained.

| Note | Description |
|---|---|
| **`README.md`** | OWASP Top 10 2021 full breakdown with real examples, detection, prevention, tools (Burp/ZAP/sqlmap) |

### [[Ransomware]] — `ransomware/`
The threat that shut down hospitals — end-to-end mechanics, major incidents, defenses.

| Note | Description |
|---|---|
| **`README.md`** | Full kill chain, RaaS economy, WannaCry/NotPetya/Colonial/Change Healthcare incidents, 3-2-1 backups, SIEM detection, should you pay? |

### [[Identity]] — `identity/`
IAM, Kerberos, NTLM, SSO, MFA — identity is the new perimeter.

| Note | Description |
|---|---|
| **`README.md`** | AuthN vs AuthZ, MFA factor strength, SAML/OAuth/OIDC, Kerberos golden/silver ticket, NTLM relay, PAM, identity attacks |

### [[Blue Team]] — `blue-team/`
SOC operations, threat hunting, detection engineering — defending in practice.

| Note | Description |
|---|---|
| **`README.md`** | Red/blue/purple teams, SOC tiers, alert fatigue, threat hunting hypotheses, Sigma/YARA rules, MTTD/MTTR metrics, career path |

### [[Wireless Security]] — `wireless/`
Attacking and defending WiFi — WPA2 weaknesses, evil twin, 802.1X, WIDS.

| Note | Description |
|---|---|
| **`README.md`** | WPA2 handshake + PMKID attacks, evil twin with [[CAIM]], deauth, 802.1X/RADIUS/EAP, wireless forensics |

---

### [[Security]] — `security/`
Certifications, career pathways, foundational concepts, and major CVE deep-dives.

| Note | Description |
|---|---|
| `comptia-security-plus.md` | Security+ certification overview, exam domains, study strategy |
| `professor-messer-security-plus-sy0-701.md` | Free video course — how to use Messer effectively |
| `tryhackme-presecurity-path.md` | Pre-Security path breakdown — networking, Linux, web fundamentals |
| `tryhackme-soc-level-1.md` | SOC Level 1 path — the blue team career on-ramp |
| `tryhackme-cybersecurity-101.md` | Cybersecurity 101 path overview |
| `log4shell-cisa-advisory.md` | Log4Shell (CVE-2021-44228) CISA advisory |
| `cisa-aa17-164a-eternalblue-wannacry.md` | EternalBlue / WannaCry CISA advisory |
| `cve-2021-34527.md` | PrintNightmare Microsoft advisory |

### [[PowerShell]] — `powershell/`
Windows automation and security through PowerShell — shared by admins and attackers.

| Note | Description |
|---|---|
| **`README.md`** | 10 commands with syntax/examples/security angle, logging setup, attack detection, one-liners |
| `powershell-overview.md` | Microsoft official overview (ingested) |

### [[Windows]] — `windows/`
Windows administration, security hardening, event log analysis, and baseline configuration.

| Note | Description |
|---|---|
| **`event-ids.md`** | The 20 event IDs every security analyst needs — patterns, Splunk queries, attack signatures |
| **`hardening.md`** | GPO hardening, CIS benchmarks, LAPS, Credential Guard, ASR rules, quick wins |
| `ad-ds-overview.md` | Active Directory Domain Services overview from Microsoft |
| `windows-security-baselines.md` | Microsoft security baseline configuration guide |
| `windows-event-logs-guide.md` | Windows Event Logs — key IDs, analysis techniques |

### [[Linux]] — `linux/`
Linux command line and system administration for IT/security work.

| Note | Description |
|---|---|
| **`commands.md`** | 30+ essential commands with syntax, flags, real-world use, and attack context |
| `linux-shell-learning-guide.md` | linuxcommand.org guide (ingested) |
| `overthewire-bandit.md` | OverTheWire Bandit wargame — Linux CTF for beginners |

### [[Networking]] — `networking/`
Network fundamentals, protocols, Nmap, and packet analysis.

| Note | Description |
|---|---|
| `osi-model.md` | OSI 7-layer model — Cloudflare reference |
| `network-packet-fundamentals.md` | What is a network packet — Cloudflare reference |
| `nmap-reference-manual.md` | Nmap manual — scan types, flags, NSE scripts |
| `packet-networking.md` | Additional packet/networking fundamentals |

### [[Automation]] — `automation/`
Bash, Python, Ansible, and cron — the automation toolkit every IT career needs.

| Note | Description |
|---|---|
| **`README.md`** | Bash scripting, Python IT automation, Ansible basics, cron, 4 real automation examples |

### [[Splunk]] — `splunk/`
Splunk SIEM — SPL, essential SOC searches, free training path.

| Note | Description |
|---|---|
| **`README.md`** | SPL fundamentals, essential SOC searches, stats/rex/transaction, free training resources |
| `splunk-fundamentals-1-training.md` | Splunk free course overview (ingested) |
| `splunk-search-tutorial.md` | Splunk search tutorial docs (ingested) |
| `splunk-101.md` | TryHackMe Splunk 101 room (ingested) |
| `tryhackme-investigating-with-splunk.md` | TryHackMe investigation scenario (ingested) |

### [[TryHackMe]] — `tryhackme/`
Guided cybersecurity training — the fastest path from help desk to security analyst.

| Note | Description |
|---|---|
| **`README.md`** | THM vs HTB, recommended path order, cert prep mapping, resume guidance, free vs paid |

### [[OSINT]] — `osint/`
Open source intelligence — tools, techniques, and defensive applications.

| Note | Description |
|---|---|
| **`README.md`** | Legal framework, people/org/infra/document intel, Google dorking cheat sheet, key tools |
| `osint-framework-overview.md` | OSINT Framework directory (ingested) |
| `osint-maltego.md` | What is OSINT — Maltego blog (ingested) |
| `ohsint-room.md` | TryHackMe OHSINT room (ingested) |

### [[Social Engineering]] — `social-engineering/`
The attack that bypasses every technical control — defense for help desk teams.

| Note | Description |
|---|---|
| **`README.md`** | Phishing/vishing/smishing/pretexting, 3 attack scenarios, help desk defense framework, red flags |

### [[Imaging]] — `imaging/`
OS deployment, imaging workflows, WDS/MDT/Intune, Sysprep.

| Note | Description |
|---|---|
| **`README.md`** | WDS/MDT/Intune/Autopilot, dd/Clonezilla/PXE, full Ubuntu+Windows 11 walkthroughs, Sysprep |

### [[Virtualization]] — `virtualization/`
Hypervisors, VM networking, lab setup, and vulnerable machine resources.

| Note | Description |
|---|---|
| **`README.md`** | Type 1/2 hypervisors, Proxmox/VMware/Hyper-V/VirtualBox, lab networking, vulnerable VM sources |
| `hyper-v-windows-overview.md` | Microsoft Hyper-V overview (ingested) |
| `proxmox-getting-started.md` | Proxmox VE getting started (ingested) |
| `vmware-workstation-pro.md` | VMware Workstation Pro docs (ingested) |

### [[Homelab]] — `homelab/`
Building a hands-on lab at every budget level.

| Note | Description |
|---|---|
| **`budget-build.md`** | $0/$100/$500 tiers, free software stack, mini PC buying guide, resume talking points |
| `proxmox-ve-overview.md` | Proxmox VE product overview (ingested) |
| `reddit-homelab-wiki.md` | Reddit r/homelab wiki reference (ingested) |

### [[Job Search]] — `job-search/`
LinkedIn strategy, resume optimization, scam detection for IT/security roles.

| Note | Description |
|---|---|
| **`README.md`** | 100+ applicant rule, recent posting filters, scam detection, resume bullets, referral strategy |

### [[Incident Response]] — `incident-response/`
IR framework and step-by-step playbooks for common security incidents.

| Note | Description |
|---|---|
| **`playbooks.md`** | PICERL framework, phishing/malware/brute-force/exfil playbooks, tools reference |

### [[Cloud]] — `cloud/`
Cloud security fundamentals — AWS, Azure, shared responsibility, misconfigs.

| Note | Description |
|---|---|
| **`README.md`** | Shared responsibility, IAM/S3/CloudTrail, Entra ID, top 6 misconfigs, MITRE cloud techniques |
| `aws-cloud-security-overview.md` | AWS cloud security overview (ingested) |
| `azure-security-fundamentals.md` | Azure security fundamentals (ingested) |

### [[Cryptography]] — `cryptography/`
Encryption, hashing, PKI, and TLS — the vocabulary of secure systems.

| Note | Description |
|---|---|
| **`README.md`** | AES/RSA/ECC, MD5→bcrypt hashing, PKI chain of trust, TLS versions, common crypto failures |

### [[Tools]] — `tools/`
Core security tools — Wireshark, Burp Suite, Metasploit, Mimikatz, password crackers.

| Note | Description |
|---|---|
| `wireshark-user-guide-intro.md` | Wireshark introduction and setup |
| `burp-suite-getting-started.md` | Burp Suite desktop getting started |
| `metasploit-nmap-integration.md` | Metasploit + Nmap integration guide |
| `cmd-windows-command-interpreter.md` | Windows CMD interpreter reference |
| `john-the-ripper.md` | John the Ripper Kali docs (ingested) |
| `hashcat-wiki.md` | Hashcat wiki reference (ingested) |
| `crack-the-hash.md` | TryHackMe crack the hash room (ingested) |

### [[MITRE ATT&CK]] — `mitre/`
Individual technique, group, and software notes ingested from attack.mitre.org.

**Techniques (Execution / Persistence / Privilege Escalation)**

| Note | Description |
|---|---|
| `[[PowerShell (T1059.001)]].md` | T1059.001 — PowerShell execution |
| `[[T1059.003 Windows Command Shell]].md` | T1059.003 — Windows Command Shell |
| `[[T1053.005 Scheduled Task]].md` | T1053.005 — Scheduled Task/Job |
| `[[Process Injection (T1055)]].md` | T1055 — Process Injection |
| `[[access-token-manipulation]].md` | T1134 — Access Token Manipulation |
| `[[T1112 Modify Registry]].md` | T1112 — Modify Registry |
| `[[Domain or Tenant Policy Modification]].md` | T1484 — Domain Policy Modification |

**Techniques (Discovery)**

| Note | Description |
|---|---|
| `[[Process Discovery (T1057)]].md` | T1057 — Process Discovery |
| `[[T1069 Permission Groups Discovery]].md` | T1069 — Permission Groups Discovery |
| `[[T1082 System Information Discovery]].md` | T1082 — System Information Discovery |
| `[[T1083 — File and Directory Discovery]].md` | T1083 — File and Directory Discovery |
| `[[T1087 Account Discovery]].md` | T1087 — Account Discovery |
| `[[T1201 Password Policy Discovery]].md` | T1201 — Password Policy Discovery |

**Techniques (Lateral Movement / Initial Access)**

| Note | Description |
|---|---|
| `[[Exploit Public-Facing Application (T1190)]].md` | T1190 — Exploit Public-Facing App |
| `[[Supply Chain Compromise (T1195)]].md` | T1195 — Supply Chain Compromise |
| `[[T1199 Trusted Relationship]].md` | T1199 — Trusted Relationship |
| `[[T1200 Hardware Additions]].md` | T1200 — Hardware Additions |
| `[[T1210 Exploitation of Remote Services]].md` | T1210 — Exploitation of Remote Services |

**Techniques (Defense Evasion / C2)**

| Note | Description |
|---|---|
| `[[system-binary-proxy-execution]].md` | T1218 — System Binary Proxy Execution (LOLBins) |
| `[[Remote Access Tools (T1219)]].md` | T1219 — Remote Access Software |
| `[[Virtualization Sandbox Evasion (T1497)]].md` | T1497 — Virtualization/Sandbox Evasion |

**Techniques (Impact)**

| Note | Description |
|---|---|
| `[[T1486 Data Encrypted for Impact]].md` | T1486 — Data Encrypted for Impact (Ransomware) |
| `[[Service Stop (T1489)]].md` | T1489 — Service Stop |
| `[[T1490 Inhibit System Recovery]].md` | T1490 — Inhibit System Recovery |
| `[[T1491 — Defacement]].md` | T1491 — Defacement |
| `[[T1496 Resource Hijacking]].md` | T1496 — Resource Hijacking |
| `[[T1498 Network Denial of Service]].md` | T1498 — Network Denial of Service |
| `[[T1499 Endpoint Denial of Service]].md` | T1499 — Endpoint Denial of Service |

**Techniques (Credential Access / Account)**

| Note | Description |
|---|---|
| `t1003-os-credential-dumping.md` | T1003 — OS Credential Dumping |
| `[[t1098-account-manipulation]].md` | T1098 — Account Manipulation |
| `[[T1110 — Brute Force]].md` | T1110 — Brute Force |
| `t1566-phishing.md` | T1566 — Phishing |
| `t1598-phishing-for-information.md` | T1598 — Phishing for Information |

**Threat Actor Groups**

| Note | Description |
|---|---|
| `[[apt28]].md` | APT28 / Fancy Bear — Russian GRU |
| `[[APT29 (Cozy Bear)]].md` | APT29 / Cozy Bear — Russian SVR |
| `[[APT41]].md` | APT41 — Chinese dual espionage+financial |
| `[[Lazarus Group (MITRE G0032)]].md` | Lazarus Group — North Korean RGB |

**Malware / Software**

| Note | Description |
|---|---|
| `[[cobalt-strike]].md` | Cobalt Strike — weaponized C2 framework |
| `[[Emotet]].md` | Emotet — banking trojan loader |
| `[[ryuk-ransomware]].md` | Ryuk — human-operated ransomware |
| `[[bloodhound]].md` | BloodHound — AD attack path mapper |
| `[[PsExec (MITRE S0029)]].md` | PsExec — remote execution tool |
| `[[MITRE ATT&CK Enterprise Tactics Overview]].md` | Enterprise tactics overview |

### [[CCNA]] — `ccna/`
Cisco [[CCNA]] study notes ingested from exam prep materials.

| Note | Description |
|---|---|
| `acingtheccnaexamvolume1.md` | [[CCNA]] Vol 1 — networking fundamentals, OSI, routing |
| `acingtheccnaexamvolume2.md` | [[CCNA]] Vol 2 — advanced routing, switching, troubleshooting |

---

## URL-Ingested Notes — `inbox/`
Reference notes created from external sources, pending organization.

**Security Tools**

| Note | Description |
|---|---|
| `[[snort-ids-detection]].md` | Snort IDS rule writing and detection |
| `[[snort-3-rule-writing-guide]].md` | Snort 3 rule syntax reference |
| `[[suricata-ids]].md` | Suricata IDS/IPS documentation |
| `[[zeek-network-monitor]].md` | Zeek network analysis framework |
| `[[Zeek Bro]].md` | Zeek (formerly Bro) TryHackMe room |
| `[[cyberchef-overview]].md` | CyberChef data transformation tool |
| `[[thehive-incident-response-platform]].md` | TheHive IR case management |
| `[[elastic-security-siem]].md` | Elastic Security SIEM platform |
| `[[elk-101-investigation]].md` | TryHackMe Elastic/ELK 101 |
| `[[GTFOBins Unix Privilege Escalation]].md` | GTFOBins Unix privilege escalation |
| `[[LOLBAS Project]].md` | LOLBAS living off the land binaries |
| `[[portswigger-web-security-academy]].md` | PortSwigger Web Security Academy |
| `[[vulnhub-vulnerable-vms-overview]].md` | VulnHub vulnerable VMs |

**Certifications**

| Note | Description |
|---|---|
| `[[GIAC Certified Incident Handler (GCIH)]].md` | GIAC GCIH incident handler cert |
| `[[CompTIA PenTest+ Overview]].md` | CompTIA PenTest+ overview |
| `[[Certified Ethical Hacker (CEH) Certification]].md` | EC-Council CEH overview |
| `[[AWS Certified Security - Specialty]].md` | AWS Security Specialty cert |

**Networking / Learning**

| Note | Description |
|---|---|
| `[[Zero Trust Security]].md` | Cloudflare zero trust overview |
| `[[Identity and Access Management (IAM)]].md` | Cloudflare IAM overview |
| `[[vpn-overview]].md` | Cloudflare VPN overview |
| `[[dns-overview]].md` | Cloudflare DNS overview |
| `[[HTTPS TLS Overview]].md` | Cloudflare HTTPS/TLS overview |
| `[[firewall-overview]].md` | Cloudflare firewall types overview |
| `[[ddos-attack-overview]].md` | Cloudflare DDoS overview |
| `[[ransomware-overview]].md` | Cloudflare ransomware overview |
| `[[phishing-attack]].md` | Cloudflare phishing attack overview |
| `[[bgp-routing]].md` | Cloudflare BGP routing overview |
| `[[nmap-01]].md` | TryHackMe Nmap room |
| `[[wireshark-101]].md` | TryHackMe Wireshark 101 |
| `[[owasp-top-10]].md` | OWASP Top 10 ingested |
| `[[owasp-cheat-sheet-series]].md` | OWASP Cheat Sheet Series |
| `[[sans-cheat-sheets]].md` | SANS cheat sheet collection |

**CISA Advisories**

| Note | Description |
|---|---|
| `[[CISA Known Exploited Vulnerabilities Catalog]].md` | CISA Known Exploited Vulnerabilities catalog |
| `[[CISA AA23-347A ALPHV BlackCat Advisory]].md` | CISA ALPHV/Blackcat advisory |
| `[[CISA AA24-038A — Volt Typhoon Advisory]].md` | CISA Volt Typhoon advisory |
| `[[CISA Clop MOVEit Advisory (AA23-165A)]].md` | CISA Clop/MOVEit advisory |
| `[[CISA Hive Ransomware Advisory (AA22-321A)]].md` | CISA Hive ransomware advisory |

**MITRE Framework**

| Note | Description |
|---|---|
| `[[mitre-d3fend-framework]].md` | MITRE D3FEND defensive countermeasures |
| `[[mitre-car-analytics]].md` | MITRE CAR cyber analytics repository |

---

## Recommended Reading Order

**Help desk tech breaking into security:**
1. `tryhackme/README.md` — understand your training path
2. `linux/commands.md` — get CLI comfortable
3. `powershell/README.md` — Windows at the command line
4. `windows/event-ids.md` — learn what you're looking for in logs
5. `splunk/README.md` — learn to query those logs
6. `incident-response/playbooks.md` — what SOC analysts actually do
7. `blue-team/README.md` — how a SOC actually operates
8. `social-engineering/README.md` — defend your help desk role
9. `homelab/budget-build.md` + `virtualization/README.md` — build your lab
10. `automation/README.md` — start automating things
11. `cloud/README.md` — cloud is where the jobs are
12. `job-search/README.md` — apply with confidence

**CySA+ prep:**
→ `windows/event-ids.md`, `splunk/README.md`, `incident-response/playbooks.md`, `windows/hardening.md`, `cloud/README.md`, `blue-team/README.md`, `identity/README.md`, `threat-actors/README.md`, MITRE technique notes, `cryptography/README.md`

**Security+ prep:**
→ `security/comptia-security-plus.md`, `networking/osi-model.md`, `cryptography/README.md`, `cloud/README.md`, `social-engineering/README.md`, `identity/README.md`

**Threat intelligence track:**
→ `threat-actors/README.md`, `malware/README.md`, `ransomware/README.md`, MITRE group/software notes, CISA advisories in inbox/

**Pentest path:**
→ `osint/README.md`, `linux/commands.md`, `tools/`, `web-security/README.md`, `wireless/README.md`, MITRE technique notes, `tryhackme/README.md` (Jr Pentester path)

**DFIR/forensics track:**
→ `dfir/README.md`, `windows/event-ids.md`, `splunk/README.md`, `malware/README.md`, `incident-response/playbooks.md`

---

## Stats
- **Total notes:** 145+ across 27 categories
- **Hand-written notes:** 25 comprehensive references
- **URL-ingested inbox notes:** 43
- **MITRE technique/group/software notes:** 44
- **[[CCNA]] chunks:** 2
- **CISA advisories:** 5+

---

*Updated: [[Daily Feed Digest — 2026-04-15]] | [[VIRGIL]] knowledge base*