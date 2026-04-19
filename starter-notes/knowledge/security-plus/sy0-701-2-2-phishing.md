---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.2"
tags: [security-plus, sy0-701, domain-2, phishing, social-engineering, threat-vectors]
---

# 2.2 - Phishing

Phishing is a [[Social Engineering]] attack that combines deception and [[Spoofing]] to trick users into divulging sensitive information, clicking malicious links, or downloading malware—typically via email, text, or voice communications. Understanding phishing mechanics and its variants is critical for the Security+ exam because it represents one of the most common attack vectors in real-world organizations and directly tests your knowledge of threat recognition and user awareness. This section covers the fundamentals of phishing attacks, the psychology behind their success, and the multiple delivery channels attackers use to compromise users and systems.

---

## Key Concepts

- **Phishing**: A broad category of [[Social Engineering]] attacks using deception (often via email, SMS, or phone) to trick users into revealing credentials, financial information, or deploying [[Malware]]. The attacker typically impersonates a trusted source.

- **Spoofing**: The act of forging or falsifying sender information (email addresses, caller ID, domain names) to appear legitimate. Not the same as phishing itself—spoofing is the *tool*, phishing is the *attack*.

- **Business Email Compromise (BEC)**: A sophisticated phishing variant targeting organizations by spoofing executive or vendor email addresses to authorize fraudulent wire transfers, modify payment details, or extract sensitive data. Often involves reconnaissance and social engineering of finance teams.

- **Typosquatting (URL Hijacking)**: Registering domain names that are intentionally misspelled versions of legitimate domains (e.g., `professormessor.com` vs. `professormessor.com`) to capture users who mistype URLs or fall for visual similarity.

- **Pretexting**: The attacker fabricates a false scenario or assumed identity to establish trust and extract information. Example: "Hi, this is Visa calling about an automated payment issue on your utility bill—can you verify your account number?"

- **Vishing (Voice Phishing)**: Phishing conducted over the phone or voicemail. Often involves [[Caller ID Spoofing]] to make the call appear to come from a trusted source (bank, IT department, etc.).

- **Smishing (SMS Phishing)**: Phishing delivered via Short Message Service (SMS/text messages). Often includes shortened URLs or requests for personal information; also vulnerable to [[Spoofing]].

- **Caller ID Spoofing**: Technology that allows an attacker to forge the phone number displayed on a recipient's caller ID, making malicious calls appear to originate from legitimate organizations.

- **Credential Harvesting**: A primary goal of phishing attacks—tricking users into entering usernames and passwords into fake login pages or responding to requests for authentication details.

- **Malware Distribution**: Many phishing emails contain malicious attachments or links that, when clicked, deliver [[Malware]], [[Ransomware]], or [[Trojan]] programs to the victim's system.

- **Financial Fraud Variants**: Phishing attacks designed to modify wire transfer instructions, inject fake invoices, or request payment redirection by impersonating vendors, executives, or financial institutions.

---

## How It Works (Feynman Analogy)

**The Con Artist Analogy:**
Imagine a skilled con artist standing outside a bank dressed in a bank uniform, holding a clipboard. They call out: "Excuse me, we're doing a security audit—can I verify your account number real quick?" You think they work for the bank, so you trust them. They take your information and disappear.

Phishing works the same way in the digital world. The attacker dresses up their email (or text, or phone call) to *look* like it's coming from someone you trust—your bank, your boss, your IT department. They use visual tricks (logos, familiar phrasing, urgent language) and technical tricks ([[Spoofing]] the sender address) to fool you into thinking the message is legitimate. When you "respond" (by clicking a link, entering credentials, or opening an attachment), you've handed them the information or access they wanted.

**The Technical Reality:**
The attacker may register a lookalike domain (typosquatting), craft an email with a spoofed sender address using [[SMTP]] protocol manipulation, and host a fake login page at a compromised or attacker-controlled server. When the victim clicks the link and enters credentials, those credentials are logged by the attacker, often in real-time. The attacker can then use those credentials for lateral movement, persistence, or financial fraud. Modern phishing campaigns often combine multiple vectors (email + SMS + voice) to increase the chance of success.

---

## Exam Tips

- **Distinguish phishing from spoofing:** Spoofing is the *technique* (forging sender info); phishing is the *attack goal* (social engineering to extract info). You can have spoofing without phishing, but phishing almost always uses spoofing.

- **Know the variants by delivery method:** 
  - **Email phishing** = traditional phishing with link/attachment
  - **Vishing** = phone/voicemail; test questions may mention [[Caller ID Spoofing]]
  - **Smishing** = SMS/text; shorter messages, often with URL shorteners
  - **BEC** = specifically targets business email; focuses on finance/executive compromise
  
- **Recognize the attack chain:** The exam often tests your understanding of the *sequence*: spoofed email → victim clicks → credential harvesting or [[Malware]] execution → attacker gains foothold. Understand where detection and prevention should occur.

- **Red flags to remember:** Spelling errors, mismatched domains (email claims to be from `bank.com` but the link goes to `b@nk.com`), urgent language ("Act now!"), requests for credentials or sensitive data, unsolicited attachments, and [[Caller ID Spoofing]].

- **Common exam trap:** Confusing phishing with [[Pretexting]]. Pretexting is the *false scenario* (lying about your identity to get information); phishing is the *delivery method* (email, SMS, phone). Pretexting can be a *component* of phishing, but they're not the same.

---

## Common Mistakes

- **Overlooking the "digital slight of hand":** Candidates often miss that phishing succeeds not because users are stupid, but because attackers are *good* at mimicry. The exam tests whether you understand that phishing fools even security-conscious people—don't dismiss it as "obvious."

- **Conflating all social engineering with phishing:** Not all [[Social Engineering]] is phishing (e.g., dumpster diving, physical tailgating, pretext calls that don't use email). Phishing specifically involves *electronic media* and deception. If the exam asks "What is the primary delivery vector?" the answer for phishing is email/SMS/phone, not in-person interaction.

- **Forgetting the business context in BEC:** Business Email Compromise is a *specific* type of phishing with high-value targets (finance teams, executives) and sophisticated reconnaissance. Don't confuse a generic phishing campaign with a targeted BEC attack—the exam may distinguish between the two.

---

## Real-World Application

In Morpheus's homelab environment, phishing awareness is critical because email-based attacks often serve as the initial entry point for broader infrastructure compromises. A [[Wazuh]] SIEM can be configured to monitor for suspicious email patterns, user authentication failures, and credential-stuffing attempts that follow phishing campaigns. Additionally, implementing [[MFA]] and conditional access policies in [[Active Directory]] mitigates the damage if user credentials are harvested via phishing. As a sysadmin, Morpheus should also run regular security awareness training and simulate phishing attacks to test user behavior—many organizations use third-party tools to send fake phishing emails and measure click rates, helping identify users who need additional training.

---

## Wiki Links

- [[Social Engineering]] — The broader category of human-focused attacks
- [[Spoofing]] — Forging sender information (email, caller ID, etc.)
- [[Phishing]] — This topic
- [[Vishing]] — Voice phishing over phone/voicemail
- [[Smishing]] — SMS/text-based phishing
- [[Pretexting]] — Assuming a false identity to extract information
- [[Typosquatting]] — Registering misspelled domain names
- [[Business Email Compromise (BEC)]] — Targeted phishing of finance/executive staff
- [[Caller ID Spoofing]] — Forging caller ID to appear legitimate
- [[Malware]] — Often the payload of phishing attacks
- [[Ransomware]] — A common outcome of phishing-delivered payloads
- [[Credential Harvesting]] — Primary phishing objective
- [[Trojan]] — Malware family often distributed via phishing
- [[SMTP]] — Protocol used to send/spoof emails
- [[MFA]] — Mitigation against phishing-harvested credentials
- [[Active Directory]] — Enterprise identity system vulnerable to phishing compromise
- [[Wazuh]] — SIEM for detecting phishing-related anomalies
- [[Incident Response]] — Process for handling phishing breaches
- [[User Awareness Training]] — Primary defense against phishing
- [[MITRE ATT&CK]] — Maps phishing to tactics like Initial Access (T1566)
- [[Threat Hunting]] — Proactive detection of phishing campaigns
- [[DNS]] — Often leveraged in phishing (typosquatting, redirection)
- [[TLS/SSL]] — Can be faked in phishing URLs (https:// looks legit)
- [[Zero Trust]] — Architecture that assumes phishing *will* succeed and limits lateral movement

---

## Tags

#domain-2 #security-plus #sy0-701 #phishing #social-engineering #threat-vectors #business-email-compromise #vishing #smishing #typosquatting #pretexting #spoofing #credential-harvesting #malware-distribution

---

## Study Checklist

- [ ] Define phishing and distinguish it from spoofing and pretexting
- [ ] Explain why phishing is so effective (psychology + technical misdirection)
- [ ] List and describe the four main phishing variants: email, vishing, smishing, BEC
- [ ] Recognize red flags: typos, domain mismatches, urgent language, unsolicited attachments
- [ ] Understand the attack chain: delivery → click → credential harvest or [[Malware]] execution
- [ ] Know how [[MFA]], user training, and email filtering mitigate phishing
- [ ] Be able to spot [[Caller ID Spoofing]] and fake login pages
- [ ] Understand that phishing is often the *first step* in a multi-stage attack (not the final goal)
- [ ] Practice distinguishing phishing exam questions from other [[Social Engineering]] attacks

---
_Ingested: 2026-04-15 23:32 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
