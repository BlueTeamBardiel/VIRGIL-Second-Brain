```markdown
---
domain: "identity-and-access"
tags: [password-spray, credential-access, authentication-attack, brute-force, mitre-attack, account-takeover]
---
# Password Spray

A **password spray** is a credential-based attack in which an adversary attempts a small number of **common or likely passwords** against a **large set of user accounts**, deliberately inverting the logic of a traditional [[Brute Force Attack]] to stay beneath per-account lockout thresholds. Because each individual account sees only one or two authentication failures, the attack blends into baseline authentication noise and routinely evades naive detection controls. It is catalogued by MITRE ATT&CK as sub-technique **T1110.003** under [[Credential Access]] and has been a defining initial-access technique in major nation-state campaigns against [[Microsoft Entra ID]], [[Active Directory]], and internet-facing [[VPN]] and [[Outlook Web Access]] portals.

---

## Overview

Password spraying emerged as a practical alternative to vertical brute forcing once defenders universally adopted account lockout policies — typically 3–10 failed attempts per account within a rolling window. A classic vertical attack against a single account (trying `password1`, `password2`, `Summer2024!`, and so on) trips the lockout almost immediately. By rotating the attacker's variable from the password to the username, a spray stays below the per-account threshold while exploiting the statistical certainty that, across hundreds or thousands of users, at least a fraction will have chosen a predictable credential such as `Winter2024!`, `Welcome1`, or the organization's own name combined with a digit.

The technique is especially effective against **single sign-on (SSO)** portals and **federated identity** systems that expose authentication endpoints to the public internet. Microsoft 365's `login.microsoftonline.com`, ADFS services, Exchange Outlook Web Access, Citrix gateways, and SSL-VPN concentrators are canonical targets. A successful spray yields a valid credential with no malware footprint; absent [[Multi-Factor Authentication|MFA]], that credential is equivalent to full initial access. From that foothold, attackers read email, harvest [[OAuth]] tokens, pivot to internal systems via [[VPN]] credentials, or establish persistence through mailbox delegation rules and rogue application consent grants.

Real-world incidents have repeatedly demonstrated the technique's potency. In January 2024, Microsoft disclosed that **Midnight Blizzard** (APT29 / Cozy Bear) used a password spray against a legacy non-production tenant that lacked MFA, then pivoted through a test OAuth application with broad permissions to access senior-leadership email. Hewlett Packard Enterprise reported a parallel intrusion by the same actor weeks later. Iranian actor **Peach Sandstorm** conducted extensive spray campaigns throughout 2023 against the U.S. defense industrial base, satellite sector, and pharmaceutical organizations, prompting a joint CISA advisory (AA23-270A). The U.S. Department of Justice's 2018 indictment of Iran's *Mabna Institute* detailed a spray campaign that compromised roughly 8,000 university professor accounts worldwide.

Password spraying sits within a family of related credential attacks: [[Credential Stuffing]] reuses known breached username–password pairs; traditional [[Brute Force Attack]] exhaustively guesses passwords against a single account; [[Phishing]] tricks the user into surrendering credentials directly. Spraying differs in that it requires **no prior breach data** and no victim interaction — only a username list, which is frequently trivial to enumerate from LinkedIn, corporate email-format conventions, or authentication oracles that distinguish "user not found" from "wrong password."

## How It Works

A spray operation has three phases: **enumeration**, **attack execution**, and **triage**.

### Phase 1 — Username Enumeration

The attacker assembles a target list from multiple sources:

- **OSINT collection:** LinkedIn scraping tools such as `theHarvester` or `linkedin2username` derive `first.last@target.com` addresses for every employee with a public profile.
- **Format inference:** once `john.smith@acme.com` is confirmed, every variant of every discovered employee name is generated.
- **Authentication oracle abuse:** Microsoft's `GetCredentialType` endpoint and on-premises ADFS services historically returned different responses (timing, error codes, redirect behavior) for existing vs. nonexistent accounts, allowing zero-cost username validation at scale. Microsoft has partially mitigated this, but self-hosted ADFS installations often remain vulnerable.

### Phase 2 — Password Selection

Candidates are selected for maximum success probability across large populations:

- Seasonal/calendar patterns: `Spring2024!`, `Winter2024!`, `Summer24`
- Organization-specific predictors: `Acme2024`, `AcmeCorp1!`, `Acme@123`
- Published weak-password corpora: SecLists `top-10000.txt`, the HaveIBeenPwned top-1000 list, Hashcat's `rockyou.txt` head
- Password-policy-compliant minimums: `Password1`, `P@ssw0rd`, `Welcome1` (uppercase + lowercase + digit + special = policy pass)

### Phase 3 — Throttled, Distributed Execution

To evade lockout and SIEM time-window correlation, attempts are throttled and rotated:

- **Rate:** one attempt per account per 30–90 minutes.
- **Distribution:** residential proxy networks, TOR exit nodes, or botnets spread attempts across hundreds of source IPs, defeating IP-based blocking.
- **Rotation:** after one password is sprayed across the full list, the attacker waits before loading the next candidate.

The attack targets any service that accepts password-based authentication:

| Target Service | Port / Protocol | Authentication Endpoint |
|---|---|---|
| Microsoft Entra ID (Azure AD) | 443 / HTTPS | `login.microsoftonline.com/common/oauth2/token` |
| Exchange OWA | 443 / HTTPS | `/owa/auth.owa` |
| ADFS | 443 / HTTPS | `/adfs/services/trust/2005/usernamemixed` |
| Kerberos (on-prem AD) | 88 / UDP + TCP | AS-REQ pre-authentication exchange |
| SMB | 445 / TCP | NTLM challenge–response |
| RDP | 3389 / TCP | Network Level Authentication (NLA) handshake |
| SSH | 22 / TCP | keyboard-interactive auth |
| VPN (Fortinet/SonicWall) | 443 / HTTPS | SSL-VPN login portal |

#### Tool Examples

**Kerbrute** — targets on-premises Kerberos. Critically, failed AS-REQs generate Event ID **4771** on domain controllers rather than **4625**, which most legacy SIEMs alert on:

```bash
# Step 1 — enumerate valid usernames using Kerberos AS-REQ
./kerbrute userenum -d corp.acme.local --dc 10.0.0.10 all_names.txt

# Step 2 — spray one password across validated accounts
./kerbrute passwordspray -d corp.acme.local --dc 10.0.0.10 \
    valid_users.txt 'Summer2024!' --delay 2000
```

**MSOLSpray** — targets Microsoft 365 authentication endpoints:

```powershell
# Import and run with a 30-second sleep and 30% jitter between accounts
Import-Module .\MSOLSpray.ps1
Invoke-MSOLSpray -UserList .\users.txt -Password 'Winter2024!' `
    -Sleep 30 -Jitter 0.3
```

**Hydra** — generic HTTP POST spray against OWA or any web login form:

```bash
hydra -L users.txt -p 'P@ssw0rd1' mail.acme.com \
    https-post-form "/owa/auth.owa:username=^USER^&password=^PASS^:Invalid"
```

**CrackMapExec** — targets SMB / Active Directory over a network range:

```bash
# Spray across a /24 subnet, one password, no lockout risk at default AD policy
crackmapexec smb 10.0.0.0/24 -u users.txt -p 'Summer2024!' \
    --continue-on-success
```

A successful hit returns a valid credential. The attacker then triages by privilege level (global admin, mailbox delegate, VPN user), determines what internal resources are reachable, and proceeds to [[Lateral Movement]] or [[Persistence]] techniques.

## Key Concepts

- **Low-and-slow:** The defining operational characteristic of spraying. Attempts are deliberately throttled — often one per account per 30–90 minutes — to stay beneath lockout counters and SIEM time-window correlation thresholds. Speed would trigger detection; patience is the weapon.
- **Horizontal attack pattern:** The spray rotates along the *user axis* (many accounts, few passwords), as opposed to the *vertical* brute force pattern (one account, many passwords). This distinction is the most commonly tested concept on Security+.
- **Authentication enumeration oracle:** Any application response difference — HTTP status code, error message, timing variance, redirect destination — that reveals whether a username is valid, independent of password correctness. Enables pre-spray list validation at zero authentication cost.
- **Seasonal / organization-derived password:** Human-predictable credentials following calendar events or company naming conventions (`Spring2024!`, `Acme@123`). Persistently the highest-yield spray candidates in enterprise environments because they satisfy complexity requirements while remaining guessable.
- **Smart Lockout:** Microsoft Entra ID's adaptive lockout mechanism that tracks failure state per source IP in addition to per account, preventing a distributed spray from triggering mass user lockouts that would alert defenders or deny service.
- **MITRE T1110.003:** The formal ATT&CK sub-technique ID for Password Spraying, nested under T1110 (Brute Force) in the Credential Access tactic. Required knowledge for exam and threat-report literacy.
- **Legacy authentication protocols:** Basic Auth, SMTP AUTH, IMAP, POP, and legacy Exchange Web Services — protocols that cannot enforce MFA and are therefore the top-priority spray surface in Microsoft 365 environments.

## Exam Relevance

SY0-701 tests password spraying explicitly in **Domain 2.4** ("Analyze indicators of malicious activity") under password attacks, and in **Domain 4.1** (applying security controls to account policies).

**Common question patterns:**

- **Scenario → technique identification:** "An attacker tried the password `Summer2024!` against 800 user accounts, triggering no lockouts. Which attack type is this?" → **Password Spray**. The tell is *few passwords + many users + no lockouts*.
- **Differentiation from look-alikes:**
  - **Credential Stuffing** → uses *previously breached* username:password pairs from a known data set.
  - **Brute Force** → many passwords against *one* account.
  - **Rainbow Table** → precomputed hash comparisons against a captured password hash; no live authentication.
  - **Dictionary Attack** → a wordlist against one or a small set of accounts; still vertical in orientation.
- **Best mitigation:** The exam's preferred answer is **MFA** — specifically phishing-resistant MFA (FIDO2/WebAuthn, PIV/CAC certificates). Account lockout alone is an *incorrect* primary answer because spraying is architecturally designed to evade it; an overly aggressive lockout policy can itself become a denial-of-service vector.
- **Detection indicator:** The canonical IoC is *many distinct accounts experiencing one failed login from the same source IP within a short time window*.
- **Gotcha:** Increasing password complexity does not eliminate spraying if users predictably fulfill complexity requirements with patterns like `Company1!`. NIST SP 800-63B guidance (screen against breached corpora, favor length over complexity) is the correct policy direction.

## Security Implications

Any internet-exposed authentication endpoint without MFA is within the spray attack surface. Documented high-impact incidents include:

- **Midnight Blizzard / Microsoft (January 2024):** APT29 sprayed a legacy test tenant lacking MFA, obtained credentials, then leveraged a test OAuth application with `EWS.AccessAsUser.All` permissions to access Microsoft corporate executive mailboxes. Microsoft disclosed the breach in an SEC 8-K filing; the incident is a textbook case of how a low-priv spray credential chains to catastrophic data exposure through over-permissioned applications.
- **Peach Sandstorm (2023):** Iranian state-sponsored actor conducted multi-month spray campaigns against the U.S. defense industrial base, satellite sector, and pharmaceutical organizations. CISA and Microsoft published joint advisory **AA23-270A** with specific IOCs including MANGO SANDSTORM password spray infrastructure.
- **Citrix Internal Breach (2018–2019):** FBI attributed unauthorized access to Citrix Systems to Iranian password spraying, with roughly 6 TB of business documents exfiltrated. Citrix disclosed the breach in March 2019, months after initial compromise.
- **Mabna Institute / DOJ Indictment (2018):** Nine Iranian nationals indicted for a spray campaign compromising 144 U.S. universities, 176 universities in 21 other countries, 47 domestic and foreign private-sector companies, and three U.S. government agencies.

**Related CVEs exploited in spray-adjacent attack chains:**
- **CVE-2023-23397** (Microsoft Outlook NTLM relay zero-click): Attackers used spray-obtained low-priv accounts to access internal infrastructure and send crafted calendar invites that triggered NTLM hash leakage.
- **CVE-2020-1472 (Zerologon):** Combined with a spray-obtained domain-joined computer account, enabled unauthenticated domain compromise.
- **CVE-2019-19781 (Citrix ADC path traversal):** Spray-obtained VPN credentials were used post-exploitation to move from the VPN to internal application servers.

Downstream consequences include **Business Email Compromise (BEC)**, [[OAuth]] consent-grant persistence, ransomware staging, supply-chain pivots through federated partner tenants, and regulatory exposure under GDPR Article 33, HIPAA Breach Notification, and SEC incident-disclosure rules (17 CFR 229.106).

## Defensive Measures

Effective defense requires layered controls; no single measure is sufficient.

**1. Enforce phishing-resistant MFA universally**

Deploy FIDO2/WebAuthn hardware keys (YubiKey 5 series, Google Titan), Windows Hello for Business, or certificate-based authentication (PIV/CAC). Even if a spray succeeds in validating a password, MFA blocks authentication completion. NIST SP 800-63B AAL2+ is the policy reference; SMS and voice OTP are explicitly discouraged at high-assurance levels.

**2. Eliminate legacy authentication protocols**

In Microsoft 365, disable Basic Authentication via **Entra ID Conditional Access**:

```json
{
  "displayName": "Block Legacy Auth",
  "conditions": {
    "clientAppTypes": ["exchangeActiveSync", "other"]
  },
  "grantControls": {
    "operator": "OR",
    "builtInControls": ["block"]
  },
  "state": "enabled"
}
```

On-premises: disable NTLM where Kerberos is available; audit with `Get-ADDomain | Invoke-ADServiceAccountAudit`.

**3. Enable Microsoft Entra ID Password Protection**

Entra ID Password Protection enforces Microsoft's global banned-password list (updated from real-world spray data) plus a custom tenant banned list. Deploy the on-premises agent to domain controllers to extend protection to Active Directory password changes:

```powershell
# Install the DC agent on each domain controller
Install-AzureADPasswordProtectionDCAgent
Register-AzureADPasswordProtectionDCAgent -AccountUpn admin@acme.com
```

**4. Deploy risk-based Conditional Access**

Require step-up MFA or block sign-ins when `signInRiskLevel >= medium` or `userRiskLevel >= high`. Use **Microsoft Entra ID Protection** (formerly Azure AD Identity Protection) for ML-driven spray detection.

**5. Monitor for spray IoCs in SIEM**

Key Windows Security Event IDs:
- **4625** — Logon failure (Status `0xC000006A` = wrong password; `0xC0000064` = unknown username)
- **4771** — Kerberos pre-authentication failure (failure code `0x18` = bad password)
- **4648** — Logon with explicit credentials (