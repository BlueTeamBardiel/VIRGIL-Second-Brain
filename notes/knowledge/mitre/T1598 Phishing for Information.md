# T1598: Phishing for Information

## What Is It? (Feynman Version)
Think of a fishing pole cast into a lake full of fish. The bait on the hook is a carefully crafted email or message that lures the fish (the target) to bite, only to release a net that pulls out valuable fish (the data) rather than to deliver a net trap (malicious code).  

Phishing for information is an electronic social‑engineering attack that tricks a target into voluntarily handing over credentials or other sensitive data.

## Why Does It Exist?
Before this technique, attackers mainly tried to drop malware by embedding malicious code in emails. That approach failed when defenses like antivirus and sandboxing tightened. Attackers needed a method that bypassed code‑execution defenses by turning the target into the attacker’s weapon. By focusing on data theft rather than code, they could collect usernames, passwords, or even two‑factor tokens through human interaction, which is a far less detectable way to gain footholds.

## How It Works (Under The Hood)
1. **Reconnaissance** – Gather a list of target accounts (employee emails, corporate domains, etc.) and relevant social cues (company events, recent hires, industry jargon).
2. **Crafting the bait** –  
   * **Email spoofing**: Modify the `From:` header, add SPF/DKIM/DMARC‑spoofed signatures so the message appears legitimate.  
   * **Evasion**: Apply email hiding rules to obfuscate metadata, use short URLs, or embed links that point to compromised web forms.  
   * **Urgency or authority**: Pretend to be a CEO, a vendor, or an HR officer to lower scrutiny.  
3. **Delivery** – Send the spearphishing email, attachment, link, or voice message to selected targets.  
4. **Social engineering** – Once opened, the target is prompted to click a link, open an attachment, or call a phone number.  
5. **Data capture** –  
   * **Link**: Leads to a fake login page that logs credentials and may steal OTPs if the user enters them.  
   * **Attachment**: Might prompt the user to enable macros, which execute a payload that exfiltrates data.  
   * **Voice**: The attacker calls and pretends to be IT, prompting the target to reveal secrets.  
6. **Exfiltration** – Collected credentials or tokens are sent back to the attacker’s server for later use in lateral movement or credential stuffing.

## What Breaks When It Goes Wrong?
When the target detects the trickery (e.g., sees a mismatched domain, suspicious link, or hears a wrong voice tone), they may report the incident or simply refuse to comply. In such cases:

* **First line of impact**: The victim’s organization may suffer a **security incident** involving a reported phishing attempt.  
* **Operational blast radius**: If the phishing message contains a malicious attachment, it can still trigger malware detection, leading to quarantined files, disrupted email traffic, and increased security alert fatigue.  
* **Financial damage**: If the target does not comply but the attacker’s infrastructure still records the attempt, the attacker can later pivot to a different campaign, possibly stealing additional credentials.  
* **Reputational cost**: A high‑profile spearphishing incident can erode customer trust and attract regulatory scrutiny, especially if sensitive data is compromised.

---

## Overview
- **ID**: T1598
- **Tactic**: Reconnaissance
- **Platforms**: PRE (Pre-Compromise)
- **Created**: 02 October 2020
- **Last Modified**: 24 October 2025
- **Version**: 1.4

## Sub-techniques
- [[T1598.001]] - Spearphishing Service
- [[T1598.002]] - Spearphishing Attachment
- [[T1598.003]] - Spearphishing Link
- [[T1598.004]] - Spearphishing Voice

## Description

Phishing for information is electronically delivered [[social engineering]]. It differs from standard [[phishing]] in that the objective is data gathering rather than code execution.

Adversaries may:
- Conduct **targeted spearphishing** against specific individuals, companies, or industries
- Perform **mass credential harvesting** campaigns
- Obtain information via email, instant messages, or electronic conversation
- Direct victims to call phone numbers for credential collection
- Use [[Email Spoofing]] to fool recipients and automated security tools
- Apply evasive techniques like [[Email Hiding Rules]] to manipulate message metadata
- Employ social engineering (posing as authority, creating urgency)

## Threat Actors
- [[APT28]] - Spearphishing to compromise credentials
- [[Kimsuky]] - Tailored spearphishing for victim enumeration
- [[Moonstone Sleet]] - Email-based information gathering
- [[Scattered Spider]] - Credential phishing + OTP code capture
- [[ZIRCONIUM]] - Targeted campaign staff with credential phishing

## Mitigations
- **M1054 - Software Configuration**: Deploy [[SPF]], [[DKIM]], and [[DMARC]] for anti‑spoofing and email authentication
- **M1017 - User Training**: Train users to identify social engineering and spearphishing attempts

## Tags
#reconnaissance #phishing #social-engineering #credential-harvesting #mitre-attack

---  
_Ingested: 2026-04-15 20:48 | Source: https://attack.mitre.org/techniques/T1598/_