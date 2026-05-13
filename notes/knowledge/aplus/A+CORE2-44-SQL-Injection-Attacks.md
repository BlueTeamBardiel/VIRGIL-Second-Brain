# SQL Injection Attacks

## What it is

A login form. Username field. You type `admin' --` and you're in. No password. No exploit kit. No zero-day. Just the application taking your input, gluing it directly into a database query, and politely doing whatever you told it to.

In plain English: SQL injection (SQLi) is when an attacker types database commands into a place that was supposed to accept normal user input — a search box, a login field, a URL parameter — and the application runs those commands against its database because the developer never bothered to separate "data" from "instructions."

Technically: SQL injection exploits applications that build SQL queries by concatenating user-supplied strings directly into query text. Instead of treating input as data passed to a prepared statement, the application treats it as part of the query syntax. The attacker breaks out of the expected data context with a quote character, a comment marker, or a semicolon, then appends arbitrary SQL: `UNION SELECT`, `DROP TABLE`, `OR 1=1`, whatever the database engine will execute under the application's credentials.

The database is the warehouse — every customer record, password hash, credit card, medical chart. The application is supposed to be the gatekeeper deciding who gets what. SQLi happens when the gatekeeper hands the warehouse keys to anyone who knows how to ask in SQL.

## Why it matters

SQL injection has been on the OWASP Top 10 since the list existed. It's been a known, solved problem for over twenty years. It still ranks in the top three breach causes every year because developers keep writing string-concatenated queries and shipping them to production.

On the exam, CompTIA Objective 220-1202 2.5 lists "Structured Query Language" (the bullet got truncated — it means SQL injection) alongside XSS, brute force, and on-path attacks. You need to recognize the attack by symptom, name the mitigation, and not confuse it with cross-site scripting.

In the field: as A+ helpdesk, you will not be patching the vulnerable application yourself — that's a developer or appsec job. But you will be the first person to see the symptoms. Weird database errors in a web app. A vendor portal returning other customers' data. A line-of-business app that suddenly logs everyone in as "admin" after a user typed something strange. Your job is recognizing the pattern, escalating to security fast, and not touching the evidence.

## At home, at work

**Beat 1 — Technical depth.** SQLi comes in flavors. **In-band** (classic): the attacker sees the result directly — error messages, returned data, login bypass. **Blind**: the app doesn't return data, but its behavior changes based on the injected query (boolean blind: page renders differently; time-based blind: `WAITFOR DELAY '0:0:5'` makes the response slow). **Out-of-band**: the database itself reaches out to an attacker-controlled server via DNS or HTTP. The two classic payload patterns: `' OR '1'='1` to bypass authentication (turns `WHERE user='x' AND pass='y'` into something always true), and `UNION SELECT` to graft extra columns onto an existing query and dump tables like `users` or `credit_cards`. Modern attacks chain SQLi with privilege escalation: get into the database, find stored credentials, pivot to the OS via `xp_cmdshell` on misconfigured SQL Server.

**Beat 2 — Feynman example via your homelab.** You spin up a vulnerable web app in a VM — DVWA, Juice Shop, something deliberately broken — to learn pentesting.

**The login page:** Username `admin' --`, password anything. You're logged in as admin. The `--` comments out the password check. *The application trusted your input as code.*

**The search box:** You type `' UNION SELECT username, password FROM users --` and the product search returns the entire user table where the product names should be. *Once you can inject UNION, every table in the database is readable.*

**The blind one:** No errors, no visible output. You type `' AND SLEEP(5) --` and the page hangs for five seconds. Confirmed injectable. Now you write a script that asks 1000 yes/no questions — "does the admin password start with 'a'? with 'b'?" — and reads the answers from response timing. *Slow, automated, devastating. Sqlmap does this in minutes.*

**The kicker:** Every one of these attacks is stopped by one fix — parameterized queries. The developer writes `SELECT * FROM users WHERE name = ?` and passes the input as a parameter. The database engine treats it as data, not code. No amount of quotes or semicolons in the input changes the query structure. *The fix has existed since 2001. The breaches keep happening because legacy code keeps shipping.*

**Beat 3 — Bridge to the enterprise.** Same question — "does this application trust user input as code?" — different scale of consequences. At home you popped a deliberately-vulnerable VM and learned. At a small business, a SQLi in the customer portal leaks the customer table — names, emails, hashed passwords, maybe payment tokens. At a hospital, it's PHI and a HIPAA breach notification. At a defense contractor, it's a nation-state on a quiet Tuesday. The vulnerability is identical. The blast radius isn't.

**Beat 4 — The point.** SQLi is the textbook example of why "validate input" is a non-negotiable security principle, and why the helpdesk tech needs to recognize injection symptoms even when fixing the code isn't their job. Get the pattern into your bones: anywhere user input touches a backend system, ask whether it's being treated as data or as code. You'll ask it for the rest of your career — about SQL, about shell commands, about LDAP queries, about every interpreter that exists.

## Key facts

### What SQLi looks like

| Payload pattern | What it does | Symptom |
|---|---|---|
| `' OR '1'='1' --` | Auth bypass — makes WHERE always true | Login succeeds with no password |
| `'; DROP TABLE users; --` | Stacked query — runs a second statement | Tables disappear |
| `' UNION SELECT ... --` | Appends attacker's SELECT to existing query | App returns data from other tables |
| `' AND SLEEP(5) --` | Time-based blind — confirms injectability | Response delayed by N seconds |
| `' AND 1=CONVERT(int,@@version) --` | Error-based — leaks DB info via error message | Verbose SQL error reveals DB version |

### Mitigations (in order of effectiveness)

1. **Parameterized queries / prepared statements** — the actual fix. Input is bound as data, never parsed as SQL.
2. **Stored procedures** — when written correctly, parameters can't be interpreted as code. When written with dynamic SQL inside, just as vulnerable.
3. **Input validation / allowlisting** — reject anything that isn't expected characters. Defense in depth, not a substitute.
4. **Least privilege database accounts** — the app's DB user shouldn't have `DROP` or `xp_cmdshell`. Limits damage, doesn't prevent the attack.
5. **Web Application Firewall (WAF)** — pattern-matches known SQLi payloads. Bypassable by skilled attackers. Buys time.
6. **Error suppression** — don't return raw database errors to the browser. Reduces information leakage.

### CompTIA exam traps

> **CompTIA exam trap:** SQLi vs XSS. Both involve injected input. SQLi targets the **database** through the application server. XSS targets **other users' browsers** through injected JavaScript. If the attack reads database tables or bypasses login, it's SQLi. If the attack runs script in someone else's browser to steal their session cookie, it's XSS.

> **CompTIA exam trap:** The correct primary mitigation is **parameterized queries** (also called prepared statements). Not "input validation," not "a WAF," not "encryption." Input validation and WAFs are defense in depth. Encryption protects data at rest — it does nothing against an attacker who's asking the application to decrypt and return it.

> **CompTIA exam trap:** SQLi is an **application vulnerability**, not a network attack. Patching the database engine doesn't fix it. Firewall rules don't fix it. The fix lives in the application code.

## Helpdesk reality

- **"The vendor portal is showing me someone else's invoices."** Could be a session bug. Could be SQLi where someone manipulated a URL parameter and broke out of the WHERE clause. Screenshot everything, escalate to security and the vendor immediately. Do not "test it" by typing payloads — you don't have authorization, and you'll contaminate the forensics.
- **"I got a weird error when I searched — it mentioned 'syntax near'."** That's a SQL error bleeding through to the UI. The app isn't sanitizing input and isn't suppressing errors. Ticket it to the application owner as a security finding, not a cosmetic bug.
- **"Can we just add a firewall rule to stop SQL injection?"** No. A network firewall doesn't inspect HTTP request bodies. A WAF helps but isn't a fix. The fix is in the code.
- **Never paste a suspicious URL or payload into a company-approved AI tool to "ask what it does"** if it contains real customer data, session tokens, or internal hostnames. Sanitize first, or describe it in words. CompTIA 220-1202 tests this under Privacy and Policies.
- **You are not the appsec team.** Your job is recognize, document, escalate, preserve evidence. Don't try to exploit the bug to "prove it" — that's outside your authorization and gets people fired.

## Related concepts

[[Cross-Site Scripting (XSS)]] · [[On-Path Attacks]] · [[Brute-Force Attacks]] · [[Zero-Day Attacks]] · [[Unpatched Systems]] · [[Principle of Least Privilege]] · [[Web Application Firewalls]] · [[Database Security]]

*Source: VIRGIL knowledge base — 2026-05-11*