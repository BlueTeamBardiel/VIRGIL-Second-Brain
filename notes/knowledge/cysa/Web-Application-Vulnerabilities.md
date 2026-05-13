# Web Application Vulnerabilities

## What it is

In **StarCraft**, a Terran player walls off the ramp with supply depots and a barracks, parks a tank behind it, and calls the base secure. Then a Zerg player drops two overlords full of zerglings *inside* the mineral line — straight over the wall, no ramp involved. The wall was perfect. The wall was also irrelevant, because the attacker came in through a vector the defender forgot existed.

That's a web application vulnerability. The perimeter firewall is up. The IDS is tuned. Port 22 is locked down to jump hosts. And then someone sends `' OR 1=1 --` into the login form on port 443 and walks straight into the database, because **the application itself is the new perimeter**, and you let TCP/443 through on purpose.

**Plain English:** A web app vuln is a flaw in the code, configuration, or logic of a web-facing application that lets an attacker do something the developer didn't intend — read data they shouldn't, execute code on the server, hijack another user's session, or pivot to internal systems.

**Technical (CS0-003):** Web application vulnerabilities are weaknesses in the presentation layer, application logic, data layer, authentication system, session management, or API surface of a web application that can be exploited to violate confidentiality, integrity, or availability. They're typically discovered using **web application scanners** (Burp Suite, OWASP ZAP, Nikto, Arachni) and validated through manual testing or exploitation frameworks (Metasploit).

## Why it matters

Web apps are where the perimeter went to die. Every modern org runs SaaS portals, customer login pages, partner APIs, internal admin panels — all listening on 443, all reachable from the internet, all running code written by someone under deadline pressure. The firewall doesn't help. The EDR on the web server might catch post-exploit behavior, but it won't stop the SQL injection that already exfiltrated the customer table.

**Career relevance:** Half the breaches you'll read about in the news are web app issues — Equifax (Apache Struts deserialization), Capital One (SSRF into AWS metadata), MOVEit (SQLi). The CySA+ analyst is expected to read scanner output, validate findings, prioritize, and explain to the dev team why "low severity" doesn't mean "ignore."

**Exam relevance (Objective 2.2):** CompTIA wants you to recognize tool output — Burp, ZAP, Nikto, Nessus web plugins — and know which tool fits which job. Expect questions where a scan output is shown and you pick the vulnerability class, the tool that found it, or the next analyst action.

## Key facts

### The web app stack — know where the bug lives

| Layer | What runs there | Common vuln classes |
|---|---|---|
| **Frontend (browser)** | HTML, JavaScript, CSS | [[XSS]], CSRF, clickjacking, DOM-based injection |
| **Transport** | TLS over 443 | Weak ciphers, expired certs, downgrade attacks |
| **Backend (app server)** | PHP, Node, Python, Java, .NET | [[SQL injection]], command injection, SSRF, XXE, [[insecure deserialization]] |
| **Data layer** | MySQL, Postgres, MongoDB, Redis | SQLi, NoSQL injection, exposed admin interfaces |
| **AuthN/AuthZ** | Sessions, JWTs, OAuth, SAML | [[Broken authentication]], session fixation, IDOR, privilege escalation |
| **APIs** | REST, GraphQL, SOAP | BOLA, mass assignment, rate-limit bypass, excessive data exposure |

When a scanner reports a finding, the first question is always: **which layer**. That tells you who fixes it and how fast.

### The OWASP Top 10 classes that show up on the exam

- **Injection** — SQLi, command injection, LDAP injection. Untrusted input concatenated into a query or shell command. Defense: parameterized queries, input validation, output encoding.
- **Broken access control** — IDOR (insecure direct object reference): `/api/invoice/1001` works, change to `/api/invoice/1002`, you see someone else's invoice. Defense: server-side authorization checks on every request.
- **Cryptographic failures** — plaintext storage, weak hashing (MD5/SHA1 for passwords), expired or self-signed TLS. Defense: bcrypt/argon2 for passwords, TLS 1.2+, HSTS.
- **XXE (XML External Entity)** — XML parser fetches external entities, attacker reads `/etc/passwd` or pivots to internal services. Defense: disable external entity processing.
- **SSRF (Server-Side Request Forgery)** — attacker makes the server fetch URLs on its behalf. Critical in cloud — SSRF into `169.254.169.254` (the AWS metadata endpoint) is how Capital One happened. Defense: egress filtering, metadata service v2 (IMDSv2), URL allowlists.
- **Insecure deserialization** — app deserializes attacker-controlled blobs, attacker gets RCE. Apache Struts, Java RMI, .NET BinaryFormatter — all classics.
- **Security misconfiguration** — directory listing on, default creds on admin panel, verbose error messages leaking stack traces. The boring stuff that wins engagements.
- **Vulnerable components** — outdated libraries with known CVEs (Log4Shell, Spring4Shell). Defense: SCA tools, SBOM, patch management.

### The tooling — what CompTIA expects you to know

**Web application scanners — the meat of Objective 2.2:**

| Tool | Type | What it does | When you'd use it |
|---|---|---|---|
| **Burp Suite** | Intercepting proxy + scanner | Sit between browser and app, modify requests in flight, replay, fuzz, scan | Manual web app pentest, validating scanner findings |
| **OWASP ZAP** | Intercepting proxy + scanner (free) | Burp's open-source cousin. Active and passive scanning | Same as Burp when you don't have a Burp Pro license |
| **Nikto** | Web server scanner | Quick check for misconfigs, default files, outdated server versions, common vulns | Recon, first pass on an unknown web server |
| **Arachni** | Web app scanner | Automated scanning with strong JS/SPA support | Automated DAST against modern single-page apps |
| **Nessus** | General vuln scanner (with web plugins) | Network + web vulns, mostly known-CVE focused | Enterprise vuln management — broad coverage, less depth on web logic |
| **OpenVAS** | General vuln scanner (free) | Nessus alternative | Same as Nessus, OSS shop |
| **Metasploit (MSF)** | Exploitation framework | Validate findings by actually exploiting them | Post-scan: prove the vuln is real |

**Adjacent tools from the objective list:**

- **Nmap** — port discovery first. You can't scan a web app you haven't found. `nmap -sV -p 80,443,8080,8443` plus `--script http-*` for low-hanging web fruit.
- **Recon-ng / Maltego** — OSINT and surface mapping. Find every subdomain, every cert SAN, every forgotten staging environment. Shadow IT is where web vulns live.
- **Angry IP Scanner** — quick host discovery on internal segments. Find the web apps nobody told you about.
- **Cloud-specific:** **Scout Suite** (multi-cloud config audit), **Prowler** (AWS CIS benchmarks), **Pacu** (AWS exploitation — the cloud Metasploit). Web apps in cloud means SSRF → IMDS → IAM is a real attack path.
- **Debuggers — Immunity, GDB** — these are exploit-dev tools, not scanners. They show up when you're reverse-engineering a binary backend or writing a custom exploit. CySA+ wants you to recognize the name, not write shellcode.

### Reading scanner output — the actual job

A Burp or ZAP finding will give you:

- **Severity** (informational / low / medium / high / critical) — vendor's opinion, not gospel
- **Vulnerability class** (e.g., "Reflected XSS")
- **Affected endpoint** (URL + parameter)
- **Evidence** (the payload that worked, the response that confirmed it)
- **Confidence** (firm / tentative — *tentative findings are where false positives live*)
- **Remediation guidance**

Your job: **validate, prioritize, route.** Don't ship a raw scanner report to the dev team. Half the findings are noise. The other half need context the scanner doesn't have — is this endpoint internet-facing? Is the affected parameter actually user-controllable? Does the WAF block this payload class already?

### CompTIA exam traps

> **CompTIA exam trap — Nikto vs Nessus vs Burp.** Nikto is a *web server* scanner — fast, surface-level, looks for known bad files and misconfigs. Nessus is a *general* vuln scanner that happens to do web. Burp/ZAP are *web application* scanners + intercepting proxies for manual testing. If the question says "fast initial check of a web server for common misconfigurations," it's Nikto. If it says "intercept and modify requests to test authentication logic," it's Burp/ZAP.

> **CompTIA exam trap — ZAP vs Burp.** Both are intercepting proxies. ZAP is OWASP, free, open-source. Burp has a free community edition but the scanner is in Pro. If the scenario emphasizes budget, OSS, or community-driven, it's ZAP.

> **CompTIA exam trap — Pacu vs Prowler vs Scout Suite.** Prowler and Scout Suite are *assessment* (audit, find misconfigs). Pacu is *exploitation* (post-compromise AWS). If the question says "test what an attacker could do after compromising an IAM key," it's Pacu. If it says "audit the account for CIS benchmark compliance," it's Prowler/Scout Suite.

> **CompTIA exam trap — Metasploit isn't a scanner.** It's an exploitation framework. It has auxiliary scanner modules, but if the question asks what tool you'd use to *find* vulns, MSF is wrong. If it asks what you'd use to *validate* or *exploit*, MSF is right.

> **CompTIA exam trap — debuggers are exploit-dev tools.** Immunity Debugger and GDB don't scan web apps. They're for reverse engineering binaries or developing exploits. If the answer choice puts a debugger in a web-app-scanning scenario, it's the wrong answer.

## SOC reality

- **The alert at 3am** rarely says "SQL injection." It says "WAF blocked 8,400 requests from 185.220.x.x in 4 minutes, payloads contain `UNION SELECT`." That's a probe, not a breach — yet. Your job: confirm WAF is actually blocking (not just logging), pull the target endpoints, check whether any requests *didn't* get blocked.

- **The CISO's first three questions** when a web app finding lands on a critical asset: *"Is it internet-facing? Is it authenticated or pre-auth? Has it been exploited yet?"* Pre-auth + internet-facing + RCE = drop everything. Authenticated + internal + info disclosure = ticket, sprint, done.

- **Never tell the dev team "the scanner says critical."** Tell them: "this endpoint accepts user input, reflects it without encoding, here's the payload that pops an alert, here's the parameterized fix." Scanner output is evidence, not a translation layer.

- **The handoff:** L1 triages WAF and scanner alerts, dedupes, drops noise. L2 validates with Burp/ZAP, confirms exploitability, opens the ticket with proof. AppSec or the dev team fixes. IR gets called only when validation shows active exploitation — at which point it's no longer a vuln-management problem, it's an incident.

- **Never promise leadership "the WAF will catch it."** WAFs catch *known patterns*. Custom logic flaws — IDOR, broken auth, business logic abuse — sail right through. *The WAF is a filter, not a wall, and an attacker who reads your error messages will tune their payload until something gets through.*

## Related concepts

[[SQL Injection]] · [[XSS]] · [[CSRF]] · [[SSRF]] · [[Insecure Deserialization]] · [[OWASP Top 10]] · [[Burp Suite]] · [[OWASP ZAP]] · [[Nikto]] · [[Nessus]] · [[Metasploit]] · [[Nmap]] · [[Web Application Firewall]] · [[CVSS]] · [[Vulnerability Prioritization]] · [[Cloud Infrastructure Assessment]] · [[IMDSv2]] · [[Broken Access Control]] · [[Input Validation]]

*Source: VIRGIL knowledge base — 2026-05-11*