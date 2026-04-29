# Windows Event IDs — The 20 Every Security Analyst Needs
> If you can't read Windows logs, you can't do incident response.

Windows Event Log is the primary audit trail for every Windows environment. Every logon, privilege use, account change, and process execution can leave a trace — if auditing is enabled and you know where to look. This note covers the 20 event IDs that appear in 90% of real investigations, what each means, and what malicious activity looks like in the log.

**Where to find them:** Event Viewer → Windows Logs → Security. Or better: ship them to [[Splunk]], [[Wazuh]], or Elastic via a log forwarder (Winlogbeat, NXLog, Wazuh agent).

**Prerequisite:** Most of these require Advanced Audit Policy to be enabled via GPO:
`Computer Configuration → Windows Settings → Security Settings → Advanced Audit Policy Configuration`

---

## Category: Account & Authentication Events

### 4624 — Successful Logon
**The single most important event ID.** Every successful authentication generates this.

**Key fields:**
- `Logon Type` — how they logged on (see table below)
- `Account Name` — who logged on
- `Workstation Name` / `Source Network Address` — from where
- `Logon ID` — correlates with 4634 (logoff) and 4648 (explicit creds)

**Logon Type values:**
| Type | Meaning | Notes |
|------|---------|-------|
| 2 | Interactive | Physical keyboard / console |
| 3 | Network | SMB, net use, file shares |
| 4 | Batch | Scheduled task |
| 5 | Service | Service account logon |
| 7 | Unlock | Workstation unlock |
| 10 | Remote Interactive | RDP |
| 11 | Cached Interactive | Offline domain logon |

**Malicious patterns:**
- Type 3 (network) logons from a workstation to other workstations → lateral movement
- Type 10 (RDP) from external IPs → initial access or lateral movement
- Type 3 logons under a service account → credential theft/reuse
- Pass-the-hash signature: Type 3 logon + `NtLmSsp` authentication + no corresponding 4648 → PTH attack

```splunk
index=windows EventCode=4624 Logon_Type=3
| stats count by Account_Name, Workstation_Name, Source_Network_Address
| sort -count
```

---

### 4625 — Failed Logon
Failed authentication attempt. The #1 alert for brute force and credential stuffing.

**Key fields:** Same as 4624 plus `Failure Reason` and `Sub Status` (0xC0000064 = unknown user, 0xC000006A = wrong password, 0xC0000234 = account locked out).

**Malicious patterns:**
- Same account, many failures, short time window → brute force
- Many accounts, sequential failures → password spray (one password tried against many accounts)
- Failures followed by success → successful brute force

```splunk
index=windows EventCode=4625
| bucket _time span=1h
| stats count by Account_Name, _time
| where count > 10
| sort -count
```

```splunk
/* Password spray: many accounts, few attempts each */
index=windows EventCode=4625
| stats dc(Account_Name) as unique_accounts, count by Source_Network_Address
| where unique_accounts > 10
```

---

### 4634 / 4647 — Logoff
`4634` = network logoff (automatic). `4647` = user-initiated logoff. Correlate with 4624 using `Logon ID` to calculate session duration.

---

### 4648 — Logon Using Explicit Credentials
Generated when a process uses `RunAs` or explicitly passes credentials (e.g., `net use`, `psexec`, WMI with alternate creds).

**Malicious pattern:** 4648 events on a workstation where a user account authenticates to multiple other systems in rapid succession → lateral movement, pass-the-hash, or compromised credential use.

```splunk
index=windows EventCode=4648
| stats count by Account_Name, Target_Server_Name
| sort -count
```

---

### 4672 — Special Privileges Assigned to New Logon
Fires when an account with sensitive privileges (SeDebugPrivilege, SeTakeOwnershipPrivilege, etc.) logs on. Always fires for domain admin logons.

**Why it matters:** Attackers often seek accounts with SeDebugPrivilege to dump LSASS (credential theft). Seeing 4672 for unexpected accounts = privilege escalation.

---

### 4720 — A User Account Was Created
New account created. In environments where account creation goes through HR/ticketing, unexpected 4720 events = attacker persistence or insider threat.

```splunk
index=windows EventCode=4720
| table _time, Account_Name, Subject_Account_Name
| sort -_time
```

---

### 4722 — A User Account Was Enabled
Account was re-enabled. Attackers sometimes enable disabled accounts for persistence.

---

### 4724 — An Attempt Was Made to Reset an Account's Password
Password reset attempt. If the reset is on a privileged account and the actor isn't the help desk → investigate.

---

### 4728 / 4732 / 4756 — Member Added to Security Group
- `4728` = added to global security group
- `4732` = added to local security group
- `4756` = added to universal security group

**Most important for:** detecting privilege escalation via adding accounts to Domain Admins, Administrators, Remote Desktop Users.

```splunk
index=windows (EventCode=4728 OR EventCode=4732 OR EventCode=4756)
| eval group=coalesce(Group_Name, Target_Group_Name)
| where match(group, "(?i)admin|domain admin|enterprise admin")
| table _time, Account_Name, Member_Security_ID, group
```

---

### 4768 — Kerberos Authentication Ticket (TGT) Requested
A user or computer requested a Kerberos TGT. Normal volume is one per logon session.

**Malicious pattern (AS-REP Roasting):** 4768 events for accounts that don't require Kerberos preauthentication → the TGT hash can be cracked offline.

### 4769 — Kerberos Service Ticket Requested
Requested a service ticket (TGS) to access a specific service.

**Malicious pattern (Kerberoasting):** High volume of 4769 events for a single user, requesting tickets for many service accounts → Kerberoasting. The service ticket hash is crackable offline.

```splunk
index=windows EventCode=4769
| stats count dc(Service_Name) as unique_services by Account_Name
| where unique_services > 20
```

### 4771 — Kerberos Pre-authentication Failed
Failed Kerberos authentication. Similar value to 4625 but for Kerberos specifically.

---

## Category: Process Events

### 4688 — A New Process Has Been Created ⚠️ Must Enable
**Not enabled by default.** Enable via GPO:
`Advanced Audit Policy → Detailed Tracking → Audit Process Creation → Success`

Also enable **command line logging**:
`Administrative Templates → System → Audit Process Creation → Include command line in process creation events`

Without the command line flag, 4688 shows you a process was created but not the arguments — making it nearly useless for detection.

**Malicious patterns:**
- `cmd.exe` or `powershell.exe` spawned by `outlook.exe`, `winword.exe`, `excel.exe` → malicious macro
- `powershell.exe` with `-enc`, `-NoP`, `-W Hidden` → obfuscated execution
- `net.exe`, `whoami.exe`, `ipconfig.exe` spawned by unexpected parents → post-exploitation discovery
- `svchost.exe` spawning unusual children → process injection

```splunk
index=windows EventCode=4688
| eval cmd=lower(Process_Command_Line)
| where match(cmd, "-enc|-nop|-noprofile|-w hidden|downloadstring|iex|invoke-expression")
| table _time, Account_Name, Process_Name, Process_Command_Line
```

---

### 4689 — A Process Has Exited
Rarely used for detection alone. Correlate with 4688 using Process ID to calculate execution duration (very short-lived processes = LOLBin abuse).

---

## Category: Policy Changes

### 4719 — System Audit Policy Was Changed
The audit policy itself was modified. If you see this and didn't make the change → attacker is covering tracks.

### 4739 — Domain Policy Was Changed
Domain-level policy change. Unexpected changes outside maintenance windows = investigate.

---

## Category: Object Access

### 4663 — An Attempt Was Made to Access an Object
Access to files, registry keys, or other objects. **Very noisy** — only enable on specific sensitive paths (e.g., `C:\Windows\System32\lsass.exe`, `NTDS.dit`).

**Critical use:** Enable on `lsass.exe` to detect credential dumping attempts.

---

### 4698 — A Scheduled Task Was Created
New scheduled task registered. Common persistence mechanism.

```splunk
index=windows EventCode=4698
| eval task_xml=Task_Content
| table _time, Account_Name, Task_Name, task_xml
| sort -_time
```

**What to look for:** Tasks pointing to `%TEMP%`, `%APPDATA%`, unusual directories, or tasks with obfuscated commands.

---

## Category: PowerShell Events

### 4103 — PowerShell Module Logging
Logs pipeline execution details — every cmdlet called, every parameter. Enabled via GPO: `Windows PowerShell → Turn on Module Logging`.

Useful but verbose. **4104 is more important.**

---

### 4104 — PowerShell Script Block Logging ⭐ Most Important PS Event
Logs the **full content of every script block executed**, including dynamically generated and decoded code. Attackers cannot easily bypass this once enabled.

**What it catches:**
- Encoded commands decoded at runtime
- Downloaded payloads executed in memory
- Obfuscated scripts after deobfuscation
- Fileless malware delivered via PS

Windows flags script blocks containing suspicious patterns with `WARNING` level automatically.

```splunk
index=windows EventCode=4104
| where match(ScriptBlockText, "(?i)downloadstring|iex|invoke-expression|frombase64|-enc|amsibypass")
| table _time, Computer, UserID, ScriptBlockText
| sort -_time
```

GPO path: `Computer Configuration → Administrative Templates → Windows Components → Windows PowerShell → Turn on PowerShell Script Block Logging`

---

## Attack Pattern Reference

### Pass-the-Hash Signature
```
4624  Logon_Type=3
      AuthPackage=NtLmSsp
      KeyLength=0
      No corresponding 4648 before it
      Logon from workstation to workstation (not DC)
```

### Lateral Movement Signature
```
Source machine: 4648 (explicit credentials used)
Target machine: 4624 Type=3 (network logon) from source IP
                4624 Type=10 (RDP) if desktop access
```

### Kerberoasting Signature
```
4769: Single account requests TGS tickets for 10+ service accounts
      within a short time window
      Encryption type = 0x17 (RC4) — weak, crackable
```

### Persistence via Scheduled Task
```
4698: Scheduled task created by non-admin account
      OR task pointing to temp/appdata dir
      OR task with encoded command
```

---

## Quick Reference Table

| Event ID | Category | What Happened | Priority |
|----------|----------|---------------|----------|
| 4624 | Auth | Successful logon | ⭐ Critical |
| 4625 | Auth | Failed logon | ⭐ Critical |
| 4648 | Auth | Explicit credential use | High |
| 4672 | Auth | Privileged account logon | High |
| 4688 | Process | New process created | ⭐ Critical (if cmd line enabled) |
| 4698 | Object | Scheduled task created | High |
| 4104 | PowerShell | Script block executed | ⭐ Critical |
| 4728/32/56 | Account | Added to security group | High |
| 4720 | Account | Account created | Medium |
| 4769 | Kerberos | Service ticket requested | Medium |
| 4719 | Policy | Audit policy changed | High |

---

## Tags
`[[Windows]]` `[[Windows Event Logs]]` `[[Splunk]]` `[[Incident Response]]` `[[CySA+]]` `[[Active Directory]]` `[[PowerShell]]` `[[Lateral Movement]]` `[[Pass-the-Hash]]` `[[Kerberoasting]]`