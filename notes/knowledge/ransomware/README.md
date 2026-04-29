# Ransomware — The Threat That Shut Down Hospitals
> Modern ransomware is not a virus. It's a coordinated criminal operation with affiliates, negotiators, and SLAs.

---

## How Ransomware Works End to End

### The Full Kill Chain

```
Initial Access → Establish Persistence → Privilege Escalation → 
Lateral Movement → Discovery → Data Exfiltration → 
Destroy Backups → Encrypt Everything → Drop Ransom Note
```

This is **not** automated. Modern human-operated ransomware involves real operators making real decisions at each stage. The encryption is often the *last* thing that happens — hours, days, or weeks after initial compromise.

### Stage-by-Stage

**1. Initial Access**
- Phishing email with malicious attachment (most common)
- Exploitation of public-facing apps (VPN, RDP, Exchange)
- Compromised credentials from prior breach (credential stuffing)
- Supply chain: compromised software update or managed service provider

**2. Establish Persistence**
- Registry run keys
- Scheduled tasks
- New service installation
- WMI subscriptions
- Modified legitimate services

**3. Privilege Escalation**
- Local admin → Domain Admin via Mimikatz, BloodHound path analysis
- Kerberoasting: request service tickets for crackable offline → get service account passwords
- Pass-the-hash / Pass-the-ticket

**4. Lateral Movement**
- PsExec, WMI, scheduled tasks → remote code execution on other hosts
- Valid admin credentials from step 3
- SMB share traversal

**5. Discovery**
- BloodHound / AdFind → map AD structure
- Network scanning → find backup servers, file shares, business-critical systems
- Hunt for crown jewels: finance, HR, legal, R&D

**6. Data Exfiltration (Double Extortion)**
- Copy sensitive data to attacker infrastructure BEFORE encrypting
- Common tools: rclone (cloud sync), WinSCP, custom staging servers
- Volume: typically terabytes exfiltrated over days/weeks
- Leverage: "Pay or we publish your data on our leak site"

**7. Destroy Backups**
This is the step that kills organizations:
```cmd
# Delete Volume Shadow Copies (Windows)
vssadmin delete shadows /all /quiet
wmic shadowcopy delete
bcdedit /set {default} recoveryenabled No
bcdedit /set {default} bootstatuspolicy ignoreallfailures

# Kill backup agents
net stop "Veeam Backup Service"
net stop "BackupExec"
taskkill /f /im "backup*.exe"
```

**8. Encryption**
- AES-256 for file encryption
- RSA-2048/4096 to protect the AES key (only attacker's server has the RSA private key)
- Targets: documents, spreadsheets, databases, emails, backups
- Excludes: Windows system files (needs to stay bootable enough to display ransom note)
- Speed: modern ransomware encrypts as fast as possible — Lockbit 3.0 benchmarked at 54MB/s

**9. Ransom Note**
- `README.txt`, `RECOVER_FILES.txt`, `RyukReadMe.txt`, etc.
- Tor .onion payment portal
- Timer counting down to data publication
- Negotiation contact

---

## The Ransomware Economy

### RaaS (Ransomware as a Service)
Modern ransomware is a *business model*, not just malware:
- **Core team:** Writes the ransomware, maintains infrastructure, handles negotiation
- **Affiliates:** Operators who buy/rent access to the ransomware — do the actual intrusion
- **Split:** Typically 70-80% to affiliate, 20-30% to core team
- **Infrastructure:** Dark web leak sites, Tor payment portals, customer service (!)

**This means:** The ransomware binary you're analyzing was probably written by someone other than the person who hacked you. The group name on the ransom note is the brand, not the operator.

### Cryptocurrency Flow
1. Ransom paid in Bitcoin or Monero
2. Tumbling/mixing to obscure trail
3. Conversion to fiat via crypto exchanges (often sanctioned jurisdictions)
4. Some groups busted via blockchain tracing (Colonial Pipeline recovery: $2.3M of $4.4M recovered)

---

## Major Incidents

### WannaCry — May 2017
- **Vector:** EternalBlue (MS17-010) — SMB exploit stolen from NSA
- **Impact:** 230,000 systems in 150 countries
- **Notable victim:** UK NHS — surgeries canceled, patients turned away
- **"Kill switch":** Accidental — registered an unregistered domain found in the code, it stopped spreading
- **Attribution:** Lazarus Group (North Korea)
- **Lesson:** Patch SMBv1. Disable it entirely. MS17-010 was patched March 2017 — WannaCry hit May 2017.

### NotPetya — June 2017
- **Vector:** Trojanized M.E.Doc accounting software update + EternalBlue
- **Impact:** $10B in damages — largest in history
- **Notable victims:** Maersk, Merck, FedEx, Mondelez, hospitals in Ukraine
- **Key fact:** NOT actually ransomware — no decryption key exists. Pure destructive wiper.
- **Attribution:** Sandworm (Russian GRU)
- **Lesson:** Supply chain attacks bypass all perimeter controls. Air-gapped backups saved Maersk.

### Colonial Pipeline — May 2021
- **Group:** DarkSide (RaaS affiliate)
- **Vector:** Compromised VPN credentials (no MFA)
- **Impact:** 5,500 miles of pipeline shut down. East Coast fuel shortage. Gas lines.
- **Ransom paid:** $4.4M (the U.S. government recovered $2.3M via blockchain tracing)
- **Lesson:** MFA on VPN is mandatory. Operational technology (OT) networks need stronger isolation from IT.

### Change Healthcare — February 2024
- **Group:** ALPHV/Blackcat (then Ransomhub claimed some data)
- **Vector:** Citrix credentials without MFA
- **Impact:** Healthcare payment processing for 1/3 of US hospitals disrupted for weeks
- **Ransom paid:** $22M (allegedly — parent company UnitedHealth admitted it)
- **Lesson:** Interconnected healthcare infrastructure is a systemic risk. Single-vendor dependency.

---

## Double Extortion: The Game Changer

Pre-2020: Ransomware = encrypt files + pay to decrypt
Post-2020: **Encrypt AND exfiltrate.** Now you have two problems.

Even if you have perfect offline backups:
- Attacker has your data
- They'll publish it if you don't pay
- HIPAA breach fines, GDPR notifications, SEC disclosure requirements
- Reputational damage regardless of decryption

Triple extortion adds: contact your customers/patients directly to pressure payment.

---

## Defenses

### Backup Strategy: 3-2-1 Rule (Minimum)
- **3** copies of data
- **2** different media types
- **1** offsite (or air-gapped)
- **+1 bonus:** offline / immutable copy that ransomware can't reach (tape, cloud with object lock, Veeam with immutable repository)

In COCYTUS: `config-backup.yml` runs Mon/Thu via [[Semaphore]]. This is the beginning, not the end.

### Network Segmentation
Blast radius reduction. If workstations can't reach backup servers directly, ransomware can't kill your backups. If servers are segmented by function, lateral movement is harder.

### Endpoint Detection and Response (EDR)
[[Wazuh]] provides FIM (file integrity monitoring) and process monitoring. Commercial EDR (CrowdStrike, SentinelOne) adds behavioral detection specifically tuned for ransomware patterns:
- Mass file rename detection
- Shadow copy deletion attempt
- Backup process kill attempts
- Suspicious PowerShell patterns

### Patch Management
EternalBlue was patched before WannaCry. Citrix CVEs were known before Colonial. **Patch fast, patch everything.** COCYTUS automated patching via `apt-upgrade.yml` (Mon/Thu) addresses this for Linux fleet.

### Disable SMBv1
```powershell
# Disable SMBv1 (EternalBlue attack surface)
Set-SmbServerConfiguration -EnableSMB1Protocol $false
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
```

### Email Filtering + User Training
Most ransomware still starts with a phishing email. Layer your defenses:
1. Email gateway with attachment sandboxing (Office macros especially)
2. Disable macros by default via GPO
3. User training — test with simulated phishing

---

## Detection

### SIEM Rules for Ransomware Behavior
```splunk
# Detect VSS deletion (ransomware prep)
index=windows EventCode=4688 CommandLine="*vssadmin*delete*"

# Detect backup service kill
index=windows EventCode=7036 Service_Name IN ("Veeam*","BackupExec*","Windows Backup") Message="*stopped*"

# Detect mass file extension change (crude but catches some)
index=sysmon EventCode=11 TargetFilename="*.encrypted" OR TargetFilename="*.ryuk" OR TargetFilename="*.lockbit"
```

### Honeypot Files and Canary Tokens
Deploy fake "sensitive" files (honeypot-budget-2024.xlsx, canary-hr-records.docx) across file shares.
- Canary Tokens: https://canarytokens.org — free, fires webhook/email when file is opened
- If ransomware touches the canary, you get alerted before mass encryption completes
- Trips within minutes if ransomware does sequential directory encryption

---

## Recovery: Do You Pay?

**FBI official guidance:** Do not pay. Payment funds further attacks and doesn't guarantee recovery.
**Reality:** Some organizations pay because recovery is impossible or would take longer than the business can survive.

**Factors to consider:**
- Do you have working offline backups? → Don't pay
- Is data already published on leak site? → Payment doesn't help with what's already out
- Is the group sanctioned by OFAC? → Payment may be illegal (DarkSide, Evil Corp are sanctioned)
- Negotiation is possible — first ask is rarely the final number

**Decryptor availability:**
- NoMoreRansom project (nomoreransom.org) — free decryptors for many older families
- Some families have been cracked by researchers
- Law enforcement seizures sometimes yield decryption keys (Hive, NetWalker)

---

## Tags
`#ransomware` `#incident-response` `#malware` `#backup-strategy` `#ras`

[[Incident Response]] [[Windows Event IDs]] [[Splunk]] [[Wazuh]] [[CySA+]] [[Malware]] [[Threat Actors]] [[DFIR]]