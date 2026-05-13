# SQL — Structured Query Language (and the Injection That Eats Web Apps)

## What it is

In **Tears of the Kingdom**, Fuse lets you weld a Keese eyeball onto an arrow, and the arrow's behavior fundamentally changes — it now homes on enemies. The arrow's logic wasn't designed to track targets; it just executes whatever you attached to it. The game engine reads "arrow + eyeball" and obediently rewrites the projectile's flight path mid-air. **SQL injection is exactly that** — the attacker fuses their own payload onto a query string the application was going to send anyway, and the database obediently rewrites the logic to do what the attacker wanted instead of what the developer wrote.

**Plain English:** SQL is the language web apps use to talk to their databases — fetch this user, update that record, delete this row. SQL injection is when an attacker smuggles their own SQL commands inside a normal-looking input field (login box, search bar, URL parameter), and the database executes them because the app concatenated user input directly into the query.

**Technical:** Structured Query Language is the standard declarative language for relational database management systems (RDBMS) — MySQL, PostgreSQL, Microsoft SQL Server, Oracle, MariaDB. SQL injection (SQLi) is an **injection flaw** (OWASP Top 10 A03:2021) where untrusted input is interpreted as code by the SQL parser. It's the canonical example of failing to separate **control plane** (the query structure) from **data plane** (the values).

## Why it matters

SQLi is twenty-eight years old, sits in OWASP Top 10 every cycle, and still routinely takes down Fortune 500 web apps. Equifax-adjacent, TalkTalk, Heartland Payment Systems — all SQLi or SQLi-adjacent. The fix has been known since the late 1990s (parameterized queries). The vuln persists because developers keep building string concatenation into ORMs, stored procedures, and dynamic search filters.

For **CySA+ Objective 2.4**, you must recommend controls that mitigate injection flaws. The exam will give you a scenario — a web app, a vulnerable parameter, a suspicious log line — and ask which control stops it. Wrong answers will be plausible-but-incomplete (WAF only, input length limits only, blocklists). The right answer is almost always **parameterized queries / prepared statements**, layered with input validation and least-privilege DB accounts.

In the SOC, you're not writing the fix — you're detecting the exploit attempt in WAF logs, correlating it with database error spikes, and screaming at AppSec to push a patch.

## Key facts

### How SQLi actually works

The vulnerable pattern — every CySA+ exam scenario looks like this in some form:

```
query = "SELECT * FROM users WHERE username='" + user_input + "' AND password='" + pw_input + "'"
```

Attacker enters as username: `admin' --`

Resulting query:

```sql
SELECT * FROM users WHERE username='admin' --' AND password='whatever'
```

The `--` is a SQL comment. Everything after it is ignored. The app logs in as admin without checking the password.

*That's the whole trick. The data plane crossed into the control plane because string concatenation doesn't know the difference.*

### Types of SQL injection (CompTIA tests these)

| Type | Mechanism | Detection difficulty |
|---|---|---|
| **In-band (classic)** | Results returned in the same channel — UNION SELECT to dump tables, error messages leak schema | Easy — loud in logs |
| **Blind boolean-based** | App returns true/false based on injected condition; attacker infers data one bit at a time | Hard — looks like normal traffic, just lots of it |
| **Blind time-based** | Inject `SLEEP(5)` or `WAITFOR DELAY`; infer data from response latency | Medium — spot the consistent delays |
| **Out-of-band** | Trigger DNS or HTTP request from DB to attacker-controlled server (e.g., `xp_dirtree`, `UTL_HTTP`) | Hard — requires egress monitoring |
| **Second-order** | Injected payload is stored, executes later when another query reads it back | Very hard — temporal gap between injection and execution |

### What an attacker actually does with SQLi

Listed in roughly the order a real adversary escalates:

1. **Auth bypass** — `' OR '1'='1' --`
2. **Data exfiltration** — `UNION SELECT username, password_hash FROM users`
3. **Schema discovery** — query `information_schema.tables`, `information_schema.columns`
4. **Privilege escalation** — if DB account is over-privileged, modify user roles, drop tables
5. **[[Remote code execution]]** — `xp_cmdshell` on MSSQL, `sys_exec` on MySQL with UDFs, `COPY FROM PROGRAM` on PostgreSQL. Now the DB server is shelling out to the OS.
6. **Lateral movement** — pivot from DB server into internal network. This is when SQLi becomes a breach, not a vuln.

### Defenses — in order of effectiveness

**Parameterized queries / prepared statements** — the only real fix. The query structure is compiled first, then values are bound separately. The DB parser never confuses data for code.

```python
cursor.execute("SELECT * FROM users WHERE username=%s AND password=%s", (user, pw))
```

**Stored procedures** — help only if they themselves use parameterized inputs. A stored proc that internally does string concatenation is just as vulnerable.

**Input validation (allowlist)** — accept only known-good characters/formats. Blocklists ("strip apostrophes") always lose to encoding tricks (`%27`, double-encoding, Unicode normalization). *Allowlist wins, blocklist loses, every time.*

**Least-privilege DB accounts** — the web app's DB user should have SELECT/INSERT/UPDATE on its own tables. No DROP, no `xp_cmdshell`, no access to `mysql.user`. Limits blast radius when (not if) SQLi happens.

**[[Web Application Firewall]] (WAF)** — pattern-matches known SQLi signatures. Useful as a speed bump and a detection source. Easily bypassed with obfuscation (`/*!50000UNION*/`, hex encoding, case mixing). **Never the primary control.**

**Error suppression** — generic error pages. Don't leak `ORA-01756: quoted string not properly terminated` to the attacker.

**Database activity monitoring (DAM)** — detect anomalous queries (`UNION SELECT`, queries against `information_schema` from the web app account).

### Other injection flaws in the same family (Objective 2.4)

CompTIA bundles these under "injection flaws" — know the family:

- **[[Command injection]]** — same idea, but the sink is `os.system()` or `Runtime.exec()` instead of a SQL parser
- **[[LDAP injection]]** — attacker manipulates LDAP filter syntax
- **[[XPath injection]]** — for apps querying XML
- **[[NoSQL injection]]** — MongoDB and friends; uses operator injection (`{"$ne": null}`)
- **[[XSS|Cross-site scripting]]** — injection into the browser DOM instead of a backend interpreter
- **[[XXE]]** — XML External Entity injection
- **[[SSRF|Server-side request forgery]]** — injecting URLs the server will fetch

*Different sinks, same root cause: user input crossing the control/data boundary.*

### CompTIA exam traps

> **CompTIA exam trap:** "Which control prevents SQL injection?" — the right answer is **parameterized queries / prepared statements**, not WAF, not input validation alone, not stored procedures. WAF is detection + mitigation, not prevention. Input validation is defense-in-depth. Stored procedures only help if internally parameterized. CompTIA wants the root-cause fix.

> **CompTIA exam trap:** Don't confuse **SQLi** with **[[XSS|cross-site scripting]]**. SQLi targets the database (server-side). XSS targets other users' browsers (client-side). Both are injection. Both are OWASP Top 10. They are not the same vuln class on the exam.

> **CompTIA exam trap:** **Blind SQLi** doesn't return data in the response — the attacker infers it. If the scenario describes "slow database responses on certain inputs" or "the page renders differently based on truthy/falsy URL parameters," that's blind SQLi, not denial of service and not a performance issue.

> **CompTIA exam trap:** **Second-order injection** is sneaky. The payload is stored in the DB on one request, executes on a later, separate request. Code review of a single endpoint won't catch it. The exam may describe a registration form that takes the payload and a profile-view page that triggers it.

### Detection — what shows up in your tools

**WAF logs / reverse proxy:**
- `UNION SELECT`, `OR 1=1`, `' --`, `xp_cmdshell`, `WAITFOR DELAY`, `SLEEP(`
- High request volume to a single parameter from a single source (blind SQLi enumeration)
- URL-encoded variants: `%27`, `%20OR%201%3D1`

**Database / application logs:**
- SQL syntax errors (the attacker's probing stage)
- Queries against `information_schema`, `sys.tables`, `pg_catalog`
- Queries from the web app account that don't match the app's normal query patterns
- Spike in query latency on specific endpoints (time-based blind)

**Network telemetry:**
- DNS lookups from the DB server to weird domains (out-of-band SQLi exfil via `xp_dirtree` or `UTL_INADDR`)
- Outbound HTTP from the DB tier — DB servers should almost never initiate external traffic

**EDR on the DB host:**
- `sqlservr.exe` or `mysqld` spawning `cmd.exe`, `powershell.exe`, `/bin/sh`. *That's RCE-via-SQLi. Wake people up.*

## SOC reality

- The 3am alert is usually the **WAF firing on `UNION SELECT` from a single source IP** hammering one parameter. L1 acknowledges, pulls the source IP, checks if WAF blocked or just logged, and looks at the response codes. 200s with normal-sized bodies = probably blocked. 500s = the app errored, attacker is learning your schema. Variable response sizes = blind SQLi in progress.

- The L1's first move is **scope**: is this one IP, or distributed? One endpoint, or scanning across the app? Pull 24 hours of WAF logs filtered on SQLi signatures. If it's a scanner (sqlmap user-agent, fast sequential probes), it's noise — block the IP, file the ticket. If it's slow, targeted, and parameter-specific, escalate to L2 — someone's hand-crafting payloads.

- The CISO asks three things, in order: **"Did they get data out? What table? Are we in breach-notification territory?"** Your evidence is DB query logs (if you have them — many shops don't log SELECTs by default, which is a pre-incident failure you'll hear about in the post-mortem), egress NetFlow from the DB tier, and the WAF's response-body sizes.

- **Never tell leadership "the WAF blocked it" until you've verified the WAF actually blocked it.** WAFs run in detect-only mode more often than people admit. "Logged" ≠ "blocked." Check the action field, not just the signature match.

- Handoff: L1 triages and blocks the IP. L2 confirms exploitation vs. probing. **IR opens a case the moment there's evidence of successful data return or RCE.** AppSec gets paged to push a parameterized-query fix. Legal gets looped in if PII tables were queried. The DBA gets asked, politely, why the web app's DB account has `xp_cmdshell` enabled.

## Related concepts

[[OWASP Top 10]] · [[XSS]] · [[Command injection]] · [[XXE]] · [[SSRF]] · [[CSRF]] · [[Web Application Firewall]] · [[Input validation]] · [[Parameterized queries]] · [[Least privilege]] · [[Remote code execution]] · [[Privilege escalation]] · [[Database activity monitoring]] · [[Injection flaws]] · [[Insecure design]] · [[Security misconfiguration]]

*Source: VIRGIL knowledge base — 2026-05-11*