---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 046
source: rewritten
---

# DNS Attacks
**Attackers manipulate name resolution systems to redirect users toward malicious destinations**

---

## Overview
The [[Domain Name System]] serves as the internet's phonebook—converting human-readable domain names into their corresponding [[IP addresses]]. When attackers compromise this translation process through [[DNS poisoning]], they can silently redirect users to attacker-controlled websites without the user's knowledge. For Security+ candidates, understanding DNS attack vectors is critical because these attacks are pervasive, difficult to detect, and form the foundation of many advanced threats like [[phishing]] and [[man-in-the-middle attacks]].

---

## Key Concepts

### DNS Poisoning
**Analogy**: Imagine a postal worker secretly changing addresses in the town's address directory. Every letter meant for the bank gets rerouted to a criminal's warehouse instead.

**Definition**: The unauthorized modification of [[DNS]] records so that domain name queries return incorrect [[IP addresses]], directing traffic to attacker-controlled systems rather than legitimate destinations.

Related terms: [[DNS cache poisoning]], [[DNS spoofing]]

---

### Host File Manipulation
**Analogy**: Think of the host file as your computer's personal address book that it checks *before* asking the main directory. An attacker rewrites your personal book with fake addresses.

**Definition**: Modification of the local `/etc/hosts` (Linux/Mac) or `C:\Windows\System32\drivers\etc\hosts` (Windows) file to map domain names to malicious [[IP addresses]]. Your machine consults this file first, before querying any [[DNS server]].

**Key requirement**: The attacker needs [[elevated privileges]] or [[local access]] to alter this protected system file.

| Attack Vector | Access Required | Detection Difficulty | Scope |
|---|---|---|---|
| Host file edit | Local + Admin rights | Medium | Single machine |
| [[DNS server]] compromise | Network access + credentials | High | Organization-wide |
| [[Man-in-the-middle DNS]] | Network position | Medium | Session-based |

---

### Man-in-the-Middle DNS Interception
**Analogy**: A postal worker standing between the sender and receiver, intercepting each letter, reading it, and substituting it with a forged version before passing it on.

**Definition**: An attacker positioned on the network intercepts [[DNS query|DNS queries]] in transit and responds with falsified [[DNS response|DNS responses]] that point to attacker infrastructure. This requires the attacker to occupy a network position capable of observing and modifying traffic between the client and [[DNS server]].

Related concepts: [[ARP spoofing]], [[network sniffing]], [[packet injection]]

---

### Authoritative DNS Server Compromise
**Analogy**: Breaking into the main government records office and rewriting all official documents—the most damaging but hardest attack to execute.

**Definition**: Direct compromise of an authoritative [[DNS server]] itself, allowing attackers to permanently alter [[DNS records]] at the source. This affects all users globally querying that server and is significantly more destructive than client-side attacks.

**Why it's uncommon**: [[DNS servers]] are heavily fortified with [[firewall|firewalls]], [[intrusion detection systems]], security monitoring, and [[access controls]].

---

## Exam Tips

### Question Type 1: Attack Identification
- *"A user's computer is redirecting to a phishing site even though the DNS server shows the correct IP. What's the most likely cause?"* → Host file poisoning or [[local malware]]; check the `/etc/hosts` file first.
- **Trick**: Don't assume the [[DNS server]] is compromised—the exam often tests whether you understand that client-side attacks are far more common.

### Question Type 2: Prevention Methods
- *"Which mitigation prevents [[DNS cache poisoning]]?"* → [[DNSSEC]] (adds cryptographic validation to [[DNS responses]]), or using a trusted [[DNS server]].
- **Trick**: Host file manipulation isn't stopped by DNSSEC—it requires [[file integrity monitoring]] and [[access control]].

### Question Type 3: Attack Requirements
- *"An attacker modifies the company's authoritative DNS server. How much of the organization is affected?"* → Everyone using that [[DNS server]]—potentially the entire enterprise or internet users globally.
- **Trick**: Distinguish between attacks affecting one machine ([[host file]]) versus enterprise-scale damage ([[DNS server]] compromise).

---

## Common Mistakes

### Mistake 1: Confusing Host File and DNS Server Attacks
**Wrong**: "DNS poisoning always means the [[DNS server]] itself was hacked."
**Right**: DNS poisoning is a broad category. Host file modification is a type of local poisoning; [[DNS server]] compromise is a different, more severe variant.
**Impact on Exam**: You might select "implement [[DNSSEC]]" when the scenario actually requires "restrict administrative access to workstations"—missing the correct mitigation.

---

### Mistake 2: Underestimating Host File Risk
**Wrong**: "Host file attacks don't matter because they only affect one machine."
**Right**: In environments with [[malware]] delivery or insider threats, host file poisoning is often the *initial compromise vector* before lateral movement.
**Impact on Exam**: You might dismiss host file protections as low-priority, but Security+ tests knowledge of multi-layered defense—file permissions and [[monitoring]] matter.

---

### Mistake 3: Missing the "Position" Requirement for MITM DNS
**Wrong**: "An attacker can perform a [[man-in-the-middle DNS]] attack from anywhere on the internet."
**Right**: The attacker must occupy a network position where they can intercept traffic—same subnet ([[ARP spoofing]]), compromised router, or ISP-level access.
**Impact on Exam**: Understand the difference between theoretical attacks and practically executable ones—this separates domain knowledge from guessing.

---

## Related Topics
- [[Domain Name System (DNS)]]
- [[DNSSEC]]
- [[Man-in-the-Middle Attacks]]
- [[DNS Enumeration]]
- [[Subdomain Enumeration]]
- [[DNS Tunneling]]
- [[Firewall Rules]]
- [[Access Control Lists]]
- [[File Integrity Monitoring]]
- [[Intrusion Detection Systems]]
- [[Network Segmentation]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*