# Incident Response Playbooks
> IR is not a feeling — it's a process. Follow it even when you're panicking.

When an incident happens, instinct says "fix it fast." Discipline says "understand it first." Skipping steps leads to incomplete containment, missed persistence mechanisms, and the same breach three months later. These playbooks are opinionated, practical, and built around what actually happens at organizations with limited IR budgets.

---

## IR Framework: PICERL

Every IR process follows the same arc. Know where you are in it at all times.

| Phase | What Happens |
|---|---|
| **Preparation** | Policies, playbooks, tools, training — before the incident |
| **Identification** | Detect and confirm something is actually happening |
| **Containment** | Stop the bleeding — prevent spread (short-term then long-term) |
| **Eradication** | Remove the threat: malware, persistence, attacker access |
| **Recovery** | Restore systems, verify clean state, return to operations |
| **Lessons Learned** | Document what happened, update playbooks, prevent recurrence |

**Where people go wrong:** Jumping from Identification straight to Eradication. If you don't contain first, eradicating one infected machine while the attacker still has C2 access accomplishes nothing.

---

## Playbook: Phishing Email Reported by User

**Trigger:** User calls/tickets saying they received a suspicious email. Possibly clicked a link.

### Step 1 — Don't click anything. Get the email headers.

```
In Outlook: File → Properties → Internet Headers
In Gmail: Three dots → Show original
```

Look for:
- **From vs Reply-To:** Mismatch = spoofing
- **Received chain:** The actual delivery path. Read bottom-up. Does it match the claimed sender's domain?
- **SPF/DKIM/DMARC:** Fail on any = the sender couldn't authenticate. Legitimate companies pass all three.
- **Message-ID domain:** Should match the From domain
- **X-Originating-IP:** Where it actually came from

### Step 2 — Analyze sender, domain, links

**Without clicking:**
- Copy the URL from the email source (not by hovering and copying — use view source)
- [VirusTotal](https://virustotal.com) → URL analysis: check if domain is flagged
- [URLScan.io](https://urlscan.io) → safe browsing analysis, shows screenshot of what the page looks like
- [MXToolbox](https://mxtoolbox.com) → email header analysis, blacklist check for sender IP
- [PhishTank](https://phishtank.com) → crowd-sourced phishing URL database

**Common phishing patterns:**
- Lookalike domains: `micosoft.com`, `paypa1.com`, `company-secure.com`
- Newly registered domains (check WHOIS — less than 30 days old = suspicious)
- Free hosting platforms: `.pages.dev`, `.netlify.app`, `.ngrok.io` used for credential pages
- Redirector chains: bit.ly → middleman site → actual phish page (URLScan follows the chain)

### Step 3 — Check if others received it

- **Mail gateway/spam filter search:** Search for the From address, Subject, Message-ID, or a URL from the body
- **Email clients:** In Exchange/O365, use Compliance Center → Content Search → search all mailboxes
- **Ask the user:** "Did you forward it to anyone? Did anyone else mention getting this?"

Command (Exchange Online PowerShell):
```powershell
Get-MessageTrace -SenderAddress "attacker@evil.com" -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)
```

### Step 4 — Containment

**Block the sender/domain:**
- Add sender domain to email gateway block list
- If using O365: Security & Compliance → Threat Management → Tenant Allow/Block Lists
- DNS block at [[Pi-hole]] or firewall level if domain is being used for C2

**Pull email from all inboxes:**
```powershell
# O365/Exchange: Search-Mailbox is deprecated — use Compliance Center
# PowerShell alternative:
$search = New-ComplianceSearch -Name "PhishHunt" -ExchangeLocation All `
    -ContentMatchQuery "Subject:'Your Account Has Been Suspended'"
Start-ComplianceSearch -Identity "PhishHunt"
Get-ComplianceSearch -Identity "PhishHunt"
New-ComplianceSearchAction -SearchName "PhishHunt" -Purge -PurgeType SoftDelete
```

### Step 5 — Check if anyone clicked

**Proxy logs:** Search for connections to the suspicious domain in the last 24-48 hours. Look for the phishing URL.

**Endpoint detection:** If you have [[Wazuh]] or EDR:
- Check alerts on the user's machine around the time of the email
- Look for new process creation (cmd.exe, powershell.exe, mshta.exe spawned from browser)
- Look for outbound connections from the machine to unfamiliar IPs

**If user clicked a credential page:**
- Force password reset immediately
- Check if the account was used from unusual locations after the reported time (login logs, Azure Sign-Ins)
- MFA reset if credentials are to an MFA-protected account
- Audit for email forwarding rules (attackers add silent forwarding rules after compromise)

### Step 6 — Document and report

```
Incident Report:
- Date/time reported:
- User who reported:
- Email received at:
- Subject line:
- Sender address + sending IP:
- URLs in email:
- VirusTotal / URLScan results:
- Other users who received:
- Did anyone click? If so, who and what time?
- Actions taken (block, purge, password reset):
- Escalation: [yes/no — to CISO/management]
```

---

## Playbook: Suspected Malware on Endpoint

**Trigger:** Antivirus alert, unusual behavior reported, EDR detection, or user reports "computer is acting weird."

### Step 1 — Confirm and triage (don't reimage yet)
- Is the AV alert a true positive or FP? Check the file hash on VirusTotal.
- Is the machine acting as an attacker (scanning other systems, sending spam)?
- Is sensitive data at risk on this machine?

```powershell
# Quick triage (run on suspected machine)
# Check running processes for unusual paths
Get-Process | Where-Object { $_.Path -like "*Temp*" -or $_.Path -like "*AppData*" } |
    Select-Object Name, Id, Path

# Check network connections
Get-NetTCPConnection -State Established | 
    Select-Object RemoteAddress, RemotePort, OwningProcess |
    Sort-Object RemoteAddress

# Check scheduled tasks (common persistence)
Get-ScheduledTask | Where-Object { $_.State -ne "Disabled" } |
    Select-Object TaskName, TaskPath | Where-Object { $_.TaskPath -notlike "*Microsoft*" }

# Autoruns alternative in PS
Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location
```

### Step 2 — Isolate
**Network isolate — but keep management access:**
- Remove from domain if possible (prevents lateral movement via AD)
- If using EDR (CrowdStrike, Defender for Endpoint): use "Contain Host" feature — blocks all network except C2 channel
- If manual: disable network adapter or move to isolated VLAN

**Don't turn it off** unless you have to — volatile memory (running processes, network connections) is lost on shutdown. Capture first if possible.

### Step 3 — Collect evidence
```powershell
# Save running processes to file
Get-Process | Export-Csv C:\IR\processes.csv

# Save network connections
Get-NetTCPConnection | Export-Csv C:\IR\netconn.csv

# Save event logs
wevtutil epl Security C:\IR\security.evtx
wevtutil epl System C:\IR\system.evtx
wevtutil epl Application C:\IR\application.evtx
```

### Step 4 — Eradicate
- Delete malware files (note paths first)
- Remove persistence: scheduled tasks, registry Run keys, services
- Run full AV scan
- Check for additional lateral movement: has this machine connected to other machines recently?

### Step 5 — Recover
- Verify clean state (re-scan, re-check autoruns)
- Rejoin to domain if it was removed
- Restore any corrupted files from backup
- Monitor for 72 hours

---

## Playbook: Unauthorized Access Attempt (Failed Logins)

**Trigger:** SIEM alert on multiple failed logins, help desk reports lockouts, anomalous login geography.

### Investigation
```powershell
# Find all failed logons for a user in the last hour
Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4625        # Failed logon
    StartTime = (Get-Date).AddHours(-1)
} | Where-Object { $_.Properties[5].Value -eq "targetuser" }

# Find lockout source (Event 4740)
Get-WinEvent -FilterHashtable @{ LogName='Security'; Id=4740 } |
    ForEach-Object {
        [PSCustomObject]@{
            Time       = $_.TimeCreated
            User       = $_.Properties[0].Value
            SourceHost = $_.Properties[1].Value
        }
    }
```

- If lockouts are coming from one source host: investigate that machine (infected, shared account, user locked out from session)
- If from many sources: brute force against the account — extend lockout policy, alert user, check if account was compromised
- Check for successful logon (4624) after a series of failures — compromise confirmed

---

## Playbook: Data Exfiltration Alert

**Trigger:** DLP alert, large outbound transfer detected, SIEM anomaly on outbound data volume.

### Immediate actions
1. **Don't block immediately** — if you block the connection, you lose the ability to monitor what's leaving
2. **Identify what's being transferred:** destination IP, destination port, data volume, time
3. **Identify the source process:** `netstat -anp` or EDR process → network correlation
4. **Capture traffic if possible:** mirror port to capture host, or pull NetFlow from firewall
5. **Determine data sensitivity:** what's on that machine / what service is making the connection?

### Then contain
- Block destination IP/domain at firewall
- Isolate source machine
- Preserve evidence (see Malware playbook Step 3)

---

## Tools Reference

| Tool | Purpose | Free? |
|---|---|---|
| **VirusTotal** | File/URL/IP/domain analysis | Yes |
| **URLScan.io** | URL behavioral analysis | Yes |
| **MXToolbox** | Email header analysis, DNS, blacklists | Yes |
| **PhishTank** | Phishing URL database | Yes |
| **TheHive** | Case management for IR teams | Open source |
| **Cortex** | Automated analyzer integrated with TheHive | Open source |
| **[[Splunk]]** | SIEM — log aggregation and search | Free (500MB/day) |
| **[[Wazuh]]** | Open source SIEM + EDR | Free |
| **CyberChef** | Data decoding, encoding, forensic transformation | Free |
| **Autopsy** | Disk forensics | Free |
| **Volatility** | Memory forensics | Free |

---

## Tags
`[[Incident Response]]` `[[CySA+]]` `[[Windows Event Logs]]` `[[MITRE ATT&CK]]` `[[Phishing]]` `[[Wazuh]]` `[[Splunk]]` `[[Malware]]` `[[SOC]]`