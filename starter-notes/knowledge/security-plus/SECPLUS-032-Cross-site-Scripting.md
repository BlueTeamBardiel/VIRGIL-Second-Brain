---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 032
source: rewritten
---

# Cross-site Scripting
**A web vulnerability where attackers inject malicious code into trusted websites to compromise user browsers.**

---

## Overview
[[Cross-site Scripting (XSS)]] represents one of the most prevalent threats to web application security and appears frequently on the Security+ exam. This attack exploits the trust relationship between your browser and legitimate websites by injecting hostile [[JavaScript]] code that executes in the victim's browser context. Understanding XSS mechanisms, attack vectors, and mitigation strategies is critical for any security professional.

---

## Key Concepts

### Cross-site Scripting (XSS)
**Analogy**: Imagine a trusted bank teller (the website) who normally handles your account correctly. A criminal (attacker) writes instructions on a piece of paper and tricks you into handing it to the teller, who then executes those malicious instructions thinking they came from you.

**Definition**: A [[web application vulnerability]] where an attacker injects malicious [[JavaScript]] or other [[client-side script|client-side scripts]] into a webpage viewed by other users. The victim's [[browser]] executes this code within the security context of the trusted website, allowing the attacker to steal [[session tokens]], [[authentication credentials]], or manipulate page content.

**Why It's Dangerous**: The [[browser]] trusts content from legitimate domains. When malicious code comes from that trusted source, the browser executes it with full privileges associated with that site.

---

### Nomenclature: Why "XSS" and Not "CSS"?
**Analogy**: Two people with similar initials might both claim the same nickname—so one has to choose a different one to avoid confusion.

**Definition**: The term [[XSS]] (not [[CSS]]) is used to differentiate from [[Cascading Style Sheets (CSS)]], which was already established as the standard abbreviation for styling web content. Security professionals adopted the "X" to prevent ambiguity and maintain clarity in threat discussions.

---

### Attack Vector Categories

| Attack Type | Description | Execution Context | Persistence |
|---|---|---|---|
| [[Reflected XSS]] | Malicious script in URL parameter, reflected back by server | Immediate, user-triggered | Non-persistent |
| [[Stored XSS]] | Payload saved in database, delivered to all users viewing that content | Server-side delivery | Persistent |
| [[DOM-based XSS]] | Vulnerability in client-side [[JavaScript]] processing of user input | Browser's [[DOM]] | Non-persistent |

---

### JavaScript as the Primary Vector
**Analogy**: [[JavaScript]] is like a universal remote control that works in every home. An attacker who gains access to that remote can control anything—lights, TV, door locks—without needing physical access to each device.

**Definition**: [[JavaScript]] is the dominant scripting language in modern browsers, enabled by default in virtually all user environments. This ubiquity makes it the primary weapon for XSS attacks, as attackers can leverage it to access [[cookies]], [[session storage]], [[DOM]] elements, and [[HTTP]] requests initiated by the victim's browser.

**Key Point**: Disabling [[JavaScript]] is impractical for users because modern web applications require it for functionality.

---

### The Trust Model Exploitation
**Analogy**: Your house has locks to keep strangers out, but you leave the door unlocked for your spouse. An attacker pretends to be your spouse and walks right in.

**Definition**: [[XSS]] exploits the [[same-origin policy (SOP)]] weakness by delivering malicious content through a channel the victim's browser considers trusted. The [[browser security model]] assumes content from Domain A can access Domain A's [[cookies]], [[localStorage]], and user data—but doesn't distinguish between legitimate and injected content.

---

## Attack Flow Diagram

**Typical XSS Attack Sequence:**

1. **Attacker crafts payload** → Malicious [[JavaScript]] code designed to steal data or perform actions
2. **Delivery method** → Email link, text message, social media post, or malicious advertisement
3. **Victim interaction** → User clicks link or visits compromised page
4. **Browser execution** → [[JavaScript]] runs with victim's permissions on trusted domain
5. **Data exfiltration** → [[Cookies]], [[credentials]], session tokens, or page content sent to attacker

---

## Exam Tips

### Question Type 1: Identifying XSS Vulnerability Scenarios
- *"A user receives an email with a link to a popular social media site. When they click it, JavaScript code executes that steals their login session. What type of attack is this?"* → [[Reflected XSS]] (code delivered via malicious URL parameter)
- *"A comment on a blog post contains JavaScript that executes for every visitor to that page. The malicious code was saved in the database. What type of attack occurred?"* → [[Stored XSS]] (persistent payload in database)
- **Trick**: Don't confuse the delivery method with the attack type. Both email links and compromised databases can deliver XSS—what matters is whether it's reflected or stored.

### Question Type 2: Mitigation and Prevention
- *"Which of the following best prevents XSS attacks? A) Disabling JavaScript B) Input validation and output encoding C) Using HTTPS D) Enabling firewalls"* → **B** (Input validation removes malicious characters; output encoding ensures code displays as text rather than executes)
- **Trick**: HTTPS protects data in transit but doesn't prevent XSS execution in the browser. Disabling JavaScript breaks modern sites.

### Question Type 3: Differentiating XSS from Related Attacks
- *"An attacker tricks a user into visiting a malicious site that performs actions on a legitimate bank website using the user's existing session. What attack is this?"* → [[Cross-site Request Forgery (CSRF)]], not XSS (CSRF doesn't inject code; it exploits trust via unwanted requests)
- **Trick**: Remember—XSS injects malicious code into trusted sites. [[CSRF]] tricks the browser into making unwanted requests. They're related but distinct.

---

## Common Mistakes

### Mistake 1: Confusing XSS with CSRF
**Wrong**: "XSS and CSRF are the same thing—they both exploit browser trust relationships."
**Right**: [[XSS]] injects malicious [[JavaScript]] into a trusted site that executes in the victim's browser. [[CSRF]] tricks the victim's browser into making unwanted requests to a trusted site on the attacker's behalf—no code injection required.
**Impact on Exam**: You may see questions asking "which attack injects code?" (XSS) versus "which attack makes unwanted requests?" (CSRF). Mixing these up guarantees wrong answers.

### Mistake 2: Thinking XSS Requires Server Compromise
**Wrong**: "The attacker must hack the website's server to perform an XSS attack."
**Right**: [[Reflected XSS]] requires no server compromise—the attacker simply embeds malicious code in a URL. The server reflects it back unmodified. Even [[Stored XSS]] sometimes succeeds through normal submission processes (comments, user profiles) if input validation is weak.
**Impact on Exam**: Questions may test whether you understand that vulnerability exists in the code logic, not necessarily in server breach scenarios.

### Mistake 3: Believing HTTPS Prevents XSS
**Wrong**: "If we use HTTPS, we're protected from XSS attacks."
**Right**: [[HTTPS]] encrypts data in transit but doesn't validate or sanitize code execution in the browser. Malicious [[JavaScript]] still executes client-side regardless of encryption.
**Impact on Exam**: Expect trick answers listing HTTPS as an XSS prevention method. It's not sufficient alone.

### Mistake 4: Underestimating Impact Scope
**Wrong**: "XSS is just annoying—it can't cause real damage like SQL injection."
**Right**: [[XSS]] allows attackers to steal [[session tokens]], manipulate [[credentials]], perform [[phishing]], distribute [[malware]], or redirect users to malicious sites. It's equally critical as other injection attacks.
**Impact on Exam**: You may see scenario questions asking what damage XSS can cause. Answer comprehensively: data theft, credential compromise, malware distribution.

---

## Related Topics
- [[JavaScript]]
- [[Cookie Theft]]
- [[Session Hijacking]]
- [[Input Validation]]
- [[Output Encoding]]
- [[Content Security Policy (CSP)]]
- [[Same-Origin Policy (SOP)]]
- [[Cross-site Request Forgery (CSRF)]]
- [[Web Application Firewall (WAF)]]
- [[Reflected Attack]]
- [[Stored Attack]]
- [[DOM (Document Object Model)]]
- [[Browser Security Model]]

---

*Source: CompTIA Security+ SY0-701 Curriculum | [[Security+]]*