# Injection Flaws

## What it is

In **The Witcher 3**, Geralt walks into Crookback Bog and meets the Crones. They offer hospitality. He accepts. He eats their stew. The stew is children. The hospitality was the delivery vector — they handed him something that looked like food, and by the time it was down his throat, he'd already participated in something he can't take back. The Crones didn't break into his stomach. He invited them in by trusting what they served.

That's injection. The application offers a query, an input box, a parameter — the equivalent of a meal — and the attacker fills it with something that looks like data but executes like code. The application swallows it, the interpreter parses it, and by the time anyone notices, the database has already coughed up the password hashes or the OS has already spawned a shell.

**Plain English:** the app trusts user input too much. It concatenates that input directly into a command (SQL, LDAP, OS, XPath, whatever) and the interpreter on the other side can't tell the data from the code. Attacker controls the code path. Game over.

**Technical (CS0-003 framing):** Injection flaws occur when untrusted data is sent to an interpreter as part of a command or query, allowing the attacker to alter the interpreter's intended logic. **OWASP A03:2021** — third on the list because it never stops working. Detected by **web application scanners** (Burp Suite, OWASP ZAP, Arachni, Nikto), exploited by frameworks like **Metasploit (MSF)**, and validated manually by analysts who don't trust their tools.

## Why it matters

Injection is a top-three web vulnerability across every version of the OWASP Top 10 since 2010. It rotates between #1 and #3. It does not go away because the root cause is *humans writing string concatenation* and humans keep doing that.

For the CySA+ analyst this is **Objective 2.2** territory — you're reading scanner output and deciding which findings are real, which are exploitable, and which are noise. Burp Suite flags a "possible SQL injection" on a parameter. Is it real? Is it blind? Is the database account `sa` or a low-priv app user? Can the attacker pivot from this single parameter to the rest of the network? That triage is your job.

Career relevance: SQLi alone has caused breaches at Equifax-scale targets and routinely shows up in ransomware initial access chains. If you can't read a scanner report and tell the change board *"this CVSS 9.8 is real, it's exploitable from the internet, and we have 48 hours,"* you can't do the job.

## Key facts

### The injection family

| Type | Interpreter targeted | Example payload | Common scanner |
|------|---------------------|-----------------|----------------|
| **SQL injection (SQLi)** | Database engine | `' OR 1=1--` | Burp, ZAP, sqlmap, Arachni |
| **OS command injection** | Shell (bash, cmd) | `; cat /etc/passwd` | Burp, Nikto, ZAP |
| **LDAP injection** | Directory service | `*)(uid=*))(\|(uid=*` | Burp, ZAP |
| **XML / XXE** | XML parser | External entity reference to `file:///etc/passwd` | Burp, ZAP |
| **XPath injection** | XML query engine | `' or '1'='1` | Burp, ZAP |
| **NoSQL injection** | MongoDB, etc. | `{"$gt": ""}` | Burp, NoSQLMap |
| **Server-side template injection (SSTI)** | Template engine (Jinja, Twig) | `{{7*7}}` returning `49` | Burp, tplmap |

All same shape: data crosses into a context where it's parsed as instructions.

### SQL injection — the canonical case

**Three flavors you must know cold for the exam:**

- **In-band (classic)** — attacker injects, app returns data or errors in the HTTP response. Easy to detect. Error messages like `Microsoft OLE DB Provider for SQL Server error '80040e14'` are dead giveaways in scanner output.
- **Blind (inferential)** — app suppresses errors and doesn't return query results, but the attacker infers data by watching app behavior. Two subtypes:
  - **Boolean-based blind** — `AND 1=1` returns the normal page, `AND 1=2` returns an error page or different content. Bit-by-bit extraction.
  - **Time-based blind** — `'; WAITFOR DELAY '0:0:10'--` or `SLEEP(10)`. Scanner sees a 10-second response delay and flags it. This is the one CompTIA loves to put in scanner-output questions.
- **Out-of-band** — app exfils data via DNS or HTTP callback to attacker-controlled infrastructure. Used when in-band and blind both fail. Hardest to detect from the WAF side because the channel isn't the original request/response pair.

### What scanner output actually looks like

Burp Suite Scanner flags an issue. The report says:

> **SQL injection** — Severity: High — Confidence: Firm
> Parameter `productId` appears vulnerable to time-based blind SQL injection. A payload of `1';WAITFOR DELAY '0:0:10'--` caused a response delay of 10.3 seconds vs baseline 0.2 seconds.

Your job as the analyst:
1. **Confirm it's not a false positive** — re-run manually, check timing variance, rule out network jitter
2. **Determine scope** — what database, what privileges, what tables are reachable
3. **Identify data at risk** — PII, payment data, credentials, session tokens
4. **Hand to the right team** — this is a *developer* fix, not a sysadmin fix. Patching the OS doesn't help.

### Tools you must recognize (Objective 2.2)

| Tool | Category | What it does |
|------|----------|--------------|
| **Burp Suite** | Web app scanner / proxy | Intercepts HTTP, fuzzes parameters, scans for injection, XSS, etc. The industry standard. |
| **OWASP ZAP** | Web app scanner | Open-source Burp. Same job, free. |
| **Arachni** | Web app scanner | Automated crawl + injection testing |
| **Nikto** | Web server scanner | Looks for known-vuln files, misconfigs, dangerous CGI |
| **sqlmap** | SQLi exploitation | Automates discovery and extraction once you know a parameter is injectable |
| **Metasploit (MSF)** | Exploit framework | Has injection modules, but more useful for post-exploitation pivoting |
| **Nmap** | Network scanner | Service discovery — tells you *where* the web app lives before you scan it |
| **Nessus / OpenVAS** | Vuln scanners | Network-layer scanners. Will flag known-vuln web stacks but won't deeply test custom app logic |
| **Recon-ng / Maltego** | OSINT / recon | Pre-engagement intel, not direct injection testing |
| **Immunity Debugger / GDB** | Binary debuggers | For native code injection (buffer overflows, format string bugs), not web injection |
| **Scout Suite / Prowler / Pacu** | Cloud assessment | Audit AWS/Azure/GCP configs — finds the S3 bucket the injectable app dumps to |

**The trap:** scanners find *candidate* injection points. They don't confirm exploitability. A "possible SQLi" with low confidence might be the database choking on a malformed input, not a real injection.

### CompTIA exam traps

> **CompTIA exam trap:** Time-based blind SQLi vs slow application. CompTIA shows you scanner output with a 10-second delay and asks what it indicates. The answer is **time-based blind SQL injection**, not "slow database" or "network latency." The keyword is the *crafted payload causing the delay* — baseline requests are fast, only the injected payload is slow.

> **CompTIA exam trap:** Injection is a *developer* fix, not a *patch management* fix. If the question asks "what is the appropriate remediation," answers like "patch the operating system" or "update the web server" are wrong. The fix is **parameterized queries / prepared statements** and **input validation** in application code.

> **CompTIA exam trap:** WAF is mitigation, not remediation. A WAF blocking SQLi payloads is a compensating control. The vulnerability is still in the code. CompTIA distinguishes between *compensating controls* (reduce risk) and *remediation* (eliminate the flaw). Don't pick WAF as the "best" fix when "parameterized queries" is on the answer list.

> **CompTIA exam trap:** Stored procedures are not automatically safe. A stored procedure that uses `EXEC` with concatenated input is still injectable. The safe pattern is *parameterized* queries — bound variables — regardless of whether the call is to a stored proc or inline SQL.

### Defenses (in the order an analyst recommends them)

1. **Parameterized queries / prepared statements** — bind variables. The interpreter never confuses data with code. This is the only real fix.
2. **Input validation (allow-list, not deny-list)** — reject anything that isn't a known-good shape. Deny-lists get bypassed; allow-lists hold.
3. **Least-privilege database accounts** — the app user should not be `sa` or `root`. If injection happens, blast radius is limited.
4. **Stored procedures (correctly written)** — defense in depth, not a primary fix.
5. **WAF** — compensating control while developers fix the code. Buys you weeks, not forever.
6. **Error handling** — never return raw database errors to the client. Generic 500s only.
7. **ORM frameworks** — modern frameworks (Hibernate, Entity Framework, Django ORM) parameterize by default *if used correctly*. Raw query escape hatches re-introduce the bug.

## SOC reality

- **The alert at 3am:** WAF logs spike with `UNION SELECT`, `' OR '1'='1`, and `sleep(` patterns against `/api/v2/orders?id=`. L1 sees 4,000 blocked requests from one IP in 10 minutes. Question one: *is the WAF actually blocking, or is this evasion bypassing inspection?*
- **L1's first move:** verify the WAF is in *blocking* mode not *monitoring*, confirm the source IP isn't internal, pull the application logs for that endpoint to see if any payloads got through with HTTP 200 responses. Then escalate to L2 with the timeline.
- **What the IR lead asks:** "Did anything return 200 with a non-zero response body? Pull all successful requests to that parameter for the last 24 hours. Is the DB account `sa` or a scoped user? Has anyone observed `xp_cmdshell` or shell spawns from the SQL service account?"
- **Never promise leadership** "we blocked it" when all you have is *WAF blocked the obvious payloads*. Blind SQLi over hours can slip through with payloads that don't match WAF signatures. *A WAF block log is not proof the database wasn't touched — it's proof the noisy attempts were noisy.*
- **The handoff:** L2 confirms scope → IR engages the application team (this is a code fix, sysadmins can't help) → if data egress is suspected, legal gets a heads-up because breach notification clocks start ticking on *reasonable belief of compromise*, not on confirmation.

*The hardest part of triaging injection in production isn't finding the payload in the logs — it's proving the negative. Proving nothing got out is almost impossible once you know something tried.*

## Related concepts

[[OWASP Top 10]] · [[SQL Injection]] · [[Cross-Site Scripting (XSS)]] · [[Command Injection]] · [[LDAP Injection]] · [[XML External Entity (XXE)]] · [[Burp Suite]] · [[OWASP ZAP]] · [[Web Application Firewall (WAF)]] · [[Parameterized Queries]] · [[Input Validation]] · [[CVSS]] · [[Vulnerability Scanning]] · [[Nessus]] · [[OpenVAS]] · [[Metasploit]] · [[Nmap]] · [[Nikto]] · [[Arachni]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]]

*Source: VIRGIL knowledge base — 2026-05-11*