# Identity and Access Management — The New Perimeter
> The perimeter isn't the firewall anymore. It's the identity. Every access decision starts with "who are you?"

Zero trust, cloud adoption, and remote work killed the network perimeter. Identity is all that's left.

---

## Core IAM Concepts

### Authentication vs Authorization
**Authentication (AuthN):** Proving you are who you claim to be — *identity verification*
**Authorization (AuthZ):** Determining what you're allowed to do — *access control*

Common confusion: MFA is authentication (are you really Bob?). RBAC is authorization (what can Bob access?).

### Principle of Least Privilege (PoLP)
Give users *exactly* what they need to do their job — no more.
- Service accounts should not be Domain Admins
- Help desk should not have local admin on workstations (usually)
- Admin accounts should not be used for day-to-day browsing
- [[LAPS]] for local admin — unique password per machine, no shared admin password

### Separation of Duties (SoD)
No single person should have enough access to commit fraud and cover it up.
- Finance: person who creates vendor ≠ person who approves payments
- IT: person who deploys code ≠ person who approves deployment
- Security: person who writes detection rules ≠ person who can delete alerts

---

## Authentication Factors

| Factor | Type | Examples | Notes |
|---|---|---|---|
| **Something you know** | Knowledge | Password, PIN, security question | Weakest — can be stolen/guessed |
| **Something you have** | Possession | TOTP app, hardware key, smart card | Stolen if physical device is taken |
| **Something you are** | Inherence | Fingerprint, face, iris, voice | Can't be stolen; can be spoofed with effort |
| **Somewhere you are** | Location | GPS, network location, IP geofence | Weak alone — VPNs bypass it |
| **Something you do** | Behavioral | Typing patterns, mouse movement | Continuous authentication use case |

**MFA Factor Strength (worst to best):**
1. SMS OTP — weakest, SIM swapping bypasses it entirely
2. Email OTP — only as secure as the email account
3. TOTP (Google Authenticator, Authy) — solid, phishable with real-time relay attacks
4. Push notification (Duo, Microsoft Authenticator) — convenient, vulnerable to MFA fatigue attacks
5. FIDO2/WebAuthn hardware key (YubiKey) — strongest, phishing-resistant because key is bound to origin

**MFA Fatigue Attack:** Spam push notifications until the user approves to make it stop. Mitigation: require number matching, use FIDO2.

---

## Single Sign-On (SSO)

**What it is:** One authentication event grants access to multiple applications.
**User benefit:** One password, one MFA prompt, one login.
**Security benefit:** Centralized enforcement of MFA, conditional access, session management.
**Risk:** Compromise the SSO = compromise everything connected to it.

### SAML 2.0 Flow (Enterprise SSO)
1. User tries to access application (Service Provider / SP)
2. SP redirects to Identity Provider (IdP — Okta, Azure AD, ADFS)
3. IdP authenticates user (username + MFA)
4. IdP issues digitally signed XML SAML assertion
5. Assertion sent back to SP
6. SP validates signature and grants access

### OAuth 2.0 vs OpenID Connect (OIDC)
**OAuth 2.0:** Authorization framework — grants apps limited access to user resources
- "Sign in with Google" giving a third-party app access to your Google Drive
- Issues access tokens (opaque or JWT)

**OpenID Connect (OIDC):** Authentication layer on top of OAuth 2.0
- Adds ID token (contains user identity claims in JWT)
- OAuth says "you can access this resource," OIDC says "this is who the user is"

**Common confusion:** OAuth is authorization. OIDC is authentication. They're often used together.

---

## Kerberos — How Windows AD Authentication Works

Kerberos is the default authentication protocol for [[Active Directory]]. Understanding it is mandatory for CySA+.

### Key Components
- **KDC (Key Distribution Center):** Lives on Domain Controller — issues all tickets
- **TGT (Ticket Granting Ticket):** Proof you're authenticated — used to request service tickets
- **Service Ticket (ST):** Authorization for a specific service (file share, web server, etc.)
- **SPN (Service Principal Name):** Identifier for a service — `MSSQLSvc/server.domain.com:1433`

### Authentication Flow
```
1. Client → KDC: "I'm Alice, give me a TGT" (preauthentication with password hash)
2. KDC → Client: TGT (encrypted with krbtgt hash) + session key
3. Client → KDC: "I have a TGT, give me a ticket for FileServer" 
4. KDC → Client: Service ticket (encrypted with FileServer's account hash)
5. Client → FileServer: Service ticket
6. FileServer: Decrypts with own hash, grants access
```

### Kerberos Attacks
**Pass-the-Ticket:** Steal a valid TGT or service ticket from memory (Mimikatz `sekurlsa::tickets`), use it to authenticate as that user without their password.

**Kerberoasting:** Request service tickets for any SPN (any domain user can do this), then crack them offline. Works because service tickets are encrypted with the service account's password hash.
```
1. Get list of SPNs: Get-ADUser -Filter {ServicePrincipalName -ne "$null"}
2. Request ticket: Request-SPNTicket from PowerView
3. Extract from memory: Invoke-Kerberoast
4. Crack offline: hashcat -m 13100 hash.txt wordlist.txt
```

**Golden Ticket:** If you have the krbtgt hash (from DCSync or domain controller compromise), you can forge TGTs for any user — even non-existent ones — valid for 10 years.
```
# Mimikatz - requires krbtgt hash
kerberos::golden /user:Administrator /domain:corp.local /sid:S-1-5-21-... /krbtgt:<hash> /id:500
```

**Silver Ticket:** If you have a service account hash, forge service tickets for that specific service.

---

## NTLM — The Legacy Authentication You Can't Fully Kill

NTLM (NT LAN Manager) is the fallback authentication when Kerberos isn't available (non-domain systems, IP address connections, some cross-forest scenarios).

**NTLM is weaker than Kerberos because:**
- No mutual authentication (server doesn't prove identity to client)
- Vulnerable to relay attacks
- NTLM hashes are fixed (not time-limited like Kerberos tickets)

### NTLM Relay Attack
1. Attacker triggers NTLM authentication attempt (Responder poisoning, LLMNR/NBT-NS)
2. Capture NTLM challenge-response
3. Relay to another system (e.g., authenticate to file share as victim)
4. Without cracking the hash — just relay it

### Pass-the-Hash
If you have the NTLM hash, you can authenticate without knowing the plaintext password:
```
# Mimikatz
sekurlsa::pth /user:Admin /domain:corp /ntlm:<hash> /run:cmd.exe

# Impacket
python3 psexec.py -hashes :<nthash> domain/user@target
```

**Why it works:** NTLM authentication uses the hash directly — the password is the hash.

**Mitigations:**
- Disable NTLM where possible (GPO: Network Security: LAN Manager authentication level → NTLMv2 only)
- SMB signing — prevents relay attacks
- Credential Guard — protects NTLM hashes in memory

---

## Zero Trust Identity

Traditional approach: strong perimeter → implicit trust inside
Zero trust: verify every request regardless of source

### Conditional Access
Microsoft Azure AD / Entra ID implements this natively:
- **Who:** Is this a known user account?
- **Device:** Is this device managed/compliant (patched, encrypted, AV running)?
- **Location:** Is this a known location or a risk signal (new country, Tor exit node)?
- **App:** What application are they accessing? (different risk for payroll vs wiki)
- **Risk:** Has this account shown anomalous behavior?

Combined → Access: Allow, Require MFA, Block, Force password change

### Privileged Access Management (PAM)
For admin accounts specifically:
- **Just-in-time access:** Admin rights granted for 30-minute windows, auto-expired
- **Session recording:** Every admin action recorded and auditable
- **Password vaulting:** Admin accounts don't have user-memorizable passwords — PAM system generates and rotates
- **Tools:** CyberArk, HashiCorp Vault, BeyondTrust, Azure PIM (free with Entra P2)

---

## Identity Attacks (Detection Focus)

### Credential Stuffing
Using breach data (username:password pairs) to test login across many sites.
- Detection: high volume of failed logins from many IPs, success after failures
- Mitigation: MFA, breached password detection, rate limiting

### Password Spraying
Try one common password (Password1!) against many accounts — avoids lockout.
- Detection: Event ID 4625 (failed logon) distributed across many accounts in short time
- Mitigation: Smart lockout, MFA, strong password requirements

### MFA Fatigue (Push Bombing)
Spam push MFA requests at odd hours until user approves to make it stop.
- Detection: Multiple MFA prompts in short time, approval at unusual hour
- Mitigation: Number matching (user must type code from request), FIDO2

### SIM Swapping
Social engineer mobile carrier to transfer victim's phone number to attacker's SIM → receive SMS MFA codes.
- Targets: High-value accounts, crypto
- Mitigation: Don't use SMS MFA. Use TOTP or hardware key.

---

## Tags
`#iam` `#authentication` `#kerberos` `#active-directory` `#zero-trust` `#mfa`

[[Active Directory]] [[CySA+]] [[MITRE ATT&CK]] [[Windows Event IDs]] [[Wazuh]] [[[YOUR-HOST]]]
