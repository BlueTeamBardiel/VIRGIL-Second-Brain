# SQL Injection

## What it is

In Counter-Strike, the **molotov-through-smoke** trick exploits a layering bug in how the engine renders particle effects: defenders see only the smoke cloud, but the burning molotov fluid underneath still applies damage ticks to anyone standing in it. The engine *trusts* that what's visually presented matches what's logically happening. Attackers weaponize that trust gap — the visual layer (smoke) is treated as the whole story, while a second, lethal layer rides along underneath.

SQL injection works the same way. The web form looks like it's just collecting a username. Underneath, the attacker has slipped extra SQL syntax into that "username" field, and the database engine — trusting that the application properly separated *data* from *commands* — happily executes both layers.

In plain English: **SQL injection is when an attacker types database commands into a field that's only supposed to accept data, and the backend database runs those commands.** Because the application glued user input directly into a query string, the database can no longer tell where the developer's instructions end and the attacker's instructions begin.

**Technical definition:** SQL Injection (SQLi) is a code injection attack against the data tier of an application in which untrusted input is concatenated into a SQL statement without proper parameterization or escaping, allowing the attacker to alter query semantics. Successful SQLi can disclose, modify, or destroy database contents; bypass [[authentication]]; execute stored procedures; read or write files; and in some configurations achieve remote code execution on the database host. SQLi is classified under [[CWE-89]] and is a perennial entry on the [[OWASP Top 10]].

For Security+ SY0-701, SQLi falls under **Objective 2.3 — Explain various types of vulnerabilities** (specifically *application vulnerabilities → injection*) and is also referenced in **Objective 2.4 (indicators of malicious activity)**.

---

## Why it matters

SQL injection has been the source of some of the largest breaches in history: TJX, Heartland, Sony Pictures, the 2017 Equifax-adjacent disclosures, and countless ransomware-precursor compromises. It remains potent in 2025–2026 because:

1. **It bypasses perimeter controls.** A [[firewall]] sees an HTTPS request to port 443 — perfectly normal. The malicious payload lives inside an allowed protocol.
2. **It reaches the crown jewels directly.** The database often holds [[PII]], credentials, payment data, and intellectual property. SQLi is a one-hop attack to the most sensitive tier.
3. **It enables [[authentication bypass]].** A classic `' OR '1'='1` payload can log an attacker in as the first user in the table — frequently an administrator.
4. **It scales.** Automated tools like `sqlmap` can fingerprint, enumerate, and dump entire schemas with a single command.

**Attack scenario:** A login form sends `username` and `password` to a backend that builds the query `SELECT * FROM users WHERE user='$u' AND pass='$p'`. The attacker submits `admin'--` as the username. The resulting query becomes `SELECT * FROM users WHERE user='admin'--' AND pass='whatever'`. The `--` comments out the password check. Attacker is now logged in as admin without knowing the password.

**Defense scenario:** A blue-team engineer reviews [[WAF]] logs and notices repeated requests containing `UNION SELECT`, `SLEEP(5)`, and `0x27` (hex for a single quote). They correlate with a spike in 500-errors from the application server, confirm the input parameter, and push a hotfix that switches the vulnerable endpoint to **parameterized queries** while the WAF blocks the source IP.

**Exam relevance:** CompTIA loves SQLi because it ties together input validation, secure coding, [[defense in depth]], and incident indicators all at once. Expect at least one performance-based or multiple-choice item touching SQLi on the SY0-701.

---

## Key facts

### Core mechanic — how the injection happens

Vulnerable code (PHP, illustrative):

```php
$query = "SELECT * FROM accounts WHERE user='" . $_POST['u'] . "'";
```

User input `' OR 1=1--` produces:

```sql
SELECT * FROM accounts WHERE user='' OR 1=1--'
```

`1=1` is always true → the WHERE clause matches every row. The `--` neutralizes the trailing quote.

The vulnerability is **string concatenation of untrusted input into a command interpreter**. The fix is **never let user data become code** — pass it through a parameterized API where the database engine binds the value to a placeholder and treats it as data, full stop.

### Types of SQL Injection (memorize for the exam)

| Type | How it works | Detection difficulty |
|------|-------------|---------------------|
| **In-band (Classic)** | Results returned in the same HTTP response as the request. Includes **error-based** and **UNION-based**. | Easiest |
| **Error-based** | Forces the DB to throw verbose errors that leak schema info. | Easy |
| **UNION-based** | Appends `UNION SELECT` to merge attacker-controlled rows into the legitimate result set. | Easy |
| **Blind (Inferential)** | No data in response; attacker infers results from app behavior. Includes **boolean-based** and **time-based**. | Medium |
| **Boolean-based blind** | Sends true/false conditions; observes whether page renders normally. | Medium |
| **Time-based blind** | Uses `SLEEP()`, `WAITFOR DELAY` to make the DB pause when a condition is true. | Medium |
| **Out-of-band (OOB)** | DB exfiltrates data via DNS or HTTP callback to an attacker-controlled server. Used when in-band/blind aren't viable. | Hard |
| **Second-order** | Payload is stored cleanly, then triggers when later concatenated into a different query. | Hard |

> **CompTIA exam trap:** Don't confuse **blind SQLi** with **stored SQLi**. *Blind* means no visible output. *Stored* (second-order) means the payload is persisted and detonates later. They can co-occur but are different attributes.

### Common payloads to recognize on sight

| Payload | Effect |
|---------|--------|
| `' OR '1'='1` | Auth bypass — tautology |
| `'; DROP TABLE users;--` | Stacked query, destructive (the "Bobby Tables" payload) |
| `' UNION SELECT username,password FROM users--` | Data exfiltration |
| `' AND SLEEP(5)--` | Time-based blind probe |
| `' AND 1=CONVERT(int,(SELECT @@version))--` | Error-based DB version disclosure |
| `'; EXEC xp_cmdshell('whoami')--` | MSSQL OS-command escalation |

### Indicators of compromise (Objective 2.4 crossover)

- Web logs showing **single quotes (`%27`)**, `--`, `/*`, `UNION`, `SELECT`, `SLEEP`, `BENCHMARK`, `WAITFOR` in query parameters
- Spikes in HTTP 500 errors tied to a specific endpoint
- Long-running database sessions or unusual `xp_cmdshell` invocations
- Unexplained outbound DNS queries from the database host (OOB SQLi)
- Database accounts performing reads against tables they don't normally touch

### Defenses — ranked by effectiveness

1. **Parameterized queries / Prepared statements** — *the primary control.* The query template is sent to the DB separately from the parameters. User input cannot become syntax.
   ```java
   PreparedStatement ps = conn.prepareStatement(
     "SELECT * FROM accounts WHERE user=? AND pass=?");
   ps.setString(1, user);
   ps.setString(2, pass);
   ```
2. **Stored procedures** — *only if* they're written without dynamic SQL inside them. A stored proc that internally concatenates input is just as vulnerable.
3. **Object-Relational Mappers (ORMs)** — Hibernate, Entity Framework, SQLAlchemy, Active Record. They use parameterization by default but can still be misused via raw-SQL escape hatches.
4. **Input validation (allow-listing)** — Validate type, length, format, and character set. Allow-list (e.g., "must be digits") beats deny-list ("must not contain `'`") every time.
5. **Output encoding / escaping** — A weaker fallback when parameterization isn't possible. Easy to get wrong.
6. **Least-privilege database accounts** — The web app's DB user should not own the schema, should not have `DROP`, and should not be `sa`/`root`. Limits blast radius.
7. **[[WAF]]** — Detects known payload patterns. Compensating control, not a primary fix. Bypassable via encoding tricks.
8. **Error handling** — Suppress verbose database errors from reaching the user. Log them server-side.
9. **Database activity monitoring (DAM)** and **runtime application self-protection ([[RASP]])** — detect anomalous queries in production.

> **CompTIA exam trap:** If a question asks for the **best** prevention against SQLi, the answer is almost always **parameterized queries / prepared statements** — *not* WAF, *not* input validation alone, *not* "encrypt the database." Encryption protects data at rest from disk theft; it does nothing against an injected `SELECT`.

### Why "just sanitize input" isn't enough

- Allow-listing requires knowing every legal character. Real-world fields like names (`O'Brien`) contain quotes legitimately.
- Deny-listing is whack-a-mole: encoded variants (`%27`, `0x27`, Unicode lookalikes), comment tricks (`/**/`), and case variation (`SeLeCt`) routinely defeat naive filters.
- A WAF tuned to block `UNION SELECT` can be evaded with `UNION/**/SELECT` or `UNI%4fN SELECT`.

The architectural fix — separating data from code via prepared statements — closes the entire class of bug. Filtering only narrows it.

### Database flavors and quirks

| DBMS | Comment syntax | String concat | Notable risk |
|------|---------------|---------------|--------------|
| MySQL/MariaDB | `--` (needs space), `#`, `/* */` | `CONCAT()` | `LOAD_FILE`, `INTO OUTFILE` for file access |
| MSSQL | `--`, `/* */` | `+` | `xp_cmdshell` for OS commands |
| PostgreSQL | `--`, `/* */` | `\|\|` | `COPY ... FROM PROGRAM` (superuser) |
| Oracle | `--`, `/* */` | `\|\|` | `UTL_HTTP` for OOB |
| SQLite | `--`, `/* */` | `\|\|` | File-based; often embedded in mobile apps |

### Risk scoring and business impact

A successful SQLi commonly yields:
- **Confidentiality breach** — full table dump (CIA: C)
- **Integrity breach** — data tampering, privilege escalation (CIA: I)
- **Availability impact** — `DROP TABLE`, resource exhaustion via heavy time-based queries (CIA: A)

Under [[GDPR]], a SQLi-driven PII disclosure triggers a **72-hour** breach notification clock. Under [[PCI DSS]] v4.0, public-facing web apps must be protected by either secure-coding review *plus* automated testing, **or** a continually-updated WAF (Requirement 6.4.2). SQLi is the textbook reason that requirement exists.

### Famous SQL injection breaches

| Year | Target | Impact |
|---|---|---|
| 2008 | **Heartland Payment Systems** | 134M card records via SQLi against payment processor |
| 2009 | **RockYou** | 32M plaintext passwords; SQLi yielded full user table |
| 2011 | **Sony Pictures** | LulzSec dumped customer database via SQLi |
| 2012 | **Yahoo Voices** | 450K credentials disclosed |
| 2017 | **Equifax** | Apache Struts CVE-2017-5638 (related class — input handling); 147M records |
| 2019+ | **MOVEit / Cl0p** | Multi-vector but SQLi was a frequent component in supply chain compromises |

These breaches are not historical curiosities — SQLi remains in the **OWASP Top 10** every iteration since 2003, and unparameterized legacy code keeps producing fresh CVEs every year.

### CompTIA exam traps

- **Best mitigation = parameterized queries.** Don't pick "input validation," "WAF," "encryption," or "stored procedures" if parameterized queries is an option.
- **Stored procedures are NOT inherently safe.** A stored procedure that builds dynamic SQL from input is equally vulnerable.
- **Encryption ≠ SQLi mitigation.** Encryption-at-rest does nothing against a query that the database executes legitimately.
- **WAF is compensating, not preventive.** It's the right answer only when the question explicitly asks for a control to deploy in front of legacy unfixable code.
- **Blind vs. classic SQLi.** Blind SQLi has no error output; attacker infers via boolean response or timing. Just as dangerous, harder to detect.

## Related concepts

[[Injection Attacks]] · [[Application Attacks]] · [[OWASP Top 10]] · [[Cross-site Scripting]] · [[Command Injection]] · [[LDAP Injection]] · [[Input Validation]] · [[Parameterized Queries]] · [[ORM]] · [[WAF]] · [[Database Security]] · [[Least Privilege]] · [[GDPR]] · [[PCI DSS]] · [[Application Security]] · [[Secure Coding]] · [[SAST]] · [[DAST]] · [[Error Handling]] · [[RASP]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
