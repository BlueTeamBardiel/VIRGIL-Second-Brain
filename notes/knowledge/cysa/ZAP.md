# ZAP — Zed Attack Proxy

## What it is

In **Assassin's Creed**, before Altaïr puts a blade in anyone's neck he climbs the viewpoint, scouts the city, and then does the investigation legwork — pickpocket the courier, eavesdrop on the bench conversation, interrogate the informant beaten half to death in the alley. He doesn't kick the throne room door in. He intercepts the messages moving between targets, reads them, sometimes swaps them, and only *then* strikes. That intercept-and-rewrite work is exactly what ZAP does to a web application — sit between the browser and the server, read every request mid-flight, tamper with it, and watch what comes back.

**ZAP (Zed Attack Proxy)** is an open-source web application security scanner maintained under the OWASP umbrella (now stewarded by the Software Security Project). It operates as an **intercepting proxy** — your browser sends HTTP/HTTPS through ZAP, ZAP logs every request and response, and you can pause, modify, or replay any of them. On top of the proxy core sits a **passive scanner** (watches traffic and flags issues without sending anything new), an **active scanner** (deliberately injects attack payloads — XSS, SQLi, path traversal, command injection, etc.), a **spider/crawler** for content discovery, and a **fuzzer** for parameter abuse. Free, scriptable, CI/CD-friendly, and the standard "I need a web app scanner and I don't have a Burp license" answer.

## Why it matters

CompTIA Objective **CS0-003 2.2** explicitly lists ZAP in the web application scanner bucket alongside Burp Suite, Arachni, and Nikto. The exam wants you to recognize the tool by name, know which output category it produces, and pick it correctly when a scenario describes intercepting browser traffic, finding XSS in a form, or testing a REST API.

In the field, ZAP is the tool an analyst reaches for when a developer drops a new web app in staging and the SOC needs to know what's bleeding before it gets pushed to prod. It's also the tool every CTF player learns on, every appsec intern uses on day one, and every DevSecOps pipeline that can't afford Burp Pro ends up running in headless mode against pre-production builds.

*If you can only learn three web-attack tools for CySA+, make them Burp, ZAP, and Nikto — and know which one does what.*

## Key facts

### Core components

| Component | What it does | When you use it |
|---|---|---|
| **Intercepting proxy** | Sits between browser and server, captures all HTTP/S | Manual testing, request tampering |
| **Passive scan** | Analyzes traffic already flowing through, flags issues | Always on — zero risk to target |
| **Active scan** | Sends crafted attack payloads against discovered endpoints | Authorized testing only — this is noisy and can break things |
| **Spider / Ajax Spider** | Crawls site to discover URLs and inputs | Before active scan, to build the attack surface map |
| **Fuzzer** | Replays a request with payload lists swapped into chosen parameters | Auth bypass testing, IDOR hunting, parameter abuse |
| **HUD (Heads-Up Display)** | Overlay in the browser showing findings live | Demos, learning, interactive testing |
| **API / automation** | REST API + ZAP CLI for headless runs | CI/CD pipelines, scheduled scans |

### How an analyst actually drives it

1. **Configure browser** to proxy through `127.0.0.1:8080` (ZAP's default listener).
2. **Install ZAP's CA cert** in the browser so HTTPS interception works without TLS warnings on every request.
3. **Walk the application manually** while logged in — click everything, submit every form. ZAP records every request into the Sites tree and runs passive scan in the background.
4. **Run the spider** on the in-scope domain to find URLs you missed.
5. **Run active scan** against the in-scope tree. ZAP injects payloads at every parameter.
6. **Review alerts** — sorted by risk (High / Medium / Low / Informational) and confidence (High / Medium / Low / False Positive).
7. **Export report** — HTML for the dev team, JSON/XML for ticketing or pipeline gating.

### What ZAP finds well

- **Reflected and stored XSS** (cross-site scripting)
- **SQL injection** (error-based, boolean, time-based)
- **Path traversal** (`../../etc/passwd`)
- **Command injection**
- **Insecure cookie flags** (missing `Secure`, `HttpOnly`, `SameSite`)
- **Missing security headers** (`Content-Security-Policy`, `X-Frame-Options`, `Strict-Transport-Security`)
- **Information disclosure** (stack traces, server banners, comments in HTML)
- **CSRF token absence**
- **Open redirects**
- **Outdated JS libraries** (via the Retire.js add-on)

### What ZAP does NOT do well

- **Business logic flaws** — ZAP can't tell that "transfer $100 to account X" should require approval. No scanner can.
- **Auth flows that need MFA or complex session handling** without manual context configuration
- **Single-page applications** without the Ajax Spider configured correctly — vanilla spider misses dynamically loaded routes
- **Race conditions** — Burp's Turbo Intruder is the better tool here
- **Anything the spider can't reach** — if it's not in the Sites tree, it's not getting scanned

### ZAP vs Burp Suite — the comparison CompTIA may circle around

| Dimension | ZAP | Burp Suite |
|---|---|---|
| **License** | Open source (Apache 2.0) | Community free; Pro paid; Enterprise paid |
| **Active scanner in free tier** | Yes, full-featured | Community has none — Pro required |
| **Automation/CI** | Strong (REST API, Docker images, GitHub Actions) | Pro/Enterprise needed for headless |
| **Extensibility** | Marketplace add-ons, Python/JS/Groovy scripts | BApp Store, Java extensions |
| **Industry default for pentest contracts** | Less common | Burp Pro dominates |
| **DevSecOps pipeline default** | Very common | Burp Enterprise (paid) |

*ZAP wins on price and CI/CD. Burp wins on polish and the human-driven workflow. Most appsec people own both.*

### The other tools in Objective 2.2 (know the lane each plays in)

| Tool | Category | One-line role |
|---|---|---|
| **Nmap** | Network scanner | Port/service/OS discovery — the recon backbone |
| **Angry IP Scanner** | Network scanner | Lightweight host discovery, ping sweep |
| **Maltego** | OSINT/recon | Link analysis, entity graphing |
| **Recon-ng** | OSINT/recon | Modular OSINT framework, Metasploit-style UI |
| **Nessus** | Vulnerability scanner | Tenable's enterprise vuln scanner — CVE coverage king |
| **OpenVAS** | Vulnerability scanner | Open-source Nessus alternative (Greenbone) |
| **Nikto** | Web scanner | Fast web server misconfig and known-vuln check — noisy, signature-based |
| **Burp Suite** | Web scanner / proxy | Intercepting proxy + scanner, industry pentest default |
| **ZAP** | Web scanner / proxy | OWASP's intercepting proxy + scanner |
| **Arachni** | Web scanner | Ruby-based modular web scanner (development paused but still tested) |
| **Metasploit (MSF)** | Exploitation framework | Post-recon exploitation, payload delivery |
| **Immunity Debugger** | Debugger | Windows binary analysis, exploit dev |
| **GDB** | Debugger | GNU debugger — Linux/Unix binary analysis |
| **Scout Suite** | Cloud assessment | Multi-cloud config auditor (AWS/Azure/GCP) |
| **Prowler** | Cloud assessment | AWS-focused CIS benchmark + security best-practice auditor |
| **Pacu** | Cloud assessment | AWS exploitation framework — the offensive counterpart to Prowler |

### CompTIA exam traps

> **CompTIA exam trap:** ZAP and Nikto both scan web apps but they're not interchangeable. **Nikto** is signature-based, fast, and checks for known bad files, outdated server versions, and misconfigurations — no proxy, no manual interception. **ZAP** is a full intercepting proxy with active fuzzing. If the scenario says "intercept and modify browser requests," it's ZAP or Burp, never Nikto. If it says "quickly enumerate known web server vulnerabilities," it's Nikto.

> **CompTIA exam trap:** ZAP is a **web application scanner**, not a **network vulnerability scanner**. Nessus and OpenVAS scan hosts for CVEs at the OS/service level. ZAP scans web apps for OWASP-class bugs at the HTTP layer. CompTIA tests this distinction — don't pick ZAP when the scenario says "scan the subnet for missing patches."

> **CompTIA exam trap:** ZAP's **passive scan** is safe to run anywhere — it only analyzes traffic that's already flowing. **Active scan** sends attack payloads and can absolutely cause damage (deleted rows from blind SQLi, queue floods, account lockouts). Active scanning without written authorization is the kind of thing that ends careers and triggers CFAA conversations.

> **CompTIA exam trap:** "Open source" doesn't mean "Linux only." ZAP is cross-platform Java — Windows, macOS, Linux, Docker. CompTIA sometimes phrases this badly.

### Reading ZAP output

Alerts come with two attributes that matter:

- **Risk** — High / Medium / Low / Informational. This is severity if real.
- **Confidence** — High / Medium / Low / False Positive. This is how sure ZAP is.

A **High risk / Low confidence** alert is not a P1. It's a "go validate this manually before you wake the dev team." A **Medium risk / High confidence** missing `HttpOnly` cookie flag is a real finding you can ticket immediately.

*Every scanner lies in both directions. The analyst's job is to read both axes before escalating.*

Each alert also includes:
- **CWE ID** (e.g., CWE-79 for XSS) — map to your vuln tracker
- **WASC ID** — older taxonomy, still referenced
- **OWASP Top 10 category** — for executive reporting
- **Request/response evidence** — the exact payload that fired the rule

## SOC reality

- ZAP findings rarely come through the SIEM — they come through Jira, GitLab pipeline failures, or a Slack channel from the appsec team. The SOC's role is usually downstream: if a ZAP-found vuln gets exploited in prod, IR pulls the original scan report to prove it was known and ask why it wasn't patched.
- When the appsec team runs ZAP against staging, the WAF and SOC dashboards light up with attack traffic. If you didn't get the heads-up, you'll think you're under attack. **Always check the change calendar before declaring an incident** — half of "the perimeter is on fire" tickets at 2pm Wednesday are the pentest team forgetting to email.
- DevSecOps pipelines run ZAP in **headless baseline mode** against every PR. Build fails = developer fixes before merge. The SOC inherits whatever the pipeline missed.
- The CISO question is never "did ZAP find anything?" — it's *"of the High-risk findings open more than 30 days, what's the business reason none of them are patched yet?"* That answer is your remediation inhibitor conversation: [[MOU]], [[SLA]], legacy systems, business process interruption.
- L1 doesn't run ZAP. L2/appsec does. But L1 should recognize the User-Agent string `ZAP/2.x` in proxy logs and not panic — that's authorized testing, not an attacker. (And if you don't have a change ticket for it, *then* panic.)

## Related concepts

[[Burp Suite]] · [[Nikto]] · [[Arachni]] · [[OWASP Top 10]] · [[Cross-Site Scripting (XSS)]] · [[SQL Injection]] · [[CSRF]] · [[Nessus]] · [[OpenVAS]] · [[Nmap]] · [[Metasploit Framework (MSF)]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]] · [[Vulnerability Scanning]] · [[CVSS]] · [[Inhibitors to Remediation]] · [[DevSecOps]] · [[Web Application Firewall (WAF)]]

*Source: VIRGIL knowledge base — 2026-05-11*