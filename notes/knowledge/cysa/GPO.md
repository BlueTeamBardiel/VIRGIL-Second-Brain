# GPO — Group Policy Objects

## What it is

In **Mortal Kombat**, Shao Kahn's announcer barks "**FINISH HIM**" and every fighter in the tournament obeys the same rule set — same fatality inputs, same round timer, same arena hazards. The Elder Gods wrote the kombat rules once; every match enforces them. Nobody negotiates whether uppercut does damage. That's exactly what a Group Policy Object does — Active Directory writes the rule once at the domain controller, and every domkained Windows host obeys it on login and every 90 minutes after.

**Plain English:** GPOs are how Windows admins push settings to thousands of machines at once — password length, what runs at startup, who can RDP in, whether PowerShell is logged, whether USB drives mount. The DC publishes the policy; the endpoint pulls and enforces it.

**Technical:** A Group Policy Object is a collection of registry-based and file-based configuration settings stored in Active Directory and linked to a **site, domain, or organizational unit (OU)**. Settings replicate via SYSVOL (\\domain\SYSVOL\Policies\{GUID}) and the AD database. Clients apply GPOs at boot/login and refresh every 90 minutes (±30 min randomization) via `gpupdate`. Processing order is **LSDOU**: Local → Site → Domain → OU (last writer wins unless enforced/blocked).

For a CySA+ analyst, GPO is two things at once: **a defensive control surface** (push logging, restrict PowerShell, force Defender on) and **an attacker payload delivery system** (one compromised Domain Admin = policy pushed to every endpoint in the forest).

## Why it matters

GPO is on the CS0-003 exam because Objective 1.3 covers tools and techniques to determine malicious activity — and almost every detection capability you rely on (Sysmon logging, PowerShell ScriptBlock logging, Defender configuration, audit policy) is **deployed and enforced via GPO**. If GPO is broken, tampered with, or misconfigured, your SIEM goes dark and your EDR loses telemetry. CompTIA tests this under "endpoint security" and "log analysis/correlation."

In the real war room: when an APT compromises a Domain Admin account, the first thing mature actors do is push a malicious GPO. It's the legitimate, signed, audited mechanism for mass deployment — which means it bypasses every "suspicious executable" heuristic your EDR has. **The detection isn't "weird binary on the endpoint" — it's "weird GPO modification on the DC."** Most SOCs don't watch GPO changes. That's the gap.

## Key facts

### GPO architecture

| Component | Where it lives | What it holds |
|---|---|---|
| **Group Policy Container (GPC)** | AD database (CN=Policies,CN=System) | GUID, version number, ACLs, links |
| **Group Policy Template (GPT)** | SYSVOL share on every DC | Actual .pol files, scripts, ADMX-driven settings |
| **gPLink attribute** | On site/domain/OU object | Pointer linking the GPO to the scope |
| **Client-Side Extensions (CSE)** | On every domain-joined endpoint | DLLs that actually apply the policy locally |

Two halves to a GPO: **Computer Configuration** (applies at boot, runs as SYSTEM) and **User Configuration** (applies at login, runs as the user). Computer-side wins conflicts by default.

### Processing order — LSDOU

1. **Local** GPO (`gpedit.msc` on the endpoint itself)
2. **Site** GPOs
3. **Domain** GPOs
4. **OU** GPOs (nested OUs apply parent-first, then child)

Last writer wins. Modifiers: **Enforced** (a parent GPO that child OUs cannot block), **Block Inheritance** (an OU that refuses upstream GPOs — overridden by Enforced), and **Security Filtering / WMI Filtering** to scope which users/computers in the linked container actually receive it.

> **CompTIA exam trap:** If a GPO is set to "Enforced" at the domain level and an OU has "Block Inheritance" set, the Enforced GPO **still applies**. Enforced beats Block. CompTIA loves this one.

### Defensive GPOs the SOC depends on

These are the policies an analyst should know are in place — and should alert on if they get modified:

- **PowerShell logging** — Module Logging, ScriptBlock Logging (Event ID 4104), Transcription. Without these, fileless attacks are invisible.
- **Audit policy** — Logon events (4624/4625), process creation (4688) with command-line auditing, object access. This is what feeds your [[SIEM]].
- **Sysmon deployment** — Sysmon installed and configured via GPO with a tuned config (SwiftOnSecurity / Olaf Hartong baseline).
- **Windows Defender / EDR enforcement** — tamper protection, real-time scanning, ASR rules.
- **AppLocker / WDAC** — application control. Block users running binaries from %TEMP%, %APPDATA%, Downloads.
- **LAPS** — Local Administrator Password Solution. Unique randomized local admin password per host, rotated and escrowed in AD.
- **Restrict RDP and SMB** — disable SMBv1, restrict NTLM, force SMB signing.
- **USB / removable media control** — block mass storage class or require BitLocker To Go.

If any of these get disabled or unlinked, **your visibility just dropped**. That's an incident, not a config change.

### How attackers abuse GPO

This is the part CompTIA hints at but doesn't always state plainly:

- **Malicious GPO creation** — attacker with `Domain Admin` or `GPO Edit` rights creates a new GPO that runs a scheduled task, immediate task, or startup script on every machine in scope.
- **GPO modification** — flip the policy that enforces ScriptBlock logging from Enabled to Disabled. The forest goes dark; nobody notices because there's no log of the log being turned off.
- **SharpGPOAbuse / pyGPOAbuse** — public tools that programmatically add an immediate scheduled task to a GPO. Pushes a SYSTEM-level command to every linked host within 90 minutes.
- **SYSVOL credential exposure** — old-school but still tested: legacy GPP (Group Policy Preferences) stored encrypted passwords in `groups.xml` on SYSVOL with a Microsoft-published AES key. Any domain user could read SYSVOL and decrypt. MS14-025 deprecated it, but legacy SYSVOL files still surface in audits.

### Detection — what the SOC actually looks for

| Event ID | Source | What it tells you |
|---|---|---|
| **5136** | Security (DC) | Directory service object modified — fires on GPO attribute change |
| **5137 / 5141** | Security (DC) | GPO created / deleted |
| **4662** | Security (DC) | Operation on AD object — needs SACL tuning |
| **4688** | Endpoint | Process creation — catches the payload spawning after GPO push |
| **4104** | PowerShell | ScriptBlock execution — catches the GPO-delivered PowerShell |

Correlate Event ID 5136 on a DC with mass Event ID 4688s on endpoints within the next 120 minutes (the gpupdate window). That pattern — **one DC write, hundreds of endpoint executions** — is the signature of GPO-based deployment, legitimate or not.

> **CompTIA exam trap:** "An attacker disables a logging GPO" — the **right detection** is monitoring AD object modifications on Policies container, NOT trying to detect the absence of logs on endpoints. You cannot reliably alert on the absence of an event; you alert on the **cause** of the absence at the source.

### Tools an analyst uses

- **`gpresult /h report.html`** — generate Resultant Set of Policy (RSoP) for a host. Shows exactly which GPOs applied and which were filtered out.
- **`Get-GPO -All`** (PowerShell, GroupPolicy module) — enumerate GPOs, versions, last modified.
- **`Get-GPOReport -All -ReportType XML`** — export every GPO to XML for diffing. Run weekly, diff against baseline. Any unexpected change = ticket.
- **PowerView / BloodHound** — attacker recon tools, but blue team uses them too. `Get-NetGPO`, `Get-ObjectAcl` to find who can edit which GPO. Audit your ACLs.
- **PingCastle / Purple Knight** — free AD security assessment tools. Will flag stale GPOs, weak ACLs, GPP password remnants.

### The XML / file-analysis angle

GPO settings on SYSVOL are XML and .pol files. Use [[file analysis]] tools:
- `groups.xml`, `services.xml`, `scheduledtasks.xml` — look for `cpassword=` (legacy GPP credential, instant finding)
- `ScheduledTasks\ScheduledTasks.xml` — what runs and as whom
- `regular expressions` (regex) for `cpassword="[A-Za-z0-9+/=]+"` across SYSVOL is a 30-second audit

## SOC reality

- At 3am, the alert that matters isn't a GPO firing — it's **Event ID 5136 on a DC outside of change-window hours**. L1 ack, check the modifying user (was it the AD team's service account or `[email protected]` at 02:47?), pull the GPO diff, escalate to IR if the modified setting is a logging or AV control.
- When the CISO asks "are we covered against [latest CVE/ransomware]?" the answer often lives in GPO. *"Yes, AppLocker via GPO blocks execution from %TEMP%, and Defender ASR rules are enforced domain-wide — here's the gpresult from a random sample of 20 endpoints."* That's the receipt.
- Never promise leadership "GPO is enforcing X" without pulling RSoP on an actual endpoint. GPOs can be silently filtered by WMI, security filtering, or a "Deny Apply" ACL. *I learned this the hard way watching a "100% deployed" PowerShell logging policy actually cover 60% of hosts because someone scoped it to the wrong OU three years ago.*
- The handoff: L1 sees GPO modification → L2 pulls the diff and identifies the changed setting → IR engages if the change weakens detection or enables execution → AD team and CISO get looped in if a Domain Admin account is implicated. Restore the GPO from backup (`Backup-GPO` runs nightly in any mature shop — and if it doesn't, that's your next ticket).
- Watch SYSVOL for new or modified files outside change windows. Endpoint EDR usually doesn't watch DCs the same way it watches workstations. *Domain controllers are the throne room. Treat them like Shao Kahn's chamber, not like a file server.*

## Related concepts

[[Active Directory]] · [[PowerShell logging]] · [[Sysmon]] · [[Event ID 4688]] · [[Event ID 4104]] · [[SIEM]] · [[LAPS]] · [[AppLocker]] · [[BloodHound]] · [[Lateral movement]] · [[Privilege escalation]] · [[File analysis]] · [[Regular expressions]] · [[Endpoint security]] · [[Log analysis and correlation]]

*Source: VIRGIL knowledge base — 2026-05-11*