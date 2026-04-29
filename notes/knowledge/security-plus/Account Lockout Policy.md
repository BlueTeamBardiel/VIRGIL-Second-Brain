---
domain: "Identity and Access Management"
tags: [authentication, access-control, password-policy, active-directory, hardening, windows]
---
# Account Lockout Policy

An **Account Lockout Policy** is a security control that automatically disables a user account after a specified number of consecutive failed authentication attempts, preventing [[Brute Force Attack|brute force]] and [[Password Spraying|password spraying]] attacks from succeeding through repeated trial. It is a core component of [[Authentication]] hardening and is governed by settings within operating systems, directory services such as [[Active Directory]], and application-level controls. When correctly configured, lockout policies significantly raise the cost of online credential attacks without an equivalent degradation in legitimate user experience.

---

## Overview

Account lockout policies originated as a direct countermeasure to automated password guessing. Without such a policy, an attacker with network access to an authentication endpoint can submit thousands or millions of password attempts per second, limited only by network throughput and server processing capacity. By setting a threshold—commonly three to ten failed attempts—administrators force attackers to either slow down dramatically or abandon online attacks entirely in favor of offline methods against captured credential hashes.

In Microsoft Windows environments, account lockout is configured through **Group Policy Objects (GPOs)** and applies to both local accounts (via the Local Security Policy) and domain accounts (via the Default Domain Policy or fine-grained password policies). The policy stores lockout metadata in the Security Account Manager (SAM) database for local accounts and in Active Directory domain controllers for domain accounts. Each failed logon increments a **bad password counter** stored in the user object, and when that counter reaches the configured threshold, the account's `lockoutTime` attribute is set to a nonzero value.

Unix/Linux systems implement similar controls through Pluggable Authentication Modules (**PAM**), specifically the `pam_tally2` or `pam_faillock` modules on modern distributions. These modules maintain per-user failure counts in flat files under `/var/run/faillock/` and can lock accounts or insert delays after a configurable number of failures. Web applications and SaaS platforms implement analogous logic at the application layer, sometimes augmented by CAPTCHA challenges or progressive delays rather than hard lockouts.

A critical distinction exists between **hard lockout** (account fully disabled until manual or timed reset) and **soft lockout** (temporary delay or rate-limiting applied). Hard lockouts provide stronger protection but introduce availability risk—an attacker who knows lockout thresholds can intentionally trigger mass lockouts as a **Denial of Service (DoS)** attack against legitimate users, particularly in organizations with predictable username formats. This trade-off is a persistent design challenge in lockout policy configuration.

Modern identity platforms such as Azure Active Directory (now Microsoft Entra ID) implement **smart lockout** algorithms that use machine learning and IP reputation to distinguish legitimate users from attackers, applying differential lockout behavior based on geographic and behavioral signals. These adaptive controls represent an evolution beyond the static threshold model, though traditional on-premises environments still rely predominantly on fixed-threshold policies.

---

## How It Works

### Windows Active Directory — Technical Mechanism

Account lockout in Active Directory involves three configurable values within a GPO under:
`Computer Configuration → Windows Settings → Security Settings → Account Policies → Account Lockout Policy`

| Setting | Description | Recommended Value |
|---|---|---|
| Account Lockout Threshold | Failed attempts before lockout | 5–10 |
| Account Lockout Duration | Minutes account stays locked (0 = admin unlock required) | 15–30 minutes |
| Reset Account Lockout Counter After | Minutes before bad password count resets | 15–30 minutes |

**Step-by-step lockout sequence:**

1. A user (or attacker) submits incorrect credentials to a Windows logon prompt, RDP session, or network authentication endpoint.
2. The authenticating domain controller (DC) increments the `badPwdCount` attribute on the user object and updates `badPasswordTime`.
3. If `badPwdCount` reaches the configured threshold, the DC sets `lockoutTime` to the current UTC time in Windows file time format (100-nanosecond intervals since January 1, 1601).
4. Subsequent authentication attempts return error code `0xC0000234` (STATUS_ACCOUNT_LOCKED_OUT) or the human-readable message: *"Your account has been locked out due to too many failed sign-in attempts."*
5. After `lockoutDuration` minutes, the DC automatically resets `lockoutTime` to 0, re-enabling the account.
6. If `lockoutDuration` is set to 0, an administrator must manually unlock the account.

**Important replication caveat:** In multi-DC environments, bad password counts are NOT replicated between DCs in real time. Each DC maintains its own local copy of `badPwdCount`. The **PDC Emulator FSMO role holder** receives real-time bad password notifications from all other DCs to provide an authoritative lockout decision. This is why the PDC Emulator should always be the first DC contacted during authentication troubleshooting.

### Querying and Managing Lockouts — PowerShell

```powershell
# Check if a specific account is locked out
Get-ADUser -Identity jsmith -Properties LockedOut, BadLogonCount, BadPasswordTime, LockoutTime |
    Select-Object Name, LockedOut, BadLogonCount, BadPasswordTime, LockoutTime

# Find ALL locked accounts in the domain
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName, LockedOut, LastLogonDate

# Unlock a single account
Unlock-ADAccount -Identity jsmith

# Bulk unlock all locked accounts (use with caution)
Search-ADAccount -LockedOut | Unlock-ADAccount

# View fine-grained password policy applied to a user
Get-ADUserResultantPasswordPolicy -Identity jsmith
```

### Identifying Lockout Source — Event Logs

Failed logon attempts generate **Event ID 4625** on the authenticating DC, while lockout events generate **Event ID 4740** on the PDC Emulator. The 4740 event contains the `Caller Computer Name` field, which identifies the machine generating the bad password attempts.

```powershell
# Find lockout events on PDC Emulator
$PDC = (Get-ADDomain).PDCEmulator
Get-WinEvent -ComputerName $PDC -FilterHashtable @{
    LogName = 'Security'
    Id = 4740
    StartTime = (Get-Date).AddHours(-24)
} | Select-Object TimeCreated,
    @{N='LockedAccount';E={$_.Properties[0].Value}},
    @{N='CallerComputer';E={$_.Properties[1].Value}}
```

### Linux — pam_faillock Configuration

On RHEL/CentOS/Rocky Linux 8+ and modern Debian/Ubuntu systems using `pam_faillock`:

```bash
# /etc/security/faillock.conf
deny = 5               # Lock after 5 failures
unlock_time = 900      # Auto-unlock after 900 seconds (15 min)
fail_interval = 900    # Count failures within this window
even_deny_root         # Apply policy to root account too
audit                  # Log to audit subsystem

# Check current failure counts for a user
faillock --user jsmith

# Manually reset/unlock a user
faillock --user jsmith --reset

# PAM configuration snippet (/etc/pam.d/system-auth)
auth        required      pam_faillock.so preauth
auth        sufficient    pam_unix.so nullok
auth        [default=die] pam_faillock.so authfail
auth        sufficient    pam_faillock.so authsucc
```

---

## Key Concepts

- **Lockout Threshold**: The maximum number of consecutive failed authentication attempts permitted before an account is disabled. Set too low (e.g., 1–2), it creates excessive helpdesk burden and DoS exposure; set too high (e.g., 50+), it provides minimal protection. Industry consensus sits at 5–10 attempts.
- **Observation Window (Reset Counter After)**: The rolling time window within which failed attempts are counted. A 15-minute window means five failures spread over two hours would never trigger a lockout, which helps distinguish legitimate typos from attacks while resisting slow-and-low spraying.
- **Lockout Duration**: How long the account remains locked before automatic re-enablement. A duration of `0` requires manual administrator intervention (maximum security, maximum friction). Values of 15–30 minutes balance security with operational practicality.
- **Fine-Grained Password Policy (FGPP)**: Introduced in Windows Server 2008, FGPPs allow different lockout settings to be applied to specific users or security groups via **Password Settings Objects (PSOs)**, overriding the Default Domain Policy. This enables stricter policies for privileged accounts (e.g., domain admins) without impacting all users.
- **Smart Lockout**: An adaptive lockout mechanism (used in Azure AD/Entra ID and some enterprise identity platforms) that applies risk-based logic—considering IP reputation, sign-in frequency, and behavioral baselines—to selectively block suspicious authentication without locking out legitimate users from trusted locations.
- **Caller Computer Name (Event 4740)**: The machine name recorded in lockout events that identifies the source of bad password attempts. Critical for incident response—commonly points to a misconfigured scheduled task, cached credentials on a mobile device, or a mapped network drive with stale credentials.
- **PDC Emulator Dependency**: In AD environments, the PDC Emulator FSMO role holder acts as the authoritative arbiter for lockout decisions, receiving real-time bad password notifications from all other DCs. It is the primary target for lockout auditing and management.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Account lockout falls under **Domain 4.0 — Security Operations**, specifically objective 4.6 (implement and maintain identity and access management) and connects to **Domain 1.0 — General Security Concepts** regarding authentication controls.

**Common Question Patterns:**

- Scenario questions will describe an environment where accounts are being locked out automatically and ask you to identify the cause (brute force vs. password spray vs. DoS). Key differentiator: **brute force** targets one account with many passwords; **password spraying** targets many accounts with one or few passwords—the latter is specifically designed to stay *below* lockout thresholds.
- Questions about the **trade-off** between security and availability: a very low threshold (e.g., 3 attempts) is exploitable as a DoS vector. The exam expects you to recognize this as a genuine vulnerability.
- You may see questions distinguishing **account lockout** (temporary/automatic) from **account disabling** (manual/permanent administrative action).
- Know that setting lockout duration to `0` means **only an administrator can unlock the account** — this is NOT the same as no lockout.

**Gotchas:**

- A lockout threshold of `0` in Windows means **account lockout is disabled entirely** — the account will never lock. Students frequently confuse this with "lock immediately."
- The **Reset Account Lockout Counter After** value must be ≤ the **Account Lockout Duration** value (when duration > 0). Windows enforces this constraint automatically.
- Account lockout does NOT protect against **offline attacks** on captured password hashes — it only applies to online, interactive authentication attempts.
- NIST SP 800-63B (the authoritative U.S. government guidance) recommends rate-limiting and lockout but specifically advises against overly aggressive thresholds that create availability problems.

---

## Security Implications

### Attack Vectors Enabled by Weak or Absent Lockout Policy

**Brute Force and Password Spraying:** Without a lockout policy, tools like `Hydra`, `Medusa`, and `Kerbrute` can test credentials at network speeds. In Active Directory environments, Kerberos pre-authentication failures (Event ID 4771) and NTLM failures (Event ID 4625) accumulate invisibly until credentials are compromised.

```bash
# Example: kerbrute password spray (detection, not exploitation)
kerbrute passwordspray -d corp.local --dc 192.168.1.10 users.txt 'Summer2024!'
```

**Lockout as Denial of Service:** An attacker who enumerates valid usernames (via LDAP null sessions, SMTP VRFY, or Kerberos error code differences) can intentionally trigger lockouts across all user accounts, effectively shutting down organizational authentication. This was observed in several documented attacks against financial institutions and was a key consideration in the redesign of lockout policies following high-profile incidents circa 2010–2015.

**CVE and Incident Context:**
- **CVE-2019-1040** (CredSSP/NLA bypass) demonstrated that pre-authentication lockout controls could be circumvented in certain RDP configurations, allowing unlimited password attempts.
- The **2020 SolarWinds / SUNBURST** campaign highlighted how attackers specifically performed slow, low-volume password spraying (one attempt per account per hour) to remain below typical lockout thresholds across target environments.
- Misconfigured service accounts with lockout policies applied are a common source of **operational incidents** — a service account locked due to a password change that wasn't propagated to all consuming services generates cascading failures.

### Bypass Techniques

- **Password Spraying cadence tuning:** Attackers space attempts across the observation window (e.g., one attempt every 31 minutes against a 30-minute observation window).
- **Distributed source IPs:** Cloud-based attack infrastructure distributes attempts across thousands of IPs, complicating IP-based lockout and making smart lockout less effective.
- **Kerberoasting / AS-REP Roasting:** These techniques extract encrypted ticket material for **offline** cracking, completely bypassing lockout policies since no failed authentication attempts are generated.

---

## Defensive Measures

### Policy Configuration Baselines

**Microsoft/CIS Benchmark Recommended Settings (Windows):**
- Lockout Threshold: **10 or fewer** invalid attempts (CIS recommends 5)
- Lockout Duration: **15 minutes minimum** (set to 0 for high-security environments requiring admin unlock)
- Reset Counter: **15 minutes**

**Privileged Accounts (via FGPP):** Apply stricter PSO settings to Domain Admins, Service Accounts, and other privileged groups:

```powershell
# Create a Fine-Grained Password Policy for privileged users
New-ADFineGrainedPasswordPolicy -Name "PrivilegedAccountsPSO" `
    -Precedence 10 `
    -LockoutThreshold 3 `
    -LockoutDuration "0:30:00" `
    -LockoutObservationWindow "0:30:00" `
    -MinPasswordLength 20 `
    -PasswordHistoryCount 24 `
    -ComplexityEnabled $true `
    -ReversibleEncryptionEnabled $false

# Apply PSO to Domain Admins group
Add-ADFineGrainedPasswordPolicySubject -Identity "PrivilegedAccountsPSO" `
    -Subjects "Domain Admins"
```

### Monitoring and Alerting

- **Alert on Event ID 4740** (account locked out) — create SIEM rules for mass lockout events (>10 accounts locked within 5 minutes indicates active spray attack).
- **Alert on Event ID 4625 with Failure Reason 0xC000006A** (wrong password) — high volumes from a single source IP indicate brute force.
- **Baseline normal lockout rate** — organizations typically see 2–5% of users locked out monthly; spikes above this threshold warrant investigation.
- Deploy **Microsoft Entra ID Protection** or equivalent to gain behavioral analytics on authentication patterns.

### Operational Controls

- **Exclude service accounts from lockout** (apply to dedicated OUs with monitoring instead) — service account lockouts cause outages. Mitigate by using **Managed Service Accounts (MSA)** or **Group Managed Service Accounts (gMSA)** which rotate passwords automatically without manual intervention.
- **Implement MFA** — even if lockout is bypassed or credentials are compromised, [[Multi-Factor Authentication]] prevents account takeover.
- **Deploy a honeypot account** — create a fake, non-functional account with a common username (e.g., `administrator`, `admin`, `helpdesk`) that should never have legitimate logon attempts. Any lockout of this account indicates active enumeration/spraying.

---

## Lab / Hands-On

### Exercise 1: Configure Account Lockout Policy via GPO (Windows Server)

```powershell
# On a Domain Controller — verify current policy
Get-ADDefaultDomainPasswordPolicy | Select-Object LockoutThreshold, LockoutDuration, Lockout