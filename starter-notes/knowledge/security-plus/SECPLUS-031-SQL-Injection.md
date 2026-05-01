---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 031
source: rewritten
---

# SQL Injection
**A malicious technique where attackers embed unauthorized database commands into user input fields to manipulate application behavior.**

---

## Overview
[[SQL Injection]] represents one of the most prevalent and dangerous [[Application Attacks]] encountered in modern software environments. This vulnerability occurs when developers fail to properly validate and sanitize user-supplied data before incorporating it into [[Database]] queries, allowing adversaries to execute arbitrary [[SQL]] commands. Understanding SQL injection is critical for Security+ candidates because it directly relates to secure coding practices, [[Input Validation]], and organizational risk assessment.

---

## Key Concepts

### SQL Injection Attack Vector
**Analogy**: Imagine a bank teller who asks for your account number, but instead of validating what you write, they literally read whatever you've written directly into their system commands—if you write "123 OR 1=1" instead of just "123," the system might reveal everyone's accounts instead of just yours.

**Definition**: A cyberattack method where threat actors insert malicious [[SQL]] statements into application input fields, causing the backend [[Database]] to execute unintended commands.

Related concepts: [[Structured Query Language]], [[Backend Systems]], [[Query Execution]]

| Attack Type | Mechanism | Typical Target |
|---|---|---|
| [[Union-Based Injection]] | Combines legitimate queries with attacker data | SELECT statements |
| [[Blind SQL Injection]] | Infers database structure through true/false responses | Authentication queries |
| [[Time-Based Injection]] | Uses database delays to extract information | Protected databases |

### Input Validation Failures
**Analogy**: It's like a nightclub bouncer who checks ID but never actually reads it—they just assume everyone who hands them a card is legitimate because they didn't bother to look carefully.

**Definition**: The absence of programmatic checks that examine, filter, and restrict user input to ensure only expected data formats are processed by the application.

Related concepts: [[Sanitization]], [[Whitelist Validation]], [[Parameterized Queries]]

### Database Query Construction
**Analogy**: Building a sentence by letting someone else insert random words into your pre-written story versus using a template where they can only fill in specific blanks designed for their content.

**Definition**: The process of dynamically building [[SQL]] commands by concatenating user input directly into query strings, which creates vulnerability when input lacks proper filtering.

Related concepts: [[String Concatenation]], [[Dynamic Queries]], [[Static Queries]]

### Exploitation Methodology
**Analogy**: Trying different keys in a lock until one works—attackers systematically probe input fields with special characters and [[SQL]] syntax to identify which fields accept malicious code.

**Definition**: The practical process attackers use to discover injection vulnerabilities through the browser interface or network traffic analysis, then craft payloads to manipulate database responses.

Related concepts: [[Payload Crafting]], [[Reconnaissance]], [[Browser Developer Tools]]

---

## Exam Tips

### Question Type 1: Vulnerability Identification
- *"A developer writes `SELECT * FROM users WHERE username = '` + inputUsername + `'`. What vulnerability exists?"* → [[SQL Injection]] due to direct string concatenation without input validation
- **Trick**: The exam may present code that "looks safe" but uses concatenation instead of [[Parameterized Queries]]—look carefully for the string building pattern

### Question Type 2: Mitigation Strategies
- *"Which of the following best prevents SQL injection attacks?"* → [[Prepared Statements]] with [[Parameter Binding]] or [[Stored Procedures]] with strict input validation
- **Trick**: Don't confuse [[Encryption]] with injection prevention—encryption protects data in transit, not execution; you need [[Input Sanitization]]

### Question Type 3: Attack Scenario Recognition
- *"An attacker enters `' OR '1'='1` into a login field. What is the attacker attempting?"* → Bypass [[Authentication]] by making the WHERE clause always evaluate to true
- **Trick**: Memorize common injection payloads like `OR '1'='1`, `--` comments, and `UNION SELECT` statements

---

## Common Mistakes

### Mistake 1: Confusing Input Validation with Encryption
**Wrong**: "We encrypted the user input, so SQL injection is prevented."
**Right**: [[Encryption]] protects data confidentiality; [[Input Validation]] prevents code execution. Both are needed—validation stops injection, encryption protects data.
**Impact on Exam**: Questions testing whether you understand the distinct purposes of security controls; you'll lose points if you suggest encryption as an injection fix.

### Mistake 2: Believing Blacklist Filtering is Sufficient
**Wrong**: "We blocked the word 'DROP' so SQL injection can't happen."
**Right**: Attackers have dozens of encoding methods, alternative syntax, and unicode bypasses—only [[Whitelist Validation]] and [[Parameterized Queries]] provide reliable protection.
**Impact on Exam**: You may see questions asking why a company's security approach failed; blacklist filtering is explicitly insufficient per Security+ standards.

### Mistake 3: Assuming Client-Side Validation Prevents Injection
**Wrong**: "Our JavaScript validation blocks special characters, so we're protected."
**Right**: Client-side validation is purely user-experience; attackers bypass browsers entirely using [[Burp Suite]], [[Postman]], or raw [[HTTP]] requests—validation must occur server-side in the application logic.
**Impact on Exam**: Questions specifically test whether candidates understand the layered approach; client-side alone is always wrong.

### Mistake 4: Mixing Up SQL Injection with XSS
**Wrong**: "SQL injection and [[Cross-Site Scripting]] are the same injection attack."
**Right**: [[SQL Injection]] targets the [[Database]] layer through [[SQL]] syntax; [[Cross-Site Scripting]] targets the [[Browser]] layer through [[JavaScript]] injection—different vulnerabilities, different defenses.
**Impact on Exam**: You'll encounter questions asking how to defend against specific injection types; confusing them means selecting wrong mitigation strategies.

---

## Related Topics
- [[Input Validation]]
- [[Parameterized Queries]]
- [[Prepared Statements]]
- [[Application Security]]
- [[Secure Coding Practices]]
- [[OWASP Top 10]]
- [[Cross-Site Scripting]]
- [[Code Injection]]
- [[Database Security]]
- [[Sanitization]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*