# T1566: Phishing

Adversaries send phishing messages to gain initial access to victim systems through electronically delivered social engineering. This includes targeted spearphishing campaigns and mass malware spam.

## Overview

**Tactic:** [[Initial Access]]

**Platforms:** Identity Provider, Linux, Office Suite, SaaS, Windows, macOS

**ID:** T1566 | **Version:** 2.7 | **Last Modified:** 24 October 2025

## What Is It? (Feynman Version)

Imagine a courier who pretends to be a bank manager, handing you a letter that looks like a routine statement. Inside the envelope is a hidden key that, once opened, unlocks your safe.  
Phishing is that courier: a message that masquerades as a legitimate source to trick you into revealing sensitive information or executing malicious software.

## Why Does It Exist?

When humans are asked to act on trust—opening an email, clicking a link—there are no mechanical safeguards. Before email authentication standards (SPF, DKIM, DMARC) and security awareness training were widespread, attackers could simply send bulk emails that looked authentic and harvest credentials at scale. The 2013 Target breach, where attackers used a phishing email to steal vendor credentials, shows how quickly the absence of user verification can cascade into a large-scale compromise.

## How It Works (Under The Hood)

1. **Preparation**  
   * Choose a target or a group (e.g., finance staff).  
   * If a specific domain is needed, craft a spoofed address that passes simple client checks or use a compromised account.

2. **Message Construction**  
   * Use a legitimate-looking subject line and header.  
   * Insert malicious payload:  
     * **Attachment** – a disguised document that, when opened, runs an exploit or drops a downloader.  
     * **Link** – a URL that redirects through a legitimate-looking domain, then to a malicious landing page.  
   * Optionally embed the message in an existing email thread (thread hijacking) or embed it in a social‑media platform’s message.

3. **Delivery**  
   * Send via SMTP.  
   * Spoofing bypasses SPF by forging envelope‑from or relies on domains with weak SPF.  
   * DKIM signatures may be forged or omitted; DMARC may be set to “none” for the target domain.

4. **Execution**  
   * Recipient opens the attachment or clicks the link.  
   * A browser or document viewer triggers a script that:
     * **Downloads** a payload from a remote server.  
     * **Executes** it, creating a foothold (e.g., installing a RAT).  
   * Credentials are harvested if the link leads to a spoofed login page.

5. **Persistence**  
   * The attacker creates user accounts or installs backdoors, ensuring continued access even after the initial victim is removed.

## What Breaks When It Goes Wrong?

The first sign is a compromised credential: an employee’s account gets used to log in from an unfamiliar location. IT notices a spike in outbound traffic to a known malicious IP. The human cost unfolds in stages:

1. **Credential Theft** – payroll or executive accounts are hijacked, giving attackers corporate network access.  
2. **Malware Spread** – once inside, ransomware or data‑exfiltration tools propagate.  
3. **Data Loss** – sensitive files are encrypted or exfiltrated, leading to regulatory fines and loss of customer trust.  
4. **Operational Downtime** – essential services shut down while the incident is contained, costing staff hours and revenue.

The blast radius can extend from a single workstation to the entire supply chain, especially if the phishing message arrives via a vendor or service provider.

## Sub-techniques

- [[T1566.001]] - Spearphishing Attachment
- [[T1566.002]] - Spearphishing Link
- [[T1566.003]] - Spearphishing via Service
- [[T1566.004]] - Spearphishing Voice

## Attack Methods

- **Malicious Attachments/Links:** Emails containing executable payloads or URLs to compromise victim systems
- **Third-party Services:** Phishing via [[social media]] platforms and other hosted services
- **Email Manipulation:** Removing or modifying [[email]] metadata, [[Email Hiding Rules]], and [[Email Spoofing]] to impersonate trusted sources
- **Thread Hijacking:** Including targets in existing email threads with malicious content
- **Call-back Phishing:** Messages instructing victims to call numbers leading to malicious URLs or malware downloads

## Threat Actors

Actors using this technique:
- [[AppleJeus]], [[Axiom]], [[GOLD SOUTHFIELD]], [[Kimsuky]], [[Sea Turtle]], [[INC Ransom]], [[Royal]]

## Mitigations

- **M1049:** [[Antivirus/Antimalware]] - Automatic quarantine of suspicious files
- **M1047:** [[Audit]] - Scan systems for weaknesses in permissions and configurations
- **M1031:** [[Network Intrusion Prevention]] - Block phishing traffic

## Tags

#mitre-att-ck #initial-access #phishing #social-engineering #email

---  
_Ingested: 2026-04-15 20:48 | Source: https://attack.mitre.org/techniques/T1566/_