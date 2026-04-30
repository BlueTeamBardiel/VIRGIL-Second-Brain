```yaml
---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.4"
tags: [security-plus, sy0-701, domain-2, application-attacks, injection, buffer-overflow, replay-attack]
---

# 2.4 - Application Attacks

Application attacks exploit weaknesses in how software processes input, manages memory, and handles network communications. This section covers [[Injection Attacks]], [[Buffer Overflows]], and [[Replay Attacks]]—three fundamental vulnerability classes that appear frequently on the Security+ exam and represent real threats in production environments. Understanding these attack vectors is critical because they often result from poor coding practices and inadequate input validation, making them both preventable and exploitable.

---

## Key Concepts

### Injection Attacks
- **Definition**: Inserting malicious code or commands into a data stream that an application processes as legitimate instructions
- **Root Cause**: Inadequate input validation and improper handling of user-supplied data
- **Attack Surface**: Any application that accepts user input (web forms, API endpoints, command-line interfaces)
- **Variants by Technology**:
  - [[SQL Injection]] (SQLi) – injecting SQL commands into database queries
  - [[Code Injection]] – inserting executable code directly into application logic
  - [[LDAP Injection]] – injecting LDAP filter syntax into directory queries
  - [[XML Injection]] – injecting XML payloads to manipulate XML parsing
  - [[HTML Injection]] – injecting HTML tags into rendered web pages
  - **Command Injection** – inserting shell commands into system calls
- **Prevention**: Input whitelisting, parameterized queries, output encoding, [[Web Application Firewall|WAF]]

### SQL Injection (SQLi)
- **SQL** = Structured Query Language – the standard language for [[RDBMS|relational database management systems]]
- **Attack Mechanism**: Attacker crafts SQL statements within application input fields to execute unauthorized database commands
- **Common Delivery Methods**:
  - Form fields (login boxes, search bars)
  - URL parameters (query strings)
  - [[HTTP]] headers
  - Cookie values
- **Impact**: Data exfiltration, unauthorized data modification/deletion, authentication bypass, potential code execution
- **Exam Note**: Often presented as the most common injection attack; frequently appears in scenario questions

### Buffer Overflows
- **Definition**: Writing data beyond the allocated memory boundary of a buffer, causing data to spill into adjacent memory regions
- **Technical Mechanism**: Applications fail to perform **bounds checking** on input size versus buffer capacity
- **Exploitation Complexity**:
  - **High difficulty** – requires deep knowledge of memory layout, CPU architecture, and operating system
  - Time-intensive to develop reliable, repeatable exploits
  - Overflowing a buffer can easily crash the application (uncontrolled)
  - Attackers must carefully craft payloads to execute intended code without triggering a crash
- **Repeatability**: A "really useful" buffer overflow exploit can reliably compromise a system multiple times
- **Modern Mitigations**: 
  - Address Space Layout Randomization ([[ASLR]])
  - Stack canaries
  - Data Execution Prevention ([[DEP]]) / No-Execute ([[NX]]) bits
  - Safe coding practices (bounds checking, safe string functions)
- **Exam Context**: Often paired with discussion of secure coding and memory management

### Replay Attacks
- **Definition**: Capturing legitimate network traffic and retransmitting it to impersonate a user or perform unauthorized actions
- **Prerequisites**:
  - Access to raw network data (captured during transmission)
  - Ability to intercept and resend the captured data
- **Acquisition Methods**:
  - **Network tap** – physical access to network cables/switches
  - **ARP poisoning** – [[ARP|Address Resolution Protocol]] spoofing to redirect traffic
  - **Malware on victim computer** – keyloggers, packet sniffers
  - **Passive network sniffing** – if traffic is unencrypted
- **Attack Profile**: NOT an [[On-Path Attack|on-path/MITM attack]] – the actual replay does not require the attacker to remain in the communication stream
- **Prevention**: 
  - [[Encryption]] ([[TLS]], [[HTTPS]])
  - Session tokens with timestamps
  - Nonce values (number used once)
  - [[Sequence Numbers|Sequence numbering]]
  - Strong [[Authentication]] mechanisms

---

## How It Works (Feynman Analogy)

### Injection Attacks
Imagine a restaurant waiter who doesn't actually read what you write on your order form—they just mechanically pass whatever text you write directly to the kitchen's cooking system. If you write "chicken" they cook chicken, but if you write "chicken'; DELETE all ingredients;--" the cooking system interprets that as two commands: cook chicken AND erase all ingredients. The restaurant is broken because it blindly trusts your input.

**Technical Reality**: Web applications should validate/sanitize all user input before passing it to interpreters (SQL engines, XML parsers, command shells). When they don't, attackers craft payloads that include metacharacters (like SQL quotes and semicolons) that the parser interprets as commands rather than data.

### Buffer Overflows
Picture a small mailbox designed to hold exactly 10 letters. If the postal worker blindly shoves 15 letters into it, the extras spill out into the neighboring mailbox, potentially damaging what's stored there. In memory, when a program doesn't check the size of data before writing to a buffer, excess bytes overwrite adjacent memory—potentially corrupting program instructions or hijacking execution flow.

**Technical Reality**: The CPU executes code stored in memory sequentially. By carefully overflowing a buffer, attackers can overwrite the [[Return Address|return address]] on the call stack, redirecting program execution to malicious code. Modern defenses like [[ASLR]] make this harder because the attacker doesn't know exactly where malicious code will be located.

### Replay Attacks
Imagine a security guard who checks that you're carrying a valid badge, but doesn't care whether the badge is *yours*. You could photograph someone else's badge, print a copy, and walk in—the guard never checks if the badge matches your face or if you're using the same badge twice.

**Technical Reality**: Network protocols transmit authentication tokens or session data as "tickets." If an attacker captures this ticket (via packet sniffing, malware, or network tapping), they can replay it later to gain unauthorized access—because the server trusts the ticket format without verifying it's being replayed. Encryption and time-based tokens prevent this.

---

## Exam Tips

- **SQL Injection is the "gateway" injection attack** – if you see "injection" on the exam without specification, think SQLi first. It's the most commonly tested and the easiest to explain in scenario questions.

- **Injection vs. Buffer Overflow distinction**: Injection is about *data interpretation* (the parser reads your input and executes it as code); buffer overflow is about *memory corruption* (writing beyond memory boundaries). Don't confuse them—they're fundamentally different attack mechanisms.

- **Replay attacks require *prior access* to network traffic** – the exam often tests whether you understand that replaying data doesn't require real-time interception. A malware-infected endpoint can capture data today and replay it days later from a different location.

- **Prevention methods are testable**: 
  - Injection → parameterized queries, input validation, [[Web Application Firewall|WAF]]
  - Buffer overflow → bounds checking, [[ASLR]], [[DEP]]/[[NX]], safe coding
  - Replay → [[Encryption]], nonces, sequence numbers, timestamps
  - Expect "which of the following prevents X attack" questions.

- **Watch for "repeatable" language with buffer overflows** – the exam may phrase a question as "an attacker developed a buffer overflow that can be run multiple times to compromise the system." This indicates a successful, weaponized exploit (as opposed to a theoretical vulnerability). This is exam-speak for a *reliable* buffer overflow.

---

## Common Mistakes

- **Confusing injection with privilege escalation**: Injection is about forcing an application to execute unintended commands; privilege escalation is about gaining higher-level access. An injection attack *could lead to* privilege escalation, but they're not synonymous. The exam distinguishes between them.

- **Overestimating buffer overflow simplicity**: Candidates often think buffer overflows are easy exploits because they sound straightforward in concept. In reality, modern systems with [[ASLR]], [[DEP]], and stack canaries make them extremely difficult to exploit. The exam tests whether you understand *why* they're harder now and what mitigations exist.

- **Assuming replay attacks require active [[Man-in-the-Middle|MITM]] position**: Many candidates incorrectly answer replay attack questions by choosing "intercept and modify traffic" defenses. Replay attacks are passive capture + delayed playback. The exam explicitly states replay is NOT an on-path attack, so session [[Encryption]] and time-based tokens are the correct answers, not [[IDS]]/[[IPS]] or active monitoring.

---

## Real-World Application

In your [[[YOUR-LAB]]] fleet, injection attacks are monitored via [[Wazuh]] log correlation—if a web server logs unusual [[SQL Injection|SQL syntax]] errors or repeated failed queries, Wazuh alerts trigger. Buffer overflow protection relies on [[Active Directory]] domain policy enforcement (DEP/ASLR enabled across all systems), and replay attack risk is minimized by enforcing [[TLS]] encryption on all [[Tailscale]] VPN tunnels and internal services. A compromised [[[YOUR-LAB]]] node running malware could theoretically capture network traffic, making replay attacks a real threat if legacy unencrypted protocols ([[LDAP]] without [[StartTLS]], etc.) are exposed.

---

## Related Security+ Concepts

- [[CIA Triad]] – injection/buffer overflow attacks compromise [[Confidentiality]] and [[Integrity]]; replay attacks compromise [[Confidentiality]]
- [[Secure Coding Practices]] – input validation, bounds checking, safe libraries
- [[OWASP Top 10]] – injection and broken authentication are core web vulnerabilities
- [[Encryption]] – primary defense against replay attacks
- [[Input Validation]] – primary defense against injection attacks
- [[Defense in Depth]] – layered controls (WAF, parameterized queries, secure coding) reduce injection risk
- [[Vulnerability Assessment]] – identifying injection and buffer overflow weaknesses
- [[Penetration Testing]] – ethical exploitation of these attack vectors
- [[SIEM]] / [[Wazuh]] – detecting injection attack patterns in logs

---

## Wiki Links

**Attack Types**:
- [[Injection Attacks]]
- [[SQL Injection]]
- [[Code Injection]]
- [[LDAP Injection]]
- [[XML Injection]]
- [[HTML Injection]]
- [[Command Injection]]
- [[Buffer Overflow]]
- [[Replay Attack]]

**Related Defense Mechanisms**:
- [[Input Validation]]
- [[Output Encoding]]
- [[Parameterized Queries]]
- [[Web Application Firewall]]
- [[ASLR]]
- [[DEP]]
- [[NX]]
- [[Encryption]]
- [[TLS]]
- [[HTTPS]]
- [[Nonce]]
- [[Sequence Numbers]]

**Protocols & Standards**:
- [[SQL]]
- [[RDBMS]]
- [[LDAP]]
- [[XML]]
- [[HTTP]]
- [[ARP]]
- [[Tailscale]]

**Tools & Platforms**:
- [[Wazuh]]
- [[Active Directory]]
- [[[YOUR-LAB]]]
- [[Kali Linux]] (includes SQLi testing tools)
- [[Metasploit]] (exploitation framework)
- [[Burp Suite]] (web app testing)
- [[OWASP ZAP]] (injection scanning)

**Foundational Concepts**:
- [[CIA Triad]]
- [[Zero Trust]]
- [[Secure Coding]]
- [[OWASP Top 10]]
- [[Defense in Depth]]
- [[Vulnerability Assessment]]
- [[Penetration Testing]]
- [[SIEM]]
- [[Incident Response]]

---

## Tags

#domain-2 #security-plus #sy0-701 #injection-attacks #sql-injection #buffer-overflow #replay-attack #input-validation #secure-coding #web-security

```

---

**Study Notes for Morpheus:**

This section ties directly to **Domain 2.0** (22% of exam weight). Expect 2–3 questions on application attacks, typically in scenario format: "A web application is vulnerable to unauthorized database modifications. Which of the following best describes the attack vector?" (Answer: SQL Injection). 

Memorize the prevention techniques by attack type—they're heavily tested. The distinction between these three attack classes is critical; the exam loves asking candidates to match attack descriptions to the correct category.

---
_Ingested: 2026-04-15 23:46 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
