---
domain: "offensive-security"
tags: [credential-attack, authentication, active-directory, brute-force, lateral-movement]
---
# Password Spraying

**Password spraying** is a type of [[Brute Force Attack]] that attempts a single commonly-used password against many accounts simultaneously, deliberately avoiding the per-account lockout thresholds that would trigger traditional brute-force defenses. Unlike credential stuffing, which relies on previously leaked username/password pairs, password spraying exploits the statistical likelihood that at least one user in a large organization has chosen a weak or predictable password. It is especially effective against [[Active Directory]] environments and any service exposing authentication endpoints to a network.

---

## Overview

Password spraying emerged as a practical evolution in attacker methodology as organizations began deploying account lockout policies to defend against traditional brute-force attacks. A lockout policy that locks an account after five failed attempts in thirty minutes is entirely ineffective against an attacker who tries one password against five thousand accounts — none of the accounts ever lock, yet the attacker may successfully authenticate as one or more of them. This asymmetry between defensive tooling and attacker technique made password spraying a staple of penetration testing and real-world intrusion campaigns.

The technique is particularly devastating in enterprise environments because human password behavior is highly predictable. Studies of leaked corporate password databases consistently show that employees default to patterns: the company name followed by the current year (`Contoso2024`), seasonal phrases (`Winter2024!`), or simple dictionary words with common substitutions. Password complexity requirements, ironically, often produce predictable outputs — users required to include a number and symbol frequently append `!1` or `@1` to a word, creating a narrow band of guessable passwords that spraying can efficiently test.

Password spraying has been documented in numerous high-profile nation-state campaigns. The U.S. Cybersecurity and Infrastructure Security Agency (CISA) and NSA attributed widespread password spraying to APT groups including Cozy Bear (APT29) in their 2020 advisory related to the SolarWinds supply chain compromise. Iranian threat actors (APT33) were linked to password spraying campaigns against aviation and energy companies in 2018. Microsoft has reported that password spray attacks account for over 16% of all identity-based attack attempts in their cloud telemetry.

The attack surface for password spraying extends well beyond internal Active Directory authentication. Any externally exposed authentication endpoint is a viable target: Outlook Web Access (OWA), Office 365/Entra ID, VPN portals, SSH servers, web application login forms, LDAP services, and legacy protocols like NTLM over SMB. The shift to cloud infrastructure has dramatically expanded exposure — Microsoft 365 and Azure AD tenants have authentication endpoints accessible globally, making them high-value targets that require no initial network foothold.

Timing and pacing are the defining operational characteristics that separate password spraying from brute force. Attackers deliberately throttle their attempts — commonly one attempt per account per 20–30 minutes — to stay beneath observation thresholds and avoid triggering SIEM alerts tuned to detect rapid repeated failures. Some advanced operators use distributed infrastructure, routing attempts through many source IPs to further reduce per-IP signal density.

---

## How It Works

### Attack Methodology

Password spraying follows a structured methodology with distinct phases:

**Phase 1: Target Enumeration**
Before passwords can be sprayed, valid usernames must be gathered. Attackers use multiple channels:
- **OSINT**: LinkedIn, company websites, email format discovery via tools like `hunter.io` or `theHarvester`
- **LDAP null sessions** or authenticated LDAP queries against exposed directory services
- **Kerbrute user enumeration** against Kerberos (port 88/TCP) — Kerberos returns different error codes for valid vs. invalid usernames without triggering lockouts
- **Office 365 user enumeration** via the `GetCredentialType` API endpoint (`login.microsoftonline.com/common/GetCredentialType`) which historically revealed whether a username was valid

```bash
# Kerbrute username enumeration against Active Directory
kerbrute userenum --dc 192.168.1.10 -d corp.local /usr/share/wordlists/usernames.txt

# theHarvester email harvesting
theHarvester -d contoso.com -b linkedin,google,bing -l 200
```

**Phase 2: Password List Construction**
Effective spraying uses a curated, minimal wordlist rather than a large dictionary. Common candidates include:
- `SeasonYear!` patterns: `Spring2024!`, `Winter2023!`
- Company name variations: `Contoso1!`, `C0ntoso@`
- Default/common passwords: `Password1`, `Welcome1`, `Monday1!`
- Local culture references (sports teams, local geography)

**Phase 3: Protocol Selection**
The choice of authentication protocol determines tooling and stealthiness:

| Protocol | Port | Common Target | Notes |
|---|---|---|---|
| Kerberos | 88/TCP | Active Directory | Low noise, no direct lockout trigger |
| LDAP | 389/TCP, 636/TCP | Active Directory, LDAP directories | Directly triggers failed logon events |
| SMB | 445/TCP | Windows file shares | Creates Event ID 4625 |
| OWA/EWS | 443/TCP | Exchange Server | Legacy auth, high value |
| WinRM | 5985/TCP | Remote management | Yields shell on success |
| RDP | 3389/TCP | Windows desktops | Noisy, often rate-limited |
| SSH | 22/TCP | Linux/network devices | Standard auth failure logging |

**Phase 4: Spray Execution**

Using **Spray** (Python):
```bash
# Spray against OWA
python spray.py -t https://mail.contoso.com/owa -u users.txt -p 'Winter2024!' -s 1 -a

# -s 1 = 1 second delay between attempts (increase significantly in real ops)
```

Using **Kerbrute** against Active Directory Kerberos:
```bash
# Password spray using Kerberos — minimizes lockout risk and LDAP logging
kerbrute passwordspray -d corp.local --dc 192.168.1.10 users.txt 'Password1!'
```

Using **CrackMapExec (CME)** / **NetExec** against SMB:
```bash
# Spray across an entire subnet — one password, many accounts
crackmapexec smb 192.168.1.0/24 -u users.txt -p 'Summer2024!' --continue-on-success

# Target specific host
nxc smb 192.168.1.10 -u users.txt -p 'Password1' --no-bruteforce
```

Using **MSOLSpray** for Microsoft 365:
```bash
# Spray against Azure AD / Microsoft 365
Invoke-MSOLSpray -UserList .\users.txt -Password "Spring2024!" -OutFile .\results.txt
```

**Phase 5: Credential Validation and Access**
A successful spray yields a valid credential set. The attacker then:
1. Validates the account's privileges (domain user, admin, service account)
2. Checks for MFA enrollment — unprotected accounts proceed directly to access
3. Moves laterally using [[Pass-the-Hash]], [[Kerberoasting]], or direct access to resources
4. Establishes persistence via [[Golden Ticket]] attacks or backdoor accounts

**Operational Security Considerations**
Sophisticated operators introduce jitter (randomized timing), use residential proxy networks to distribute source IPs, and schedule sprays during business hours to blend with legitimate authentication traffic. A single attempt per account every 45–60 minutes is essentially undetectable without behavioral baselining.

---

## Key Concepts

- **Account Lockout Threshold**: The number of failed authentication attempts before an account is temporarily disabled. Password spraying deliberately stays below this number (e.g., if threshold is 5, attacker tries only 1–2 passwords per account). Defined in [[Group Policy]] under Account Lockout Policy.

- **Bad Password Count**: A per-account counter stored in Active Directory (`badPwdCount` attribute) that increments with each failed authentication. Password spraying keeps this counter low — often at 1 — across all targeted accounts, producing an aggregate signal that is difficult to detect with per-account alerting.

- **Smart Lockout (Azure AD)**: Microsoft's cloud-based mechanism that tracks failed authentication attempts from unfamiliar locations and can lock cloud accounts independently of on-premises AD lockout policies. Can be partially circumvented by attackers who blend with legitimate login geography.

- **Credential Stuffing vs. Password Spraying**: [[Credential Stuffing]] uses known username/password pairs from data breaches (many passwords, targeted accounts). Password spraying uses one or few passwords against many accounts. Both are distinct from traditional brute force, which exhaustively tries many passwords against one account.

- **Legacy Authentication Protocols**: Protocols such as NTLM, Basic Auth, POP3, IMAP, and SMTP AUTH that do not support [[Multi-Factor Authentication (MFA)]]. These represent a critical weakness in organizations that have deployed MFA for primary login but left legacy protocol endpoints exposed — attackers spray specifically against these bypass routes.

- **Password Observation Window**: The time period over which the lockout counter is evaluated (e.g., "5 failures within 30 minutes"). Spraying at one attempt per account per 35 minutes defeats a 30-minute observation window even if the threshold is only 2.

- **Horizontal vs. Vertical Attack**: Brute force is a *vertical* attack (many passwords, one account). Password spraying is a *horizontal* attack (one password, many accounts). This distinction is fundamental to understanding why standard lockout controls fail against spraying.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Password spraying falls under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations**, specifically under attack types and [[Indicator of Compromise]] recognition.

**Likely Question Patterns**:
- *"A security analyst notices that 500 user accounts each have exactly one failed login attempt in the past hour. What type of attack is most likely occurring?"* → Password Spraying (the horizontal pattern is the giveaway)
- *"Which attack technique is specifically designed to avoid account lockout?"* → Password Spraying
- *"What control would BEST detect a password spraying attack that traditional lockout policies miss?"* → Behavioral analytics / SIEM alerting on distributed low-frequency failures, or [[Multi-Factor Authentication]]

**Common Gotchas**:
- Do not confuse password spraying with brute force — the exam will test whether you understand the lockout-evasion mechanism
- Do not confuse with credential stuffing — stuffing uses *known leaked pairs*, spraying uses *common passwords* against *enumerated accounts*
- MFA is listed as the most effective mitigation; understand that it doesn't prevent the spray attempt but prevents successful exploitation of a cracked credential
- The exam may present password spraying as an indicator: *many accounts, few failures each* is the diagnostic pattern

**Memorization Tip**: "Spray wide, stay low" — one password, many accounts, below lockout threshold.

---

## Security Implications

**Affected Authentication Surfaces**:
Password spraying threatens any service performing username/password authentication without rate-limiting or MFA. The highest-risk exposures in enterprise environments are:
- Exchange Web Services (EWS) and OWA — legacy email access
- ADFS federation endpoints
- VPN concentrators accepting RADIUS/LDAP authentication
- Azure AD with legacy auth enabled

**Real-World Incidents**:
- **SolarWinds / UNC2452 (2020)**: CISA Alert AA21-008A documented that Cozy Bear (APT29) used password spraying as an initial access vector before pivoting to the SolarWinds supply chain compromise. The group targeted Microsoft 365 environments and successfully bypassed perimeter controls.
- **APT33 Holmium Campaign (2018)**: Iranian threat actors conducted sustained password spraying against aviation, petrochemical, and defense organizations. Microsoft's MSTIC team documented the campaign; attackers targeted OWA and then used valid credentials to register malicious OAuth applications.
- **Citrix Bleed / SolarWinds SUNBURST supplementary attacks**: Multiple threat actors in the same period were documented using spraying against RDP and OWA as opportunistic initial access.
- **CISA Advisory AA22-074A**: Details Russian state-sponsored actors targeting critical infrastructure operators specifically via password spraying against VPN and remote access portals, particularly during the initial period of the Ukraine conflict.

**Detection Indicators**:
- Multiple accounts each with `badPwdCount = 1` or `2` within a short window
- Authentication failures originating from a single external IP or ASN
- Failures against accounts that have never previously failed authentication
- Successful logins from unusual geographies or times immediately following a spray window
- Windows Event ID **4625** (failed logon, Type 3 network logon) in high volume with varied target accounts
- Windows Event ID **4771** (Kerberos pre-authentication failure) — maps to Kerbrute activity
- Azure AD Sign-in logs showing `ErrorCode: 50126` (invalid credentials) across many accounts

---

## Defensive Measures

**1. Multi-Factor Authentication (Priority One)**
MFA is the single most effective control. Even when a spray successfully identifies a valid credential, MFA prevents exploitation. Enforce MFA for:
- All remote access (VPN, RDP, SSH)
- All cloud services (M365, AWS Console, Azure Portal)
- All privileged accounts without exception

**2. Disable Legacy Authentication Protocols**
In Microsoft 365/Azure AD, block Basic Auth, NTLM, POP3, IMAP, and SMTP AUTH via Conditional Access policies. These protocols bypass MFA and are primary spray targets.

```powershell
# Azure AD Conditional Access: Block legacy auth via PowerShell (MS Graph)
# Create a policy blocking legacy authentication clients
New-MgIdentityConditionalAccessPolicy -BodyParameter @{
    displayName = "Block Legacy Authentication"
    state = "enabled"
    conditions = @{
        clientAppTypes = @("exchangeActiveSync", "other")
    }
    grantControls = @{
        operator = "OR"
        builtInControls = @("block")
    }
}
```

**3. Fine-Grained Password Policies (FGPP)**
Use Active Directory Fine-Grained Password Policies to enforce stricter lockout on privileged accounts while maintaining usability for standard users.

```powershell
# Create FGPP for service accounts — stricter lockout
New-ADFineGrainedPasswordPolicy -Name "ServiceAccountPolicy" `
    -Precedence 10 `
    -LockoutThreshold 3 `
    -LockoutObservationWindow "00:30:00" `
    -LockoutDuration "01:00:00" `
    -PasswordHistoryCount 24 `
    -MinPasswordLength 16
```

**4. SIEM Detection Rules**
Build detection logic that looks for the *aggregate* pattern, not per-account thresholds:

```spl
# Splunk SPL: Detect password spraying by counting unique accounts with failures
index=windows EventCode=4625
| bucket _time span=30m
| stats dc(TargetUserName) as unique_accounts, count as total_failures by _time, IpAddress
| where unique_accounts > 20 AND total_failures < (unique_accounts * 3)
| table _time, IpAddress, unique_accounts, total_failures
```

**5. Entra ID / Azure AD Smart Lockout Tuning**
Set Smart Lockout threshold low (default is 10; reduce to 3–5) and ensure lockout duration is sufficiently long:
- Navigate to **Entra ID → Security → Authentication methods → Password protection**
- Set "Lockout threshold" to 5
- Set "Lockout duration in seconds" to 120+

**6. Honey Accounts**
Create disabled or monitored accounts with realistic names (e.g., `j.smith.admin`) that no legitimate user will authenticate as. Any authentication attempt against these accounts is a high-confidence spray indicator.

**7. Network-Level Controls**
- Rate-limit authentication endpoints at the WAF/load balancer layer (max N requests per IP per minute)
- Geo-block authentication endpoints to countries where no employees reside
- Require VPN + internal network for LDAP/Kerberos authentication

**8. Password Blocklist**
Implement a custom banned password list in Azure AD Password Protection or via a third-party PAM tool. Include:
- Company name and variations
- Current and prior year combinations
- Seasonal words