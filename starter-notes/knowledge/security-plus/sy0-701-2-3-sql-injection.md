---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.3"
tags: [security-plus, sy0-701, domain-2, sql-injection, code-injection, web-vulnerabilities]
---

# 2.3 - SQL Injection

SQL Injection ([[SQL Injection]]) is a [[code injection]] attack where an attacker inserts malicious [[SQL]] commands into user input fields, exploiting improper input validation to manipulate database queries. This topic is critical for Security+ because SQL injection remains one of the most common and dangerous web application vulnerabilities, capable of exposing, modifying, or destroying entire databases. Understanding how to identify, prevent, and mitigate SQL injection is essential for securing enterprise systems and applications.

---

## Key Concepts

- **[[Code Injection]]**: The act of inserting unauthorized code or commands into a data stream or application input field. Works across multiple languages and contexts (HTML, [[SQL]], XML, [[LDAP]], etc.).

- **Root Cause**: Enabled by **bad programming practices** — specifically, the failure to properly validate, sanitize, and escape user input before using it in database queries or dynamic code execution.

- **[[SQL Injection (SQLi)]]**: A specific type of code injection targeting database systems. An attacker crafts malicious SQL statements within input fields (forms, URL parameters, cookies) to modify or bypass the intended database query logic.

- **Attack Vector**: Most commonly executed through **web browsers** — forms, search bars, login fields, URL parameters, or any input mechanism that feeds data to a backend database.

- **Example Vulnerable Code**:
  ```sql
  SELECT * FROM users WHERE name = '" + userName + "'
  ```
  If `userName` contains `' OR '1'='1`, the query becomes:
  ```sql
  SELECT * FROM users WHERE name = '' OR '1'='1'
  ```
  The condition `'1'='1'` is always true, returning all user records.

- **Potential Impact**:
  - Unauthorized data access (viewing sensitive information)
  - Data modification or deletion
  - Privilege escalation (adding admin accounts)
  - [[Denial of Service]] (resource exhaustion)
  - Potential remote code execution on the database server

- **Input Validation vs. Sanitization**:
  - **Validation**: Checking that input matches expected format, type, and length
  - **Sanitization**: Removing or escaping dangerous characters
  - **Both are necessary** — neither alone is sufficient

- **Parameterized Queries (Prepared Statements)**: The primary defense mechanism. Separates SQL code structure from user-supplied data, preventing injection.

---

## How It Works (Feynman Analogy)

Imagine you're a manager at a restaurant, and you use a form to search your customer database. You ask your assistant to find all customers named "John" by running this instruction:

> "Look through the customer list and show me everyone named [CUSTOMER_NAME]"

Normally, you'd write "John" in the blank, and your assistant searches for John. But what if a malicious person writes this instead:

> "John' OR '1'='1"

Your instruction now reads:

> "Show me everyone named 'John' OR where 1 equals 1"

Since **1 always equals 1**, your assistant now shows you **every customer in the database** — not just Johns. The attacker has broken the intended logic by injecting extra instructions into your request.

**In technical reality**: A web application builds a database query by concatenating user input directly into SQL code without escaping or separating it. An attacker crafts input with SQL syntax (`'`, `OR`, `--`, etc.) to alter the query's logic, turning a harmless SELECT into a data dump, DELETE, or INSERT.

---

## Exam Tips

- **SQL Injection is a [[code injection]] subset** — the exam may test your understanding of how SQLi differs from other injection types (LDAP injection, XML injection, command injection). The key distinction: SQL injection specifically targets database query logic.

- **Look for vulnerable patterns in scenario questions**:
  - String concatenation with user input: `"SELECT * FROM table WHERE id = '" + userInput + "'"`
  - Missing input validation or sanitization
  - Direct SQL query construction (vs. parameterized queries)
  - Questions asking "what would prevent this attack?" → Answer: **parameterized queries**, **input validation**, **least privilege database accounts**

- **The exam loves the boolean-based SQL injection example**: `' OR '1'='1'` is the classic exam trope. Know it, recognize it, and understand how it bypasses authentication.

- **Prevention techniques to memorize**:
  - Parameterized queries / prepared statements
  - Input validation (whitelist acceptable values)
  - Escaping special characters
  - Principle of least privilege (database user account permissions)
  - Web Application Firewalls ([[WAF]])
  - Stored procedures (when properly implemented)

- **Common exam trap**: Confusing SQL injection with [[XSS]] (Cross-Site Scripting). Both are code injection attacks, but **SQLi targets databases**, while **XSS targets client-side browsers**. Know the distinction.

---

## Common Mistakes

- **Assuming input validation alone is sufficient**: Candidates often believe that just checking input length or type prevents injection. The exam tests whether you understand that **sanitization and escaping** are equally critical, and that **parameterized queries are the gold standard**.

- **Mixing up the attack surface**: Some candidates think SQL injection only happens in login forms. The exam will test that SQLi can be injected anywhere user input feeds into a database query — URL parameters, cookies, search fields, POST data, etc.

- **Forgetting about [[error-based SQL injection]]**: The exam may present a scenario where verbose database error messages leak schema information or sensitive data. Proper error handling (generic error messages to users, detailed logs for admins) is part of the mitigation strategy.

---

## Real-World Application

In your homelab environment ([YOUR-LAB] fleet), understanding SQL injection is crucial when hardening custom scripts that interact with [[Active Directory]] or backend databases. While [[Wazuh]] and [[SIEM]] tools help detect SQLi attacks via log analysis and [[IDS]]/[[IPS]] signatures, a sysadmin must also audit custom Python/Bash automation scripts that query databases to ensure they use parameterized queries or avoid dynamic query construction. This is especially important in multi-tenant or service provider scenarios where SQL injection could compromise isolation or privilege boundaries.

---

## [[Wiki Links]]

- [[Code Injection]] — parent concept; also covers LDAP injection, XML injection, command injection
- [[SQL Injection]] — the specific attack
- [[SQL]] — Structured Query Language
- [[Web Application Firewall]] ([[WAF]]) — can detect and block SQLi attempts
- [[OWASP Top 10]] — SQL injection consistently ranks in top vulnerabilities
- [[Input Validation]] — first line of defense
- [[Parameterized Queries]] — the proper defense mechanism
- [[Prepared Statements]] — alternative terminology for parameterized queries
- [[Principle of Least Privilege]] — limit database account permissions
- [[XSS]] — Cross-Site Scripting (similar injection type, different target)
- [[Error Handling]] — verbose errors can leak information; must be generic to users
- [[Active Directory]] — common target in enterprise environments
- [[Wazuh]] — can monitor and alert on SQLi patterns in logs
- [[SIEM]] — centralizes security alerts including SQLi detection
- [[IDS]]/[[IPS]] — can have signatures for common SQLi payloads
- [[NIST]] — provides secure coding guidelines
- [[MITRE ATT&CK]] — framework mapping attack techniques including exploitation

---

## Tags

`domain-2` `security-plus` `sy0-701` `sql-injection` `code-injection` `web-vulnerabilities` `input-validation` `database-security`

---
_Ingested: 2026-04-15 23:36 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
