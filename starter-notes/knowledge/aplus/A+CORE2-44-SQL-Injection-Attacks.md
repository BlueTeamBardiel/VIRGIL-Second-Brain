---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 44
source: rewritten
---

# SQL Injection Attacks
**A technique where malicious code is inserted into user input fields to bypass authentication and extract unauthorized database information.**

---

## Overview

Think of your login screen like a restaurant reservation system. Normally, you say your name and the host looks it up in their book. But what if you said: "My name is Bob'; DROP TABLE reservations;--"? A [[SQL Injection Attack]] exploits poorly-built applications that don't properly filter user input before sending it to a [[database]]. For the A+ exam, you need to understand that this is a critical [[application security]] vulnerability where attackers inject malicious code (usually [[SQL]] commands) into input fields to manipulate database queries and steal or modify data.

---

## Key Concepts

### SQL Injection

**Analogy**: Imagine a bank teller who accepts written instructions from customers without checking them. A legitimate customer writes "Withdraw $100," but a crafty person writes "Withdraw $100 OR 1=1" — the second part tricks the system into processing every withdrawal, not just theirs.

**Definition**: A [[code injection]] vulnerability where an attacker inserts malicious [[SQL]] queries into application input fields (username boxes, search bars, etc.) to manipulate backend [[database]] operations and bypass [[authentication]].

| Attack Vector | Example | Risk Level |
|---|---|---|
| Login field | `admin' --` | Critical |
| Search box | `' OR '1'='1` | High |
| Form submission | `'; DROP TABLE users;--` | Critical |
| URL parameters | `?id=1 UNION SELECT password` | High |

### Input Validation

**Analogy**: A bouncer at a club checking IDs. Without validation, anyone walks in. With validation, the bouncer checks the ID, asks questions, and verifies legitimacy before letting you through.

**Definition**: The process where an application checks and filters all [[user input]] before processing it. Proper validation ensures only expected data types and formats enter the system, blocking suspicious characters and code attempts.

**Prevention Methods**:
```
✓ Whitelist acceptable characters (alphanumeric only)
✓ Use parameterized queries / prepared statements
✓ Escape special SQL characters
✓ Implement stored procedures
✓ Limit database user permissions (least privilege)
```

### Relational Database

**Analogy**: A spreadsheet with multiple sheets that talk to each other. Each sheet has rows and columns, and they're linked by common data (like student IDs appearing in both the "Grades" and "Contact Info" sheets).

**Definition**: A [[database]] structure that organizes data into tables with rows and columns, using [[SQL]] as the common query language. Examples include [[MySQL]], [[Microsoft SQL Server]], [[PostgreSQL]], and [[Oracle Database]].

### Authentication Bypass

**Analogy**: A keycard system that's supposed to match your ID to your access level, but the lock is broken and opens for *anyone* who swipes—not just authorized employees.

**Definition**: When an attacker circumvents [[authentication mechanisms]] (logins, passwords, security checks) by exploiting application flaws, granting unauthorized access to restricted data or functionality.

---

## Exam Tips

### Question Type 1: Identifying Vulnerable Code

- *"A web application accepts a username and directly inserts it into a SQL query without filtering. What type of attack is this vulnerable to?"* → [[SQL Injection Attack]]
- **Trick**: The exam may describe the vulnerability without using the term "SQL injection" — look for keywords like "user input directly into database query" or "no input validation."

### Question Type 2: Prevention Techniques

- *"Which of the following BEST prevents SQL injection attacks?"* → Parameterized queries / prepared statements (NOT just filtering special characters)
- **Trick**: Don't confuse simple string filtering with true prevention. Prepared statements are the gold standard because they separate code from data structurally.

### Question Type 3: Attack Vector Recognition

- *"A user enters `' OR '1'='1` into a login field. What is the attacker attempting to do?"* → Bypass authentication by making the SQL condition always evaluate to true
- **Trick**: This specific payload is a classic taught in security courses — if you see it, the answer involves authentication bypass or data extraction.

---

## Common Mistakes

### Mistake 1: Confusing SQL Injection with General Code Injection

**Wrong**: "SQL injection and [[command injection]] are the same thing—they both insert malicious code."

**Right**: [[SQL Injection]] specifically targets [[database]] query languages ([[SQL]]), while [[command injection]] targets operating system commands. [[LDAP injection]], [[XML injection]], and [[HTML injection]] exploit other languages.

**Impact on Exam**: You might be asked to identify *what type* of injection attack is occurring based on the target system. Getting this wrong means missing the specific mitigation strategy (SQL injections need [[parameterized queries]]; command injections need shell escaping).

### Mistake 2: Thinking Input Filtering Is Sufficient Protection

**Wrong**: "If we remove semicolons and dashes from user input, SQL injection is prevented."

**Right**: Attackers can use alternative SQL syntax that doesn't require these characters. Proper defense requires [[parameterized queries]] that structurally separate user data from SQL commands.

**Impact on Exam**: A question asking "Which is the BEST prevention?" If you pick "filter special characters," you'll lose points. The correct answer is almost always "use prepared statements" or "parameterized queries."

### Mistake 3: Assuming All Databases Are Equally Vulnerable

**Wrong**: "SQL injection only affects old databases like [[MySQL]]."

**Right**: Any [[relational database]] ([[MySQL]], [[SQL Server]], [[PostgreSQL]], [[Oracle]]) is vulnerable if the application doesn't use proper input validation and [[parameterized queries]].

**Impact on Exam**: The exam tests general database security principles, not database-specific vulnerabilities. Your prevention techniques should apply universally.

---

## Related Topics
- [[Input Validation]]
- [[Authentication Attacks]]
- [[Code Injection]]
- [[Prepared Statements]]
- [[Database Security]]
- [[Least Privilege Principle]]
- [[OWASP Top 10]]
- [[Application Hardening]]

---

*Source: CompTIA A+ Core 2 (220-1202) | Security & Vulnerability | [[A+]]*