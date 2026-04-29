# Windows Hardening — Closing the Doors Attackers Use
> Default Windows is not secure. Here's how to fix that.

A fresh Windows install is built for compatibility and ease of use, not security. SMBv1 may be enabled. LLMNR broadcasts credentials to anyone listening. PowerShell logging is off. Local admins share the same password across every machine. These aren't bugs — they're defaults that made sense once and never got turned off. Hardening is the deliberate process of removing those defaults.

---

## CIS Benchmarks

The Center for Internet Security publishes free hardening benchmarks for every major OS and application. They're the standard reference for enterprise hardening.

**Get them:** [benchmarks.cisecurity.org](https://www.cisecurity.org/cis-benchmarks) — free download, requires registration.

**What's in them:** Every setting that should be configured, what it should be set to, why, and the GPO path or registry key to change it. Organized into Level 1 (sensible baseline, minimal impact) and Level 2 (higher security, may break some things).

**How to use in a lab:** Download CIS Benchmark for Windows 11 or Windows Server 2022. Pick 10 items from Level 1. Implement them via GPO. Test that nothing breaks. Repeat. This is exactly what a junior security engineer does on day one.

---

## Group Policy Hardening

These are the highest-value GPO settings. Apply them via:
`Group Policy Management → Create GPO → Edit → Computer Configuration`

### 1. Disable LLMNR and NetBIOS
**What it is:** LLMNR (Link-Local Multicast Name Resolution) and NetBIOS are fallback name resolution protocols that broadcast queries on the local network. Any machine can respond.

**Why it matters:** Responder, a standard pentesting tool, listens for these broadcasts and answers them, capturing NTLMv2 hashes that can be cracked offline or used in relay attacks. This is one of the first things pentesters do after connecting to a network.

```
GPO: Computer Configuration → Administrative Templates →
  Network → DNS Client → Turn off multicast name resolution → Enabled

NetBIOS: Computer Configuration → Windows Settings → Security Settings →
  Network List Manager Policies → [network] Properties →
  Or via DHCP option 043, or registry:
  HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\
  NetbiosOptions = 2 (disable)
```

### 2. Enable PowerShell Script Block Logging (Event ID 4104)
```
GPO: Computer Configuration → Administrative Templates →
  Windows Components → Windows PowerShell →
  Turn on PowerShell Script Block Logging → Enabled
```
See [[Windows Event IDs]] for what this captures and why it's critical.

### 3. Enable Command Line Process Auditing (Event ID 4688 + arguments)
```
GPO: Computer Configuration → Administrative Templates →
  System → Audit Process Creation →
  Include command line in process creation events → Enabled

Also enable: Computer Configuration → Windows Settings →
  Security Settings → Advanced Audit Policy Configuration →
  Detailed Tracking → Audit Process Creation → Success
```
Without this, 4688 events show a process started but not what arguments were passed. Useless for detecting PowerShell attacks without arguments.

### 4. Disable SMBv1
SMBv1 is the protocol exploited by [[EternalBlue]] (MS17-010), which powered WannaCry and NotPetya. There is no legitimate reason to run SMBv1 in a modern environment.

```powershell
# Disable SMBv1 immediately (PowerShell, elevated)
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

# Verify
Get-SmbServerConfiguration | Select EnableSMB1Protocol

# GPO equivalent (Computer Configuration → Administrative Templates →
#   Network → Lanman Workstation → Enable insecure guest logons → Disabled)
# Registry: HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters
# SMB1 = DWORD 0
```

### 5. Require NTLMv2, Disable LM and NTLMv1
LM and NTLMv1 are cryptographically weak. LM hashes can be cracked in seconds. NTLMv1 hashes are cracable with modern hardware. NTLMv2 is still not ideal (still susceptible to relay) but significantly stronger.

```
GPO: Computer Configuration → Windows Settings → Security Settings →
  Local Policies → Security Options →
  Network security: LAN Manager authentication level →
  "Send NTLMv2 response only. Refuse LM & NTLM"
```

### 6. Enable Windows Defender Credential Guard
Credential Guard uses virtualization-based security (VBS) to isolate LSASS credentials. [[Mimikatz]] and similar tools cannot dump credentials from LSASS when Credential Guard is active.

**Requirements:** 64-bit Windows 10/11 Enterprise, UEFI, Secure Boot, TPM (recommended).

```
GPO: Computer Configuration → Administrative Templates →
  System → Device Guard →
  Turn On Virtualization Based Security → Enabled
  Select Platform Security Level: Secure Boot and DMA Protection
  Credential Guard Configuration: Enabled with UEFI lock
```

### 7. LAPS — Local Administrator Password Solution
Every Windows workstation has a local Administrator account (often disabled, but the account exists). In environments without LAPS, the local admin password is the same on every machine — set during imaging. One compromised workstation = credentials work everywhere (pass-the-hash laterally).

**LAPS:** Automatically sets a unique, random password for the local Administrator account on each machine. Stores it securely in Active Directory. Rotates on schedule.

```powershell
# Install LAPS (on management workstation + GPO deployment)
# Windows 11 22H2+ has LAPS built in (Windows LAPS)
# Older: download LAPS.x64.msi from Microsoft

# Check if LAPS is installed
Get-AdmPwdPassword -ComputerName WORKSTATION01

# View password (requires delegated permission)
Get-ADComputer WORKSTATION01 -Properties ms-Mcs-AdmPwd | Select ms-Mcs-AdmPwd
```

**GPO:** Computer Configuration → Administrative Templates → LAPS → Set password length/complexity/expiration

### 8. AppLocker — Application Whitelisting
Only allow approved applications to run. Blocks most malware, ransomware, and LOLBins by default.

**Limitation:** AppLocker is available on Windows Enterprise/Education only. Use Windows Defender Application Control (WDAC) for a more robust alternative.

```
GPO: Computer Configuration → Windows Settings → Security Settings →
  Application Control Policies → AppLocker

Basic rules:
- Executable rules: allow only signed executables from Program Files, Windows
- Script rules: allow only scripts from specific paths
- Packaged app rules: control Store apps
```

**Start with audit mode:** `Enforcement mode = Audit only` logs what would be blocked without blocking it. Review logs for 2 weeks before switching to enforcement. Otherwise you'll break legitimate software.

---

## Windows Defender Configuration

Windows Defender (Microsoft Defender Antivirus + Microsoft Defender for Endpoint) is genuinely good. Don't assume you need third-party AV.

### Key Settings
```powershell
# Check current protection status
Get-MpComputerStatus

# Ensure real-time protection is on
Set-MpPreference -DisableRealtimeMonitoring $false

# Enable cloud-delivered protection
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -SubmitSamplesConsent SendAllSamples

# Enable tamper protection (prevents disabling Defender from cmd/PS)
# Can only be set via Security Center GUI or Intune — not by script
# Settings → Windows Security → Virus & threat protection → Manage settings → Tamper Protection → On
```

### Attack Surface Reduction (ASR) Rules
ASR rules block specific behaviors commonly used by malware. These are high-value, low-disruption in most environments:

```powershell
# Block Office apps from creating executable content
Set-MpPreference -AttackSurfaceReductionRules_Ids "3b576869-a4ec-4529-8536-b80a7769e899" -AttackSurfaceReductionRules_Actions Enabled

# Block credential stealing from LSASS
Set-MpPreference -AttackSurfaceReductionRules_Ids "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b3" -AttackSurfaceReductionRules_Actions Enabled

# Block Office macros from making Win32 API calls
Set-MpPreference -AttackSurfaceReductionRules_Ids "92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b" -AttackSurfaceReductionRules_Actions Enabled
```

Full ASR rule GUIDs and descriptions: [Microsoft documentation](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/attack-surface-reduction-rules-reference)

---

## Account Hygiene

### Rename the Administrator Account
The default `Administrator` account is the first thing brute-force attacks try. Renaming it doesn't stop a determined attacker (SID S-1-5-...-500 is still findable) but defeats automated tools.

```
GPO: Computer Configuration → Windows Settings → Security Settings →
  Local Policies → Security Options →
  Accounts: Rename administrator account → [new name]
```

### Disable the Guest Account
```
GPO: Computer Configuration → Windows Settings → Security Settings →
  Local Policies → Security Options →
  Accounts: Guest account status → Disabled
```

### Tiered Admin Accounts (Tier 0 / 1 / 2)
The Microsoft-recommended approach to AD privilege management:

- **Tier 0:** Domain Controllers, Active Directory itself, Domain Admins. Credentials used ONLY on Tier 0 systems. Never log into a workstation with a Domain Admin account.
- **Tier 1:** Member servers (file servers, app servers). Server admins have Tier 1 accounts only.
- **Tier 2:** Workstations. Helpdesk/desktop admins have Tier 2 accounts for workstation management.

**Why:** If a Tier 2 admin's workstation is compromised, the attacker only has credentials with access to other workstations — not servers or domain controllers.

---

## Network Hardening

### Windows Firewall
Keep it enabled on all three profiles. Corporate environments often disable it (breaks things, easier to manage without it) — this is wrong.

```powershell
# Enable all profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Check status
Get-NetFirewallProfile | Select Name, Enabled

# Block inbound, allow outbound (default)
Set-NetFirewallProfile -Profile Domain,Public,Private `
    -DefaultInboundAction Block -DefaultOutboundAction Allow
```

### Disable Unused Services
Common attack vectors via default-enabled services:
- `Print Spooler` (disabled on machines that don't print — [[PrintNightmare]])
- `Remote Registry` (disabled unless needed)
- `Telnet` (disabled always)
- `SNMP` (disabled unless needed — often has default community strings)

```powershell
# Disable Print Spooler on non-print servers
Stop-Service Spooler
Set-Service Spooler -StartupType Disabled
```

---

## Monitoring: What to Log and How Long

### What to Enable
| Audit Policy | Events |
|---|---|
| Account Logon → Audit Credential Validation | Success, Failure |
| Account Management → Audit User Account Management | Success, Failure |
| Detailed Tracking → Audit Process Creation | Success |
| Logon/Logoff → Audit Logon | Success, Failure |
| Object Access → Audit File System | Failure (selective paths) |
| Policy Change → Audit Policy Change | Success |
| Privilege Use → Audit Sensitive Privilege Use | Failure |
| System → Audit Security System Extension | Success |

### Log Retention
- Security log: Set to 256MB minimum, overwrite as needed, but forward to SIEM before they rotate
- SIEM retention: 90 days online (searchable), 1 year archive minimum for compliance
- Forward with Winlogbeat, NXLog, or [[Wazuh]] agent

---

## Quick Wins vs Long-Term Projects

**Do today (quick wins, low risk):**
- [ ] Disable SMBv1
- [ ] Disable LLMNR/NetBIOS via GPO
- [ ] Enable PS Script Block Logging and 4688 command line auditing
- [ ] Enable Windows Defender tamper protection
- [ ] Rename local Administrator accounts via LAPS

**This week (moderate effort):**
- [ ] Deploy LAPS
- [ ] Enable ASR rules in audit mode → review → enforce
- [ ] Enable Credential Guard on workstations meeting requirements
- [ ] Set NTLMv2 policy domain-wide

**Long-term hardening projects:**
- [ ] Implement tiered admin model
- [ ] AppLocker or WDAC deployment
- [ ] Privileged Access Workstations (PAWs) for Tier 0/1 admins
- [ ] Audit all service accounts and remove excess permissions

---

## Tags
`[[Windows]]` `[[Active Directory]]` `[[Windows Event IDs]]` `[[CySA+]]` `[[GPO]]` `[[LAPS]]` `[[Credential Guard]]` `[[SMBv1]]` `[[LLMNR]]` `[[AppLocker]]`