---
domain: "5.0 - Security Program Management and Oversight"
section: "5.5"
tags: [security-plus, sy0-701, domain-5, penetration-testing, red-team, reconnaissance]
---

# 5.5 - Penetration Tests

Penetration testing is a controlled, authorized security assessment where testers simulate real-world attacks to identify vulnerabilities in systems, networks, and physical infrastructure. This section covers the methodologies, perspectives, and reconnaissance techniques used in penetration testing—critical knowledge for understanding how organizations proactively defend against threats. For the Security+ exam, you must understand the different types of penetration tests, the distinction between offensive and defensive roles, and how reconnaissance (both passive and active) forms the foundation of any pentest engagement.

---

## Key Concepts

- **Penetration Test (Pentest)**: A controlled, authorized security assessment where testers attempt to exploit vulnerabilities to evaluate an organization's security posture and identify weaknesses before malicious actors do.

- **Red Team**: The offensive perspective in penetration testing; they actively attack systems and search for exploitable vulnerabilities and misconfigurations.

- **Blue Team**: The defensive perspective; they identify and respond to attacks in real-time, implement preventive controls, and block unauthorized access.

- **Integrated (Purple) Team**: A continuous process combining offensive and defensive perspectives—identifying vulnerabilities, patching systems, testing again, and iterating to improve security posture.

- **Physical Penetration Testing**: Assessing physical security controls by attempting to gain unauthorized access to buildings, secure areas, or systems through non-digital means (e.g., tailgating, lock bypassing, booting from alternative media).

- **Physical Security Bypass Vectors**:
  - Modifying the boot process
  - Booting from alternative media (USB, CD)
  - Modifying or replacing OS files directly
  - Circumventing locked doors, windows, or access controls

- **Working Knowledge Spectrum**: The level of information a pentester has about the target environment before engagement begins.

- **Known Environment (Full Disclosure)**: The pentester has complete information about systems, architecture, configurations, and credentials—used to test detection and response capabilities.

- **Partially Known Environment (Grey-box)**: A mix of known and unknown information; often focuses on specific systems, applications, or departments.

- **Unknown Environment (Black-box/Blind Test)**: The pentester has no prior information about target systems—the most realistic simulation of an external attacker.

- **Reconnaissance**: The intelligence-gathering phase before an attack; essential for understanding the target's security posture, minimizing attack surface, and mapping the network.

- **Passive Reconnaissance**: Gathering information from open, publicly available sources without directly interacting with the target system; leaves no trace in network logs or system alerts.
  - Social media profiles
  - Corporate websites
  - Online forums and Reddit
  - [[Social Engineering]] techniques (pretext calls, pretexting)
  - Dumpster diving (physical information gathering)
  - Business organization databases and WHOIS records

- **Active Reconnaissance**: Directly probing the target system to learn about its configuration; generates network traffic and log entries that may trigger alerts.
  - Ping scans (ICMP echo requests)
  - Port scans (TCP/UDP enumeration)
  - [[DNS]] queries and zone transfers
  - [[OS]] fingerprinting
  - Service and version identification scans
  - Attempting to access systems or resources ("trying the doors")

---

## How It Works (Feynman Analogy)

Imagine you're a security consultant hired to test whether a bank's security is truly secure. You can't just rush in attacking everything blindly—that would be inefficient and potentially dangerous. Instead, you first *watch and listen* from afar: you read the bank's website, follow their social media, talk to employees at coffee shops. You learn their operating hours, staffing patterns, and security vendors (passive reconnaissance—no one knows you're looking).

Once you understand the landscape, you start "testing the doors": you try entering through the main entrance to see if badges work, you knock on side doors, you examine the parking lot and delivery areas (active reconnaissance—you're now visible, possibly triggering alarms).

Then comes the actual attack: you use the intelligence you've gathered to find the weakest point—maybe an unlocked window, a misconfigured alarm, or an overly trusting employee—and you exploit it to gain access. Finally, you report back: "Here's what I found, and here's how you can fix it."

**In technical terms**: Reconnaissance is your intelligence phase (passive = OSINT; active = network probing). Your "known environment vs. unknown environment" is your rules of engagement. Red team = attackers; blue team = defenders; purple team = both working together in an iterative cycle. Physical penetration testing recognizes that digital locks are useless if someone can just reboot the machine or walk into the server room.

---

## Exam Tips

- **Distinguish between team roles clearly**: Red Team = offensive/attacking; Blue Team = defensive/responding. The exam will test whether you know which team does what. A question asking "who identifies attacks in real-time?" = Blue Team.

- **Recognize "Integrated" (Purple) as a continuous process**: This is the modern, realistic approach where offensive and defensive work together iteratively. Don't confuse it with a one-time test. It's about patching, testing again, and improving continuously.

- **Passive vs. Active reconnaissance is heavily tested**: Passive = no network footprint (social media, public databases, OSINT). Active = leaves traces (port scans, ping scans, DNS queries). Know which is which. A question saying "the pentester used [[Nmap]] to scan ports" = active reconnaissance (will show up in logs).

- **Physical penetration testing is often overlooked but testable**: Remember that OS security can be bypassed by physical means: modifying boot processes, booting from USB, directly modifying files. Physical security assessment includes evaluating doors, windows, tailgating, and facility access controls—not just network testing.

- **"Working knowledge" spectrum matters for scoping**: Full disclosure (known) = whitebox; partial = greybox; unknown = blackbox. The exam may ask which type is most realistic or which is best for detecting intrusions. Blackbox is most realistic to real-world attacks; whitebox is best for thorough assessment and testing detection.

---

## Common Mistakes

- **Confusing reconnaissance with the actual attack**: Many candidates think reconnaissance IS the penetration test. It's not—it's the *preparation* phase. The test is when you actually exploit the vulnerabilities you discovered. Passive reconnaissance is especially easy to miss as "non-intrusive" and therefore not part of the pentest, but it absolutely is.

- **Thinking physical security and network security are separate concerns**: Candidates often treat physical and cyber penetration testing as completely different domains. The exam tests that they're intertwined: an attacker who can physically access a server can bypass all your [[encryption]] and [[firewall]] rules by modifying the boot process or replacing the OS. Physical security must inform network security strategy.

- **Misremembering active reconnaissance as undetectable**: Active reconnaissance (port scans, pings) *will* generate network traffic and appear in logs/[[IDS]]/[[IPS]] alerts. This is a key distinction from passive. Some candidates think active is "stealthier" because it's more direct—it's actually the opposite.

---

## Real-World Application

In Morpheus's [YOUR-LAB] homelab, penetration testing principles apply directly: you might run a passive reconnaissance phase by reviewing [[Active Directory]] user listings, corporate VLAN configurations, and [[Wazuh]] baseline logs. Then active reconnaissance: [[Nmap]] scans against your internal network, [[DNS]] queries, fingerprinting your lab's Ubuntu and Windows VMs. Finally, a red team engages in a simulated attack while the blue team (running [[Wazuh]] and network monitoring) detects and responds in real-time. An integrated approach means you patch discovered vulnerabilities, rebuild affected systems, and run the test again—continuously improving your lab's security posture. Physical testing might include assessing whether an attacker could reboot a [YOUR-LAB] node without authorization or physically access your home network hardware.

---

## Wiki Links

**Core Concepts**:
- [[Penetration Testing]]
- [[Red Team]]
- [[Blue Team]]
- [[Purple Team]]
- [[Physical Security]]
- [[Reconnaissance]]
- [[Passive Reconnaissance]]
- [[Active Reconnaissance]]

**Tools & Techniques**:
- [[Nmap]]
- [[Metasploit]]
- [[Kali Linux]]
- [[Wireshark]]
- [[OS Fingerprinting]]
- [[Port Scanning]]
- [[DNS Enumeration]]
- [[Social Engineering]]

**Related Security Concepts**:
- [[Network Security]]
- [[Vulnerability Assessment]]
- [[Incident Response]]
- [[IDS]]
- [[IPS]]
- [[Firewall]]
- [[SIEM]]
- [[Wazuh]]

**Homelab Tools & Infrastructure**:
- [[Active Directory]]
- [[Tailscale]]
- [[[YOUR-LAB] Fleet]]
- [[Nmap]]
- [[Wazuh]]

**Frameworks & Standards**:
- [[NIST]]
- [[MITRE ATT&CK]]
- [[CIA Triad]]
- [[Zero Trust]]

**Related Exam Topics**:
- [[5.0 - Security Program Management and Oversight]]
- [[Vulnerability Management]]
- [[Risk Assessment]]
- [[Security Controls]]
- [[Threat Modeling]]

---

## Tags

#domain-5 #security-plus #sy0-701 #penetration-testing #red-team #blue-team #reconnaissance #physical-security #active-reconnaissance #passive-reconnaissance #homelab-security

---
_Ingested: 2026-04-16 00:30 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
