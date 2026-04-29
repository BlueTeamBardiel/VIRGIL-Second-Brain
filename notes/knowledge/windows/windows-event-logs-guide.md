# Windows Event Logs Guide

A comprehensive overview of Windows event logs, their structure, purpose, and use cases for system administrators and security professionals monitoring Windows systems.

## Overview

[[Windows Event Logs]] are a critical component of Windows system monitoring and security auditing. They record system, application, and security events that occur on a Windows machine, providing essential data for troubleshooting, compliance, and threat detection.

## Key Concepts

- **Event Logs**: Centralized repository of system, application, and security events
- **Event Viewer**: Built-in Windows tool for viewing and analyzing event logs
- **Log Types**: System, Application, Security, and custom logs
- **Event IDs**: Unique identifiers for specific event types
- **Audit Policies**: Configuration settings that determine what events are logged

## Use Cases

- Troubleshooting system errors and failures
- Security incident investigation and forensics
- Compliance and regulatory reporting
- Performance monitoring and optimization
- User activity tracking and auditing

## Related Tools & Concepts

- [[Event Viewer]]
- [[Windows Security]]
- [[Audit Logging]]
- [[Malwarebytes]] (security monitoring)

## Tags

#windows #sysadmin #event-logs #monitoring #security #troubleshooting

## What Is It? (Feynman Version)

Imagine a black‑box recorder on an airplane: it notes every command, sensor reading, and event that occurs during a flight so investigators can later reconstruct the sequence of actions. A Windows event log is that black‑box for a computer. It is a file (usually `*.evtx`) that records system, application, and security events in a structured, searchable format.

## Why Does It Exist?

Before event logs, if a Windows service crashed, administrators had no objective record of why. They had to rely on intermittent error messages or guesswork. The problem was that critical failures and malicious activity could go unnoticed, and compliance auditors had no evidence of what happened. Windows event logs solve this by providing an immutable, timestamped ledger of everything the operating system and installed applications report. They also enable attackers to hide their tracks—some malware deletes or tampers with logs to conceal activity, so knowing how to preserve and analyze logs is essential for detection.

## How It Works (Under The Hood)

1. **Event Source Registration** – Applications or system components register a *source* in the registry (e.g., `HKLM\SYSTEM\CurrentControlSet\Services\EventLog\Application\AppSource`).  
2. **Event Emission** – The source calls `EventLog.WriteEntry()` (or the equivalent native API). The call includes a *level* (Error, Warning, Information), an *EventID*, a *category*, and a *message*.  
3. **Event Log Service** – The `eventlog.sys` driver receives the entry, serializes it into the EVTX binary format, and writes it to the appropriate log file (e.g., `C:\Windows\System32\winevt\Logs\Application.evtx`).  
4. **Retention & Rotation** – Each log file has a size and age policy. When exceeded, the service archives the old file (e.g., `Application.evtx.1`) and starts a new file.  
5. **Reading & Filtering** – `Event Viewer` (or PowerShell’s `Get-WinEvent`) opens the EVTX file, parses the binary entries, and presents them in a UI or CLI with filters, queries, and custom views.  
6. **Audit Policies** – For Security logs, the Local Security Policy or Group Policy defines *audit* settings (e.g., logon events, object access). When an audited event occurs, the OS writes it to the Security log, regardless of the source application.

## What Breaks When It Goes Wrong?

- **Log Wiping**: Malware or disgruntled insiders delete or truncate event logs, erasing evidence of an intrusion.  
- **Misconfigured Audit Policy**: If audit settings are too lax, critical events (e.g., failed logons, privileged account changes) never get recorded.  
- **Log Overrun**: If retention policies are too short or logs disabled, the system can silently discard recent events, masking outages.  
- **Hardware Failure**: Corrupted log files can corrupt the entire EVTX database, causing Event Viewer to crash and leaving admins without a recovery path.  
Human cost: administrators may not see a system failure until a user reports it; forensic analysts may find no record of a breach; regulatory audits may fail, resulting in fines or reputational damage.

## Lab Relevance

### Exercise 1 – Generating Custom Events

```powershell
# Create a new custom log source
New-EventLog -LogName Application -Source TestSource

# Write a test event
Write-EventLog -LogName Application -Source TestSource -EventID 1000 -Message "Test event: user logged in" -Category 0 -EntryType Information
```

Verify with:

```powershell
Get-WinEvent -LogName Application -FilterXPath "*[EventData[@Name='EventID']='1000']" | Format-List
```

### Exercise 2 – Configuring Audit Policies

1. Open **Local Security Policy** (`secpol.msc`).
2. Navigate to **Local Policies → Audit Policy**.
3. Enable **Audit logon events** (Success & Failure).
4. Trigger a logon event and verify in the Security log:

```powershell
Get-WinEvent -LogName Security | Where-Object {$_.Id -eq 4624}
```

### Exercise 3 – Simulating Log Wipe

```powershell
# Delete a log file (requires admin)
Remove-Item -Path "C:\Windows\System32\winevt\Logs\Application.evtx"

# Or clear via PowerShell
Clear-EventLog -LogName Application
```

Observe that Event Viewer reports the log as empty; forensic tools will show missing data.

### Exercise 4 – Log Rotation Observation

1. Configure a small retention size in **Event Viewer** → *Properties* → *Recovery* → *Maximum Log Size* (e.g., 1 MB).
2. Generate many events until the log rotates.
3. Examine the archived file (`Application.evtx.1`).

---

_Ingested: 2026-04-15 20:21 | Source: https://www.malwarebytes.com/blog/news/2023/01/windows-event-logs-everything-you-need-to-know_