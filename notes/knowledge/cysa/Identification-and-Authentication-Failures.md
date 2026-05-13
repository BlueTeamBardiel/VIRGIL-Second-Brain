# Identification and Authentication Failures

## What it is

In **Hitman**, Agent 47 walks into Sapienza wearing a chef's coat he peeled off an unconscious staffer in a freezer. The guard at the lab door glances at the outfit, not the face, and waves him through. Later, the auction-house bouncer scans a forged invitation — the paper looks right, so the man with the silenced pistol gets a glass of champagne and a clean line on his target. Nobody asked for a second factor. Nobody checked if the chef should be in the bioweapon vault. The whole game is a tour of what happens when systems trust the costume instead of the person.

That's exactly what identification and authentication failures are — the app trusts the credential, not the human behind it, and an attacker in a stolen chef's coat walks straight into the lab.

**Identification** is the claim ("I am user `jsmith`"). **Authentication** is the proof (password, token, biometric, certificate). **Identification and Authentication Failures** is OWASP A07:2021 — the category covering every way that proof breaks: weak passwords, missing MFA, broken session handling, credential leaks, predictable recovery flows, and exposed authentication endpoints that let attackers brute-force or spray at will.

For CySA+ Objective 2.2, you see this category through scanner output: [[Nessus]], [[OpenVAS]], [[Burp Suite]], [[ZAP]], [[Nikto]], and web app scanners flag the symptoms — default creds still active, login endpoints without rate limiting, session cookies missing `Secure`/`HttpOnly`, password policies that accept `Summer2025!`.

## Why it matters

Verizon's DBIR has put stolen credentials in the top initial-access vector for years running. Not zero-days. Not nation-state implants. Logins. The attacker doesn't need to break the door if the key is on Pastebin.

For the CySA+ analyst, this objective sits at the intersection of **vulnerability management** and **detection engineering**. Scanner output tells you the door is weak. SIEM tells you when someone is trying the door. You need both lenses.

**Exam relevance:** CS0-003 Objective 2.2 (analyzing vulnerability tool output) tests whether you can read a scanner report, identify auth-related findings, prioritize them, and recommend the right control. Expect questions where the scanner flags "HTTP Basic Auth over cleartext" or "weak password policy" and you pick the fix.

## Key facts

### The two attacks every analyst sees weekly

| Attack | Mechanic | Why it works | Detection signal |
|---|---|---|---|
| **Password spraying** | One password (`Winter2026!`) tried across thousands of accounts, slowly | Stays under per-account lockout thresholds | Many failed logins, **one password**, many users, low rate per account |
| **Credential stuffing** | Username/password pairs from breach dumps tried against your app | Users reuse passwords; the dump from a forum site unlocks corporate VPN | Many failed logins, **many passwords**, valid usernames, often from botnet IPs |

The exam loves the distinction. Spraying = horizontal (one password, many accounts). Stuffing = paired creds from an external breach.

*A lockout policy of "5 failures = 30 min lock" stops brute force on one account. It does nothing against spraying, because the attacker only tries one password per account per hour. Lockouts are a speed bump for the wrong attack.*

### Scanner findings that map to this category

[[Nessus]] / [[OpenVAS]] (network and web scanners):
- **Default credentials** on web consoles, network appliances, databases (`admin:admin`, `root:calvin` on iDRAC, `cisco:cisco`)
- **Cleartext authentication** — HTTP Basic, FTP, Telnet, SNMPv1/v2c community strings
- **Weak SSH config** — password auth enabled, no key-only enforcement
- **Anonymous LDAP / SMB / FTP** binds allowed
- **Expired or self-signed TLS** on auth endpoints (enables MitM credential capture)

[[Burp Suite]] / [[ZAP]] / [[Nikto]] / [[Arachni]] (web app scanners):
- Login forms without **rate limiting** or **CAPTCHA** after N failures
- **Username enumeration** — "User not found" vs "Wrong password" leaks valid usernames
- **Session cookies** missing `Secure`, `HttpOnly`, `SameSite`
- **Predictable session IDs** or session fixation
- **Password reset** flows that leak account existence or use guessable tokens
- **JWT** issues — `alg:none` accepted, weak HMAC secret, no signature verification

[[Scout Suite]] / [[Prowler]] / [[Pacu]] (cloud infrastructure assessment):
- **IAM users without MFA** (especially root)
- **Long-lived access keys** — no rotation, sometimes years old
- **Overly permissive password policies** in Azure AD / IAM
- **Public S3/Blob auth endpoints** or **Cognito** misconfigurations
- **No conditional access** policies on privileged identities

### The vulnerability-to-control mapping (memorize this for the exam)

| Scanner finding | Root cause | Recommended control |
|---|---|---|
| Weak password policy | No complexity/length enforcement | Enforce length (14+), check against breach corpus (HaveIBeenPwned API) |
| No MFA on admin accounts | Identity provider not enforcing | Mandatory **phishing-resistant MFA** (FIDO2/WebAuthn), not SMS |
| Login endpoint, no rate limit | App layer config | Rate limit per IP and per account, add CAPTCHA on anomaly |
| Credentials in code/config | Developer hygiene | Secrets manager (Vault, AWS Secrets Manager), pre-commit hooks |
| Stolen creds reused | User behavior + breach exposure | **Credential monitoring** (dark web feeds, [[Recon-ng]] for OSINT), force reset on hit |
| Session fixation | App generates session ID before auth | Regenerate session ID **after** successful auth |
| JWT `alg:none` accepted | Library default / dev error | Allowlist algorithms server-side, verify signature always |
| Public auth endpoint, no IP allow-list | Architecture | Place admin auth behind VPN or conditional access |

### Phishing-resistant MFA — why CompTIA cares about the distinction

Not all MFA is equal:

- **SMS / voice OTP** — phishable, SIM-swappable. Weak.
- **TOTP app** (Authenticator, Authy) — phishable in real time via reverse proxy (evilginx).
- **Push notification** — vulnerable to MFA fatigue ("approve" spam until the user clicks).
- **FIDO2 / WebAuthn / hardware tokens** — phishing-resistant. The token cryptographically binds to the origin; a fake login page can't replay it.

The exam will offer SMS as an MFA answer for a high-value account. It's wrong. Pick FIDO2/hardware token when the question specifies "phishing-resistant" or "privileged access."

### Tools that test this category directly

- **[[Burp Suite]] Intruder** — automate login brute force, spray, stuffing against a target endpoint
- **[[Hydra]]** / **[[Medusa]]** — protocol-level credential brute force (SSH, RDP, SMB, HTTP)
- **[[Metasploit framework (MSF)]]** — `auxiliary/scanner/http/http_login`, SMB login scanners, default-cred checks
- **[[Nmap]]** NSE scripts — `ssh-brute`, `http-default-accounts`, `ftp-anon`
- **[[Nikto]]** — flags default web admin paths and known weak auth
- **[[Recon-ng]]** / **[[Maltego]]** — OSINT for leaked credentials, breach dump correlation
- **[[Pacu]]** — AWS exploitation, including IAM credential abuse paths
- **[[GDB]] / [[Immunity Debugger]]** — reverse a binary to find hardcoded creds or weak auth logic (less common on CySA+ but listed in objective)

### CompTIA exam traps

> **CompTIA exam trap:** Spraying vs stuffing. The stem describes "one password attempted against many usernames over 48 hours" — that's **spraying**, not stuffing. Stuffing uses pre-paired creds from a breach dump. If the question mentions "credentials from a third-party breach," it's stuffing. If it mentions "common password tested broadly," it's spraying.

> **CompTIA exam trap:** Account lockout as the fix for spraying. Lockouts protect against **vertical brute force** (many tries on one account). They don't stop spraying, which stays under the threshold by design. The right control is **anomaly-based detection** (impossible travel, geo-velocity, multiple failed logins across accounts from one IP) plus rate limiting per source IP.

> **CompTIA exam trap:** "MFA solves it." MFA solves most of it, but the exam tests nuance — SMS MFA can be bypassed via SIM swap or real-time phishing. If the question specifies a privileged account or phishing-resistant requirement, the answer is **FIDO2 / hardware token**, not generic "enable MFA."

> **CompTIA exam trap:** Default credentials are a separate finding from weak password policy. A scanner flagging `admin:admin` on a Tomcat manager console is a **default credentials** finding — remediate by changing the password and disabling the default account. Don't conflate it with "no password complexity policy."

### Prioritization — not every auth finding is P1

CVSS on auth findings varies wildly. Use this triage logic:

1. **Internet-exposed + default creds + admin function** → P1, drop everything. (Tomcat manager on a public IP with `tomcat:tomcat` is a foothold waiting to happen.)
2. **Internet-exposed login + no MFA + no rate limit** → P1, especially for VPN, RDP gateway, OWA, M365.
3. **Internal admin console without MFA** → P2, dependent on segmentation.
4. **Weak password policy on low-privilege users** → P3, fix in the next cycle.
5. **Self-signed cert on internal admin page** → P3, but it enables credential theft if an attacker is already on the network.

*A CVSS 7.5 on an internal app behind a VPN with MFA is not the same as a CVSS 7.5 on the public-facing SSO portal. Environmental score matters. Exposure matters. The change board will not approve every P1 — bring evidence.*

## SOC reality

- **The 3am alert:** "Multiple failed authentication events, single source IP, 412 distinct usernames, one password, M365." That's spraying. L1 blocks the IP, checks for any successful logins from that IP, escalates if even one user authenticated.

- **The L1 first move:** Pull the failed login logs, sort by source IP and by password hash if available, identify whether it's spraying (one password) or stuffing (many passwords, paired with usernames). Check for **any** success from the offending IPs. One success means an account is compromised — different playbook entirely.

- **What the IR lead asks:** "Did anyone authenticate successfully from those IPs? What did they touch after login? Any mailbox rule changes, OAuth grants, MFA device registrations, password resets?" Post-auth actions are where the real damage shows up — the login is just the entry.

- **Never promise leadership:** "We have MFA, we're fine." MFA fatigue, push bombing, adversary-in-the-middle phishing (evilginx, EvilProxy) bypass non-phishing-resistant MFA daily. The right answer is "MFA reduces our exposure significantly; we're rolling out FIDO2 for privileged accounts and monitoring for MFA bypass patterns."

- **The handoff:** L1 contains (block IP, force password reset for any successful login). L2 hunts (look for the same IP or TTP across other tenants, check threat intel for the source). IR engages if any account was confirmed compromised, with identity team for token revocation and mailbox/OAuth review.

## Related concepts

[[OWASP Top 10]] · [[CVSS]] · [[MFA]] · [[FIDO2]] · [[Password spraying]] · [[Credential stuffing]] · [[Nessus]] · [[OpenVAS]] · [[Burp Suite]] · [[ZAP]] · [[Nikto]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]] · [[Recon-ng]] · [[Metasploit framework (MSF)]] · [[Session management]] · [[JWT]] · [[Conditional access]] · [[Identity and Access Management (IAM)]]

*Source: VIRGIL knowledge base — 2026-05-11*