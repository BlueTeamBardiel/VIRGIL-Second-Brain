---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 022
source: rewritten
---

# Phishing
**A deceptive social engineering attack that masquerades as legitimate communication to trick users into surrendering sensitive credentials or personal information.**

---

## Overview
[[Phishing]] represents one of the most prevalent attack vectors in modern cybersecurity, exploiting human psychology rather than technical vulnerabilities. For the Security+ exam, understanding phishing mechanics is critical because it forms the foundation of how attackers breach networks—often serving as the initial entry point before lateral movement and privilege escalation. This attack category appears frequently on SY0-701 because it combines multiple threat vectors: [[social engineering]], [[credential harvesting]], and [[impersonation]].

---

## Key Concepts

### Phishing Attack
**Analogy**: Phishing is like a fisherman casting a wide net into the ocean, hoping to catch fish. The attacker casts a wide net of deceptive messages hoping that *some* recipients will bite and reveal their credentials—the "catch" that enables further compromise.

**Definition**: A [[social engineering]] attack delivered through multiple communication channels ([[email]], [[SMS]], voice calls) where attackers impersonate trusted entities to deceive targets into disclosing sensitive information like usernames, passwords, or financial data.

**Key characteristics**:
- Sender spoofing (falsified source identity)
- Urgency creation (artificial deadlines)
- Impersonation of legitimate organizations
- Often contains suspicious links or attachments

| Attribute | Legitimate Email | Phishing Email |
|-----------|------------------|-----------------|
| Sender Address | Official domain (@company.com) | Spoofed or similar domain (@companyy.com) |
| Links | Destination matches displayed URL | URL points to attacker infrastructure |
| Grammar/Formatting | Professional, consistent branding | Spacing issues, font inconsistencies, poor grammar |
| Urgency | Minimal or business-appropriate | Artificial pressure ("confirm within 24 hours") |
| Request Type | Service-related information | Authentication credentials, PII |

---

### Spear Phishing
**Analogy**: Unlike a fisherman casting nets randomly, a spear fisherman researches *exactly where* the target fish swim and uses a specialized spear. Spear phishing targets *specific individuals* with personalized information gathered through [[OSINT]].

**Definition**: A targeted variant of phishing that leverages personal or organizational intelligence about the victim to increase success rates. Attackers research victims on [[social media]], company websites, and public records before crafting highly customized messages.

**Differentiation from standard phishing**:
- Uses victim's real name, job title, or department
- References specific projects or recent company activities
- Higher success rate (10-50% vs. 1-5% for mass phishing)

---

### Whaling
**Analogy**: A whale hunter doesn't cast nets for ordinary fish—they specifically hunt the largest, most valuable prey. Whaling targets the highest-value individuals in an organization.

**Definition**: Phishing attacks aimed exclusively at [[C-suite]] executives, board members, or other high-value targets whose compromise yields maximum organizational impact or access.

**Characteristics**:
- Extremely personalized (references specific deals, board meetings)
- Often impersonates other executives or external partners
- May involve extended reconnaissance over weeks or months
- Associated with [[business email compromise (BEC)]]

---

### Indicators of Compromise (Phishing)
**Analogy**: A counterfeit painting might use cheap materials, incorrect brush techniques, and historically inaccurate details. Similarly, phishing attempts contain telltale red flags when examined closely.

**Definition**: Observable signs within a message suggesting it is fraudulent rather than legitimate.

**Common indicators**:
- Misaligned or inconsistent branding/logos
- Generic greetings ("Dear User" vs. "Dear [Name]")
- Spelling and grammar errors
- URL mismatches (link text shows one domain, actual link is different)
- Requests for sensitive data via email (legitimate companies never do this)
- Suspicious sender domains (similar but not identical to legitimate domains)
- Artificial urgency or threats
- Typosquatting domains (rackspace.com vs. rackspce.com)

---

### Credential Harvesting
**Analogy**: A criminal creates a fake ATM machine that looks identical to a real one—when victims insert their card and enter their PIN, the attacker records the credentials for later exploitation.

**Definition**: The process of collecting valid usernames and passwords through fraudulent websites or forms, typically hosted on attacker-controlled infrastructure.

**Attack flow**:
1. Phishing email directs user to fake login page
2. Fake page mirrors legitimate site's appearance
3. User enters credentials thinking they're authenticating legitimately
4. Attacker captures credentials for future [[lateral movement]] or [[privilege escalation]]

---

## Exam Tips

### Question Type 1: Identifying Phishing Characteristics
- *"Which of the following is NOT a typical indicator of a phishing email?"* → **Correct answer**: Sender uses company's official domain with HTTPS encryption. **(Wrong answers would be)**: Generic greeting, artificial deadline, request for password via email, suspicious URL.
- **Trick**: Questions often include one completely legitimate characteristic mixed with obvious red flags. Read carefully—the question asks what is *NOT* typical.

### Question Type 2: Attack Classification
- *"An attacker researches a specific bank manager on LinkedIn, discovers they approve wire transfers, and sends a customized email impersonating the bank's CFO. What type of attack is this?"* → **Spear phishing** or **whaling** (depending on whether it targets one person vs. executives specifically).
- **Trick**: Distinguish between mass phishing (random targeting), [[spear phishing]] (researched individuals), and [[whaling]] (executive-only targeting).

### Question Type 3: Mitigation Strategies
- *"Which security control BEST prevents successful phishing attacks?"* → **Multi-factor authentication (MFA)** because even if credentials are harvested, the second factor prevents account compromise.
- **Trick**: User awareness training reduces *susceptibility* but doesn't *prevent* phishing attempts. Technical controls like email filtering, URL scanning, and MFA actually prevent compromise.

---

## Common Mistakes

### Mistake 1: Conflating Phishing with [[Pharming]]
**Wrong**: "Phishing and pharming are the same thing—both involve fake websites."
**Right**: [[Phishing]] is email-based social engineering; [[pharming]] is DNS poisoning that redirects legitimate URLs to malicious sites *without* requiring the user to click a malicious link.
**Impact on Exam**: You'll lose points if asked to distinguish attack vectors. Know that phishing requires user interaction (clicking a link), while pharming happens at the DNS layer transparently.

### Mistake 2: Assuming Phishing Requires Email
**Wrong**: "Phishing only happens via email—that's why it's called 'phishing.'"
**Right**: Phishing occurs across email, [[SMS]] (smishing), voice calls ([[vishing]]), social media, and instant messaging.
**Impact on Exam**: Questions increasingly reference phishing via non-email channels. Don't assume the attack vector based solely on the word "phishing."

### Mistake 3: Treating User Awareness Training as a Control
**Wrong**: "User awareness training prevents phishing attacks."
**Right**: Training reduces *likelihood* of user interaction but doesn't technically *prevent* the attack. Only technical controls ([[email filtering]], [[DNS filtering]], [[MFA]]) truly prevent successful compromise.
**Impact on Exam**: When asked "which control prevents phishing?" select technical answers (email authentication, [[DMARC]]/[[SPF]]/[[DKIM]], URL sandboxing). Training is important but not a "preventive control."

### Mistake 4: Overlooking Sender Spoofing Indicators
**Wrong**: "If the email claims to be from my bank and says @bank.com, it must be real."
**Right**: Sender addresses can be spoofed; examine the actual email header, not just the display name. A message might show "Bank of America <support@bank.com>" but the actual source is attacker@malicious.net.
**Impact on Exam**: Questions test whether you verify actual source versus display name. Always "check the headers," not just the formatted sender line.

---

## Related Topics
- [[Social Engineering]]
- [[Credential Harvesting]]
- [[Impersonation]]
- [[Email Authentication Protocols]] ([[SPF]], [[DKIM]], [[DMARC]])
- [[Multi-Factor Authentication (MFA)]]
- [[Spear Phishing]]
- [[Whaling]]
- [[Smishing]]
- [[Vishing]]
- [[Business Email Compromise (BEC)]]
- [[DNS Poisoning / Pharming]]
- [[User Awareness Training]]
- [[Email Filtering and Security]]

---

*Source: CompTIA Security+ SY0-701 | Phishing & Social Engineering Domain | [[Security+]]*