# Interception Proxies

## What it is

In **Red Dead Redemption 2**, when you rob the Valentine bank you don't just walk in and ask for the safe. You case the building first — watch the teller, count the guards, time the patrols. Then Arthur steps inside, but the real work happens at the counter: you slide a note across, you tell the clerk what to do, you control every word that passes between you and the vault. If the clerk hesitates, you escalate. If the safe needs a key, you take it off a body. You sit *in the middle* of the transaction and bend it to your will.

That's exactly what an interception proxy does. It sits between the browser and the web application and rewrites the conversation in flight.

**Plain English:** a tool that catches every HTTP/HTTPS request your browser sends, lets you read it, change it, replay it, or break it on purpose — then forwards (or doesn't) the modified version to the server. Same on the way back.

**Technical (CS0-003):** an **interception proxy** is a man-in-the-middle testing tool that terminates the client TLS connection using its own CA certificate, decrypts the traffic, exposes the request/response pair to the tester, and re-encrypts it to the server. It's the central instrument of **dynamic application security testing (DAST)** and the bridge between automated [[vulnerability scanning]] and manual [[penetration testing]]. The two you must know for CS0-003 are **OWASP ZAP** (open source) and **Burp Suite** (commercial, with a free Community edition).

This sits in Objective 2.1 under **dynamic** analysis and **fuzzing** — proxies are how you actually deliver fuzzed input to a running application and watch what comes back.

## Why it matters

A [[Nessus]] scan tells you a parameter *might* be vulnerable to SQL injection. An interception proxy is where you *prove it* — by catching the request, mutating the payload, and watching the database error tumble back through the response. Scanners produce findings. Proxies produce evidence.

For the analyst, this matters in three ways:

- **Triage of scan output.** When the scanner flags a "possible XSS" and the dev team pushes back with "false positive," you don't argue — you intercept the request, drop the payload in, and screenshot the alert box firing.
- **Bug bounty and red team work.** Every public methodology — OWASP WSTG, PTES — assumes you're driving Burp or ZAP. If you can't run a proxy, you can't do web app testing.
- **Exam coverage.** CompTIA tests proxies under Objective 2.1 (scanning methods) and again indirectly under 1.4 (threat hunting) and 4.1 (reporting). Knowing the *difference* between scanner output and proxy-proven exploitability is a frequent stem.

This is where vulnerability management stops being a spreadsheet and starts being a fight.

## Key facts

### How it actually works

1. You configure your browser (or the application's HTTP client) to send all traffic to `127.0.0.1:8080` — the proxy's listener.
2. You install the proxy's **CA certificate** in your browser's trust store. Without this, every HTTPS site throws a cert warning because the proxy is presenting its own cert.
3. The proxy now sees plaintext HTTP for every request and response. It can:
   - **Intercept** — pause the request, let you edit it, then forward
   - **Repeat** — replay a captured request with modifications, over and over
   - **Fuzz** — fire thousands of variants of a parameter to find input handling bugs
   - **Scan** — run automated active checks against captured endpoints
   - **Spider/crawl** — walk the app to map every endpoint

### OWASP ZAP vs Burp Suite

| Feature | OWASP ZAP | Burp Suite Community | Burp Suite Pro |
|---|---|---|---|
| License | Free, open source | Free | Commercial |
| Maintained by | [[OWASP]] | PortSwigger | PortSwigger |
| Active scanner | Yes | No | Yes |
| Passive scanner | Yes | Yes | Yes |
| Intruder (fuzzer) | Built-in (Fuzzer) | Rate-limited | Full speed |
| Repeater | Yes | Yes | Yes |
| Extensions | ZAP Marketplace | BApp Store | BApp Store |
| Exam emphasis | High (OWASP-aligned) | High (industry standard) | Lower |

**ZAP** is what you reach for when the budget is zero and the boss wants an OWASP-aligned report. It does automated **passive scanning** (just watching traffic for issues) and **active scanning** (sending malicious payloads) out of the box. It's the answer when the exam stem says "open source" or "OWASP."

**Burp** is what every pen tester actually uses day to day. The Repeater and Intruder tabs are muscle memory in the industry. The Community edition has a throttled Intruder and no active scanner — Pro removes those limits. Exam stem says "commercial industry standard" or "free edition with manual testing focus" → Burp.

### Passive vs active scanning (proxy edition)

This maps directly to Objective 2.1's **passive vs active** distinction:

- **Passive scanning** — the proxy reads traffic as it flows naturally and flags issues it sees in the responses: missing security headers (`X-Frame-Options`, `Strict-Transport-Security`, `Content-Security-Policy`), cookie flags (`HttpOnly`, `Secure`, `SameSite`), verbose error messages, reflected input. Zero extra requests sent. Safe for production.
- **Active scanning** — the proxy injects payloads: SQLi strings, XSS vectors, command injection, path traversal, SSRF probes. *Generates real attack traffic.* Will trip a [[WAF]], will fill the SIEM with alerts, can break the app. Never point this at production without written authorization.

> **CompTIA exam trap:** passive scanning is *not* the same as **passive reconnaissance** in threat intel. Passive proxy scanning still requires you to be browsing the live app — you're inside the session. "Passive" here means *no additional attack payloads,* not *no contact with the target.*

### Static vs dynamic — where proxies live

Proxies are pure **DAST** — Dynamic Application Security Testing. They test a *running* application by sending real traffic. Compare:

| Type | What it tests | Tooling | Catches |
|---|---|---|---|
| **SAST** (static) | Source code at rest | SonarQube, Checkmarx, Semgrep | Logic bugs, hardcoded secrets, dangerous functions |
| **DAST** (dynamic) | Running app via HTTP | ZAP, Burp | Runtime bugs, auth flaws, injection |
| **IAST** (interactive) | Running app + instrumented code | Contrast, Seeker | Both, with stack traces |

SAST sees the recipe. DAST eats the meal. You need both.

### Fuzzing through the proxy

**Fuzzing** is sending malformed, unexpected, or boundary-case input to a parameter and watching for crashes, errors, or unexpected behavior. In Burp this is **Intruder**; in ZAP it's the **Fuzzer**.

Attack types you should recognize:

- **Sniper** — one payload position, one wordlist, sequential
- **Battering ram** — same payload in multiple positions simultaneously
- **Pitchfork** — parallel wordlists, one payload per position
- **Cluster bomb** — every combination of every payload across every position (slowest, most thorough)

Cluster bomb on a login form with a username list and password list = credential stuffing in a box. Know which mode is which — CompTIA has been known to ask.

### Special considerations

Proxies have hard rules. Break them and you're the incident, not the responder:

- **Authorization in writing.** Always. Bug bounty scope, SOW, rules of engagement — paper or it didn't happen.
- **TLS cert trust** — installing the proxy CA in your trust store means *anything* signed by that CA is trusted. Don't browse your bank through the same browser profile you use for testing.
- **Out-of-scope domains** — Burp and ZAP both let you set scope. Set it. A misclicked spider on an out-of-scope partner site can cost a job.
- **Rate limiting and DoS** — Intruder cluster bomb against a small endpoint *will* take the app down. Throttle it.
- **PII and regulated data** — if the app processes [[PCI DSS]] cardholder data or HIPAA PHI, your proxy logs now contain regulated data. Treat the project file like a crown-jewel artifact: encrypted at rest, destroyed per the SOW.
- **OT/ICS/SCADA** — *never* point an active scanner or a fuzzer at industrial control systems. The protocols (Modbus, DNP3) were not designed to handle malformed input. You will brick a PLC. Use [[passive scanning]] only.

> **CompTIA exam trap:** when the scenario involves [[ICS]] / [[SCADA]] / [[OT]] environments, the right answer is almost always **passive monitoring** — never active scanning, never fuzzing, never aggressive credentialed scans. CompTIA tests this specifically under "special considerations."

### Where proxies fit in the bigger picture

- [[OWASP Top 10]] — the proxy is the primary tool for verifying findings like A03 Injection, A07 Identification & Authentication failures, A01 Broken Access Control
- [[CVSS]] — proof-of-exploit from a proxy lets you justify the **Attack Complexity** and **User Interaction** metrics with evidence instead of guesses
- [[CIS Benchmarks]] — proxies don't test these; CIS benchmarks are config compliance, not runtime behavior
- [[ISO 27001]] / [[PCI DSS]] — both require regular application security testing; proxy-driven DAST is one accepted method

## SOC reality

- The alert you'll actually see: a flood of WAF blocks and 4xx responses from a single internal IP — that's the pen tester running Burp Active Scan on the staging environment. Check the change calendar before you wake the IR lead.
- *Authorized testing traffic looks identical to a real attack at the WAF layer. The only difference is the change ticket.* If there's no ticket, treat it as an attack until proven otherwise.
- L1 first move when a proxy-driven test trips the SIEM: confirm the source IP belongs to the contracted tester, confirm the engagement window is open, confirm the scope covers the target. Document, don't dismiss.
- What the CISO asks after a pen test report lands: "Was this proven exploitable, or is it scanner output?" The honest answer is one word — **Burp** or **ZAP** — followed by a screenshot of the Repeater tab firing the payload and the database error in the response. Anything less is a finding the dev team will fight you on.
- The handoff: pen tester → vuln management → app owner → dev team → re-test. The proxy project file is the chain of evidence. Save it. Hash it. Treat it like forensic evidence because in a breach post-mortem, that's exactly what it becomes.

## Related concepts

[[OWASP]] · [[OWASP Top 10]] · [[Vulnerability Scanning]] · [[Nessus]] · [[Penetration Testing]] · [[SAST]] · [[DAST]] · [[Fuzzing]] · [[XSS]] · [[SQL Injection]] · [[CSRF]] · [[WAF]] · [[CVSS]] · [[PCI DSS]] · [[SCADA]] · [[ICS]] · [[OT Security]] · [[CIS Benchmarks]]

*Source: VIRGIL knowledge base — 2026-05-11*