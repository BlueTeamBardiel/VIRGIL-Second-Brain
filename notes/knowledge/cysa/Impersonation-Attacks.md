# Impersonation Attacks

## What it is

In **Demon's Souls**, the Old Monk fight in 3-3 doesn't summon a scripted boss — it pulls a real human player from another world wearing the **False King's robes**. You step into the fog gate expecting Allant. You get a phantom in a costume, dropped on top of you by the game's own matchmaking. The cathedral trusts the invader because the *system* invited them in. You die to a player who never had to earn the right to be there — the robe did the work.

That's impersonation. The attacker doesn't break the lock. The system hands them a key because the **identity check terminated at the costume**, not the person inside it.

In CySA+ terms, an **impersonation attack** is any technique where an adversary assumes the identity of a legitimate user, service, or system — through stolen tokens, forged sessions, abused trust relationships, or weak authentication flows — and operates with that identity's privileges. The vulnerability scanner's job (Objective 2.2) is to surface the conditions that make it possible: missing token validation, broken OAuth redirect handling, weak session controls, exposed service accounts, and trust boundaries that don't actually check anything.

## Why it matters

Impersonation is the connective tissue of every modern intrusion. Initial access gets you a foothold. Impersonation gets you everywhere else. Pass-the-hash, pass-the-ticket, OAuth token theft, SAML assertion forgery, AWS STS abuse, session hijacking, ARP spoofing on the LAN — all of it is the attacker wearing somebody else's robe and the system not questioning it.

CySA+ Objective 2.2 lives here because impersonation findings come out of **vulnerability assessment tools** before they show up in your SIEM as a real intrusion. [[Burp Suite]] catches the JWT with `alg: none`. [[Nessus]] flags the SMB signing disabled. [[Scout Suite]] reports the IAM role with `sts:AssumeRole` open to `*`. [[Nikto]] sees the cookie missing `HttpOnly`. The exam wants you to read those reports and connect "scanner output" → "impersonation primitive" → "remediation."

The career stakes: a missed impersonation primitive is how the IR retro ends with someone explaining to the CISO why the attacker had Domain Admin for eleven days.

## Key facts

### The four impersonation primitives

| Primitive | What the attacker steals/forges | Tool that surfaces it |
|---|---|---|
| **Credential reuse / theft** | Username + password, NTLM hash, Kerberos ticket | [[Nessus]], [[OpenVAS]], [[Metasploit]] auxiliary modules |
| **Token / session theft** | Session cookie, JWT, OAuth access token, SAML assertion | [[Burp Suite]], [[ZAP]], [[Nikto]] |
| **Trust abuse** | Service account, AD trust, IAM role chain, federation | [[Scout Suite]], [[Prowler]], [[Pacu]], [[Recon-ng]] |
| **Network identity spoofing** | MAC, IP, ARP, DNS, BGP | [[Nmap]], [[Angry IP Scanner]], [[Maltego]] for mapping |

### Root causes the scanners actually find

**Weak session handling.** Cookies without `Secure`, `HttpOnly`, or `SameSite`. Session IDs in URLs. Sessions that don't rotate on privilege elevation. Sessions that never expire. [[Burp Suite]] and [[ZAP]] flag these in their passive scan output — the finding usually reads something like "Cookie without HttpOnly flag" with a CWE-1004 reference. Low severity in the report. Catastrophic in combination with an XSS finding two rows down.

**OAuth misconfigurations.** The big ones:
- **`redirect_uri` wildcard or missing validation** — attacker redirects the auth code to their own host
- **Implicit flow still enabled** — tokens land in the URL fragment, leak through browser history and referer headers
- **No PKCE on public clients** — auth code can be intercepted and replayed
- **State parameter not validated** — CSRF on the OAuth dance itself
- **Long-lived refresh tokens with no rotation** — one theft, permanent access

[[Burp Suite]]'s extensions (specifically the OAuth scanner extensions) and manual flow walkthroughs catch these. Generic vuln scanners miss them — this is why web app pentests exist as a separate discipline.

**Poor redirect validation.** Open redirects (`/login?next=https://evil.tld`) are CVSS 4-ish on their own and CVSS 9 when chained into an OAuth flow or a phishing campaign that lands on a legitimate-looking domain. [[Nikto]] and [[Arachni]] surface obvious cases. The subtle ones — path traversal in the redirect target, scheme confusion (`javascript:`), domain confusion (`evil.victim.com` vs `victim.com.evil.tld`) — need manual review.

**Service account sprawl.** [[Scout Suite]] (multi-cloud), [[Prowler]] (AWS-focused), and [[Pacu]] (AWS offensive) light up when they find:
- IAM roles with `AssumeRolePolicyDocument` allowing `Principal: *`
- Service accounts with `iam:PassRole` to anything
- Long-lived access keys with no rotation
- Cross-account trust without external ID

### Network-layer impersonation

| Attack | Mechanism | Scanner / tool that maps it |
|---|---|---|
| **ARP spoofing** | Forged ARP replies poison the LAN cache, attacker becomes MITM | [[Nmap]] host discovery shows duplicate MACs |
| **DNS spoofing / cache poisoning** | Forged responses, the client trusts the wrong IP | [[Nmap]] NSE scripts (`dns-*`) |
| **DHCP spoofing** | Rogue DHCP server hands out attacker as gateway | [[Angry IP Scanner]] sweeps surface unexpected hosts |
| **NTLM relay** | Attacker forwards captured NTLM auth to a third host | [[Nessus]] flags SMB signing disabled; [[Metasploit]]'s `auxiliary/server/capture/smb` proves it |

### Tooling map for impersonation discovery

The CySA+ exam wants you to know which tool produces which finding. Memorize the lane each plays in:

**Network scanning and mapping**
- [[Nmap]] — host/service discovery, version detection, NSE scripts for protocol-specific impersonation checks (SMB signing, weak ciphers, default creds)
- [[Angry IP Scanner]] — fast lightweight sweeps, useful for finding hosts that shouldn't be on the segment
- [[Maltego]] — entity relationship mapping; useful for OSINT-driven impersonation prep (who reports to whom, what domains they own)
- [[Recon-ng]] — OSINT framework, surfaces leaked credentials, exposed subdomains, identity surface

**Web application scanners**
- [[Burp Suite]] — the gold standard for session/token/OAuth analysis. The Repeater tab is where you prove a session is forgeable.
- [[ZAP]] — open-source equivalent, passive scan catches cookie flag issues automatically
- [[Nikto]] — fast web server fingerprinting, surfaces default creds and misconfigured auth endpoints
- [[Arachni]] — automated web app scanner, decent at finding the cookie/session basics

**Vulnerability scanners (general)**
- [[Nessus]] — flags SMB signing, weak Kerberos encryption types, exposed service accounts, missing patches that enable token theft
- [[OpenVAS]] — open-source alternative, same lane

**Cloud infrastructure assessment**
- [[Scout Suite]] — multi-cloud (AWS, Azure, GCP) configuration auditing; IAM trust policy findings live here
- [[Prowler]] — AWS-focused, CIS benchmark + custom checks for IAM and STS abuse
- [[Pacu]] — offensive AWS framework; proves impersonation by actually assuming roles

**Exploitation / multipurpose**
- [[Metasploit Framework]] (MSF) — modules for capturing hashes, relaying NTLM, forging tickets (kiwi/mimikatz integration)
- **Debuggers** — [[GNU Debugger|GDB]] for Linux binaries, [[Immunity Debugger]] for Windows; relevant when impersonation involves binary-level token theft or analyzing malware that does it

### CompTIA exam traps

> **CompTIA exam trap:** Scanner output that says "Cookie set without HttpOnly flag" looks low-severity in isolation. CompTIA will pair it in a scenario with an XSS finding on the same app. The correct answer is that the *combination* enables session theft → impersonation. Single-finding triage misses this. Always read the scan output as a chained set.

> **CompTIA exam trap:** "OAuth implicit flow" vs "OAuth authorization code flow with PKCE." Implicit is deprecated specifically because it enables token impersonation (token in URL fragment). If a scenario describes a public SPA using implicit flow, the right answer is "migrate to authorization code + PKCE," not "add WAF rules."

> **CompTIA exam trap:** [[Pacu]] is offensive. [[Prowler]] and [[Scout Suite]] are defensive/assessment. CompTIA will list all three and ask which you use to *audit* IAM trust policies. Pacu is the wrong answer — it's the tool that *exploits* what Prowler/Scout Suite report.

> **CompTIA exam trap:** Maltego is **OSINT and entity mapping**, not a vulnerability scanner. If the scenario asks "which tool builds a relationship map of an organization's external identity surface," that's Maltego. If it asks "which tool finds the missing patch that enables NTLM relay," that's Nessus/OpenVAS.

### The analyst's job on impersonation findings

The CySA+ analyst doesn't just forward scan output. The job is:

1. **Identify trust boundaries.** Where does the system stop authenticating and start trusting? OAuth client_id-to-redirect_uri, IAM role-to-role, AD forest trusts, SAML IdP-to-SP. Every boundary is a costume rack.
2. **Validate token lifecycle controls.** Issuance, storage, rotation, revocation, expiration. A token with no revocation path is a forever-token. Scanner output rarely says this directly — you have to read auth flow documentation against the findings.
3. **Review authentication flows end-to-end.** Walk the flow in [[Burp Suite]]'s Proxy. Every redirect, every parameter, every token. The flaw is almost always at a hand-off where one component assumes the previous one validated something.
4. **Chain findings.** Single-finding triage misses impersonation. Cookie flag + XSS = session theft. Open redirect + OAuth = token theft. SMB signing disabled + reachable from user VLAN = NTLM relay to Domain Admin.

## SOC reality

- The alert at 3am rarely says "impersonation." It says "impossible travel," "anomalous OAuth consent grant," "new device sign-in from country we don't operate in," or "user accessed mailbox they've never touched." You're inferring impersonation from the *behavior* of an identity that suddenly doesn't match its baseline.
- L1's first move on a suspected account compromise: confirm with the user out-of-band (call their cell, not email — email is in the attacker's hands), then revoke active sessions and rotate credentials. **Do not just reset the password.** Tokens issued before the reset still work unless you revoke them at the IdP.
- The IR lead's first three questions: "What did the identity have access to? When did the impersonation start? What did the attacker touch?" Scope, timeline, blast radius. Scanner output from before the incident is forensic gold — it tells you which trust boundaries were already weak.
- Never promise leadership "we kicked them out" on identity-based intrusions. You kicked out the sessions you can see. Refresh tokens in the attacker's pocket, OAuth grants you didn't revoke, service principals they created — those persist. *The robe stays in the wardrobe until you burn the whole wardrobe.*
- Escalation: L1 confirms and contains the obvious sessions, L2 hunts for persistence (new MFA devices, new app registrations, mailbox forwarding rules, OAuth grants), IR engages legal if PII access is in scope. Cloud impersonation (Azure AD/Entra, AWS IAM) almost always goes straight to L2+ because the blast radius is enterprise-wide.

## Related concepts

[[OAuth 2.0]] · [[SAML]] · [[Session Management]] · [[JSON Web Tokens (JWT)]] · [[Pass-the-Hash]] · [[Pass-the-Ticket]] · [[Golden Ticket Attack]] · [[NTLM Relay]] · [[ARP Spoofing]] · [[DNS Spoofing]] · [[Burp Suite]] · [[ZAP]] · [[Nessus]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]] · [[Nmap]] · [[Maltego]] · [[Recon-ng]] · [[CVSS]] · [[Trust Boundaries]] · [[Identity and Access Management (IAM)]] · [[Multi-Factor Authentication]]

*Source: VIRGIL knowledge base — 2026-05-11*