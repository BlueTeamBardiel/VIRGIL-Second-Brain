---
domain: "Identity and Access Management"
tags: [access-control, authentication, authorization, tokens, windows-security, privilege-escalation]
---
# Access Token

An **access token** is a security object created by the operating system or an authentication service that encapsulates the **security context** of a user, process, or service, defining what resources and operations that principal is permitted to access. In Windows environments, access tokens are the primary mechanism by which the [[Security Reference Monitor]] enforces [[Discretionary Access Control (DAC)]]. In web and API contexts, tokens such as [[OAuth 2.0]] bearer tokens serve a similar purpose — carrying **identity and permission claims** across stateless HTTP transactions.

---

## Overview

Access tokens exist because modern operating systems and distributed applications require a way to associate an executing process or network request with a specific identity and its corresponding privileges — without re-authenticating on every operation. Rather than querying a credential store repeatedly, the system issues a token at logon or authentication time and attaches it to subsequent operations as proof of identity and authorization.

In **Windows**, every process and thread runs under a security context represented by an access token. When a user logs in, the Local Security Authority Subsystem Service ([[LSASS]]) authenticates the credentials and constructs a token containing the user's Security Identifier ([[SID]]), group SIDs, privileges (such as `SeDebugPrivilege` or `SeImpersonatePrivilege`), and integrity level. This token is attached to the initial process (typically `explorer.exe`) and inherited by child processes. When a process attempts to open a kernel object — a file, registry key, or named pipe — the Windows kernel's [[Security Reference Monitor]] compares the token's SIDs against the object's [[Access Control List (ACL)]] to make an allow/deny decision.

In **web and API contexts**, the OAuth 2.0 framework popularized the use of short-lived bearer tokens. An authorization server issues a token (often a [[JSON Web Token (JWT)]]) after the user authenticates, and the client presents this token in the `Authorization: Bearer <token>` HTTP header on subsequent API calls. The resource server validates the token — checking its signature, expiry, issuer, and scope claims — without needing to contact the authorization server again, enabling stateless, scalable authorization.

**Cloud platforms** (AWS, Azure, GCP) use tokens extensively. AWS Security Token Service (STS) issues temporary credentials (access key ID, secret access key, and session token) for assumed IAM roles. Azure uses OAuth 2.0 access tokens issued by Azure Active Directory (Microsoft Entra ID) for all resource manager and Microsoft Graph API calls. These temporary tokens reduce the attack surface compared to long-lived static credentials.

The concept of token-based authorization is foundational to understanding both host-based privilege escalation (Windows token manipulation) and web/API security weaknesses (token theft, replay, and forgery), making it one of the most cross-cutting concepts in cybersecurity.

---

## How It Works

### Windows Access Token Lifecycle

#### 1. Logon and Token Creation
When a user authenticates interactively or over the network, LSASS performs credential validation (against the local SAM database or a domain [[Kerberos]] / [[NTLM]] authentication). On success, LSASS calls the kernel to create an access token object. The token is populated with:

- **User SID** — e.g., `S-1-5-21-<domain>-1001`
- **Group SIDs** — all groups the user belongs to, including well-known groups like `Authenticated Users (S-1-5-11)`
- **Privilege list** — specific rights like `SeShutdownPrivilege`, `SeLoadDriverPrivilege`
- **Integrity Level** — Low, Medium, High, or System (introduced in Vista for [[Mandatory Integrity Control]])
- **Logon Session ID** — ties the token to a specific logon session in LSASS
- **Token type** — Primary or Impersonation
- **Impersonation level** — Anonymous, Identification, Impersonation, or Delegation

#### 2. Token Attachment to Processes
The token handle is attached to the new process. Child processes inherit a copy of the parent's primary token. You can inspect a process's token with:

```powershell
# List token privileges for the current process
whoami /priv

# View full token information
whoami /all

# Using PowerShell to inspect a specific process token
$proc = Get-Process -Name "notepad"
$handle = $proc.Handle
```

```cmd
:: Check token groups
whoami /groups

:: Check current logon session
query session
```

#### 3. Token Types

| Type | Description |
|------|-------------|
| **Primary Token** | Assigned to a process; represents the process's security context |
| **Impersonation Token** | Allows a thread to temporarily act as a different security context |

Impersonation levels control how far the impersonation can propagate:

```
Anonymous       → Server cannot identify client
Identification  → Server can identify but cannot impersonate
Impersonation   → Server can impersonate locally
Delegation      → Server can impersonate across the network (Kerberos constrained/unconstrained delegation)
```

#### 4. Access Check Mechanism
When a process calls `OpenFile()`, `RegOpenKey()`, or similar, the kernel:

1. Retrieves the thread's effective token (impersonation if set, otherwise process primary token)
2. Extracts the SID list from the token
3. Reads the DACL from the target object's security descriptor
4. Iterates ACEs (Access Control Entries) in order — Deny ACEs first, then Allow ACEs
5. Returns `ACCESS_GRANTED` or `ACCESS_DENIED`

```c
// Conceptual pseudocode of an access check
BOOL AccessCheck(
    PSECURITY_DESCRIPTOR pSD,   // Object's security descriptor
    HANDLE ClientToken,          // Caller's access token
    DWORD DesiredAccess,         // Requested rights
    ...
);
```

#### 5. UAC and Token Splitting
With [[User Account Control (UAC)]], admin users receive **two tokens** at logon:
- A **filtered (standard user) token** used by default
- An **elevated token** activated when the user approves a UAC prompt

```powershell
# Check if current shell is elevated
([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
```

#### 6. OAuth 2.0 / JWT Token Flow

```
[User] → [Client App] → Authorization Server
                              ↓ (issues JWT)
[Client App] → Resource API: "Authorization: Bearer eyJhbGci..."
                              ↓
                    Validate signature, expiry, scope
                              ↓
                    Return resource or 401 Unauthorized
```

A decoded JWT access token payload:
```json
{
  "iss": "https://auth.example.com",
  "sub": "user-12345",
  "aud": "api.example.com",
  "exp": 1717200000,
  "iat": 1717196400,
  "scope": "read:data write:data",
  "roles": ["analyst"]
}
```

---

## Key Concepts

- **Primary Token**: The default security token attached to a process, created at logon or process creation, defining the process's identity and privileges for all kernel-level access checks.
- **Impersonation Token**: A token a thread borrows temporarily to act as a different user or service — critical for client/server scenarios where a server process must access resources on behalf of a connected client.
- **Privilege**: A named right within a token (e.g., `SeDebugPrivilege`) that permits system-level actions beyond what DACL checks control — privileges must be explicitly *enabled* before use even if present in the token.
- **Integrity Level (IL)**: A Mandatory Integrity Control label (Low/Medium/High/System) embedded in the token; the [[Security Reference Monitor]] blocks write-up violations — a Medium IL process cannot write to a High IL object regardless of DACL.
- **Token Theft / Impersonation Attack**: An attacker with sufficient privileges steals or duplicates a higher-privileged token (e.g., SYSTEM) and assigns it to their process via `DuplicateTokenEx()` + `ImpersonateLoggedOnUser()` — a core technique in Windows privilege escalation.
- **Bearer Token**: In OAuth/API contexts, any party *bearing* (presenting) the token is granted access — there is no cryptographic binding to the holder's identity, making confidentiality of the token critical.
- **Token Expiry and Refresh**: Short-lived access tokens (typically 1–60 minutes) limit the window of exploitation; a separate longer-lived [[Refresh Token]] is used to obtain new access tokens without re-authentication.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping**: This topic spans Domain 1 (General Security Concepts — authentication/authorization), Domain 2 (Threats/Vulnerabilities — privilege escalation), and Domain 4 (Identity and Access Management).

**Common Question Patterns:**

- Questions distinguishing **authentication** (proving identity) from **authorization** (what the token permits) — access tokens are an *authorization* artifact, not an authentication mechanism per se.
- Scenarios involving **OAuth 2.0** token types: access token (short-lived, resource access), refresh token (long-lived, get new access tokens), ID token (OpenID Connect, contains identity claims) — know which is which.
- **Privilege escalation** questions may describe token impersonation without naming it explicitly — watch for phrases like "a low-privileged process gaining SYSTEM capabilities."
- **UAC bypass** questions: understand that UAC token-splitting is a *Windows security feature*, and that bypassing it to obtain the elevated token is an attack technique.
- The difference between **impersonation levels** — a common distractor is confusing *Identification* (server knows who you are but can't act as you) with *Impersonation* (server can act as you locally).

**Gotchas:**
- Do not confuse access tokens with **session tokens** (HTTP cookies) or **TOTP tokens** (MFA) — the exam may present all three in the same question.
- JWT access tokens are **not encrypted by default** (only signed) — the payload is Base64-encoded and readable without the key. Sensitive data should not be stored in JWT claims unless the token is also encrypted (JWE).
- In Windows, having a privilege *listed* in a token does not mean it is *active* — `SeDebugPrivilege` must be enabled via `AdjustTokenPrivileges()`.

---

## Security Implications

### Windows Token Abuse

**Token Impersonation / Theft** is a primary post-exploitation technique, documented under MITRE ATT&CK T1134 (Access Token Manipulation). Tools like [[Mimikatz]], [[Cobalt Strike]], and [[Metasploit]] implement token stealing:

```powershell
# Metasploit incognito module - list available tokens
use incognito
list_tokens -u

# Impersonate a SYSTEM token
impersonate_token "NT AUTHORITY\\SYSTEM"
```

**Named Pipe Impersonation**: An attacker creates a named pipe and tricks a privileged service into connecting to it. When the service connects, the attacker calls `ImpersonateNamedPipeClient()` to steal its token. This is the technique behind potato-family exploits ([[JuicyPotato]], [[PrintSpoofer]], [[RoguePotato]]).

**PrintSpoofer** abuses `SeImpersonatePrivilege` (present on IIS app pools, SQL Server service accounts, etc.) — CVE-2020-0796 and related spooler vulnerabilities demonstrated how a LOW or NETWORK SERVICE account with this privilege could escalate to SYSTEM.

**Silver Ticket / Golden Ticket** attacks in [[Kerberos]] environments involve forging Kerberos service tickets or TGTs, which Windows translates into access tokens — the token ends up with incorrect group memberships granting unauthorized access.

### OAuth/JWT Token Attacks

- **Token Replay**: A stolen bearer token is replayed from an attacker-controlled system — particularly dangerous on networks without TLS or when tokens are logged.
- **JWT Algorithm Confusion (CVE pattern)**: Servers that accept `"alg": "none"` or can be confused from RS256 to HS256 (using the public key as the HMAC secret) allow token forgery — [[PortSwigger Web Security Academy]] documents several such CVEs.
- **JWT Secret Brute-Force**: Weak HMAC-SHA256 secrets can be brute-forced offline using tools like `hashcat` or `jwt-cracker` once an attacker obtains a valid token.
- **Refresh Token Abuse**: Long-lived refresh tokens stored insecurely (localStorage, unencrypted databases) enable persistent unauthorized access even after access token expiry.

```bash
# Brute-force JWT HMAC secret with hashcat
hashcat -a 0 -m 16500 captured.jwt /usr/share/wordlists/rockyou.txt
```

---

## Defensive Measures

### Windows Hardening

```powershell
# Audit token privilege use via Group Policy
# Computer Configuration → Windows Settings → Security Settings →
# Advanced Audit Policy → Privilege Use → Audit Sensitive Privilege Use

# Restrict SeImpersonatePrivilege to only necessary service accounts
# via GPO: Computer Config → Windows Settings → Security Settings →
# Local Policies → User Rights Assignment → Impersonate a client after authentication

# Monitor for token duplication (Event ID 4673, 4674, 4688)
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4673} | Select-Object TimeCreated, Message
```

- **Enforce Credential Guard**: Protects LSASS and token-related secrets from extraction using virtualization-based security.
- **Enable Protected Process Light (PPL) for LSASS**: Prevents token theft tools from directly reading LSASS memory.
- **Principle of Least Privilege**: Revoke `SeImpersonatePrivilege`, `SeAssignPrimaryTokenPrivilege`, and `SeDebugPrivilege` from all accounts that do not require them.
- **Application Whitelisting**: Prevents execution of token manipulation tools like Mimikatz via [[AppLocker]] or Windows Defender Application Control (WDAC).

### OAuth/JWT Hardening

```python
# Python: Proper JWT validation (using PyJWT library)
import jwt

def validate_token(token, public_key):
    try:
        payload = jwt.decode(
            token,
            public_key,
            algorithms=["RS256"],   # Explicitly specify algorithm - never allow "none"
            audience="api.example.com",
            issuer="https://auth.example.com"
        )
        return payload
    except jwt.ExpiredSignatureError:
        raise Exception("Token expired")
    except jwt.InvalidTokenError as e:
        raise Exception(f"Invalid token: {e}")
```

- **Short Expiry**: Set access token TTL to 5–15 minutes for sensitive APIs; use refresh token rotation.
- **Token Binding**: Bind tokens to client TLS certificates (RFC 8473) or DPoP (Demonstrating Proof of Possession — RFC 9449) to prevent bearer token replay.
- **Revocation**: Implement token revocation lists or use short-lived tokens + opaque tokens checked against a central store.
- **Secure Storage**: Store tokens in `HttpOnly`, `Secure`, `SameSite=Strict` cookies rather than `localStorage` to mitigate XSS-based token theft.
- **Audit Logging**: Log all token issuance, validation failures, and suspicious refresh patterns in a [[SIEM]].

---

## Lab / Hands-On

### Lab 1: Inspect Windows Access Tokens

```powershell
# Step 1: View your current token details
whoami /all

# Step 2: Open Process Hacker (free tool) or use PowerShell to list token privileges
# of a running process
$proc = Get-Process lsass -ErrorAction SilentlyContinue
if ($proc) { Write-Host "LSASS PID: $($proc.Id)" }

# Step 3: Use Sysinternals AccessChk to check effective token access on a resource
accesschk.exe -a * "C:\Windows\System32\config\SAM"

# Step 4: Simulate privilege check
[System.Security.Principal.