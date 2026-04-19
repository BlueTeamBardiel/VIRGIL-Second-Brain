```markdown
---
domain: "offensive-security"
tags: [keylogger, malware, spyware, credential-theft, endpoint, surveillance]
---
# Keylogger

A **keylogger** (short for **keystroke logger**) is a class of [[Spyware]] — implemented in software or hardware — that covertly records every key a user presses in order to steal **credentials**, messages, financial data, and other sensitive input. Keyloggers are one of the oldest and most effective tools in the [[Malware]] arsenal, appearing in everything from nation-state [[Advanced Persistent Threat|APT]] implants to commodity banking trojans and insider-threat scenarios. Although some variants are marketed as "parental control" or "employee monitoring" tools, their defining capability — silent capture of user input — makes them a cornerstone of [[Credential Theft]] operations.

---

## Overview

Keystroke surveillance predates the personal computer. Between 1976 and 1984, Soviet intelligence planted hardware keyloggers inside IBM Selectric typewriters used by U.S. diplomatic staff in Moscow, measuring the mechanical rotation of the print head to reconstruct typed text. The attack — one of the earliest documented supply-chain implants — demonstrates a principle that still holds: whoever controls input, controls the secret.

Modern keyloggers are overwhelmingly software-based. Their job is conceptually simple: intercept input events before (or as) they reach their destination application, persist the data locally, and forward it to an attacker-controlled collection point. Because nearly every authentication event begins with a typed password, a keylogger that runs for even a few minutes on a workstation can harvest credentials for email, VPNs, banking portals, administrative consoles, and cloud tenants. For that reason, keylogging is a near-universal component of [[Information Stealer]] families, [[Banking Trojan]]s (Zeus, Emotet, TrickBot, IcedID, Agent Tesla), and [[Remote Access Trojan|RAT]]s.

The threat is not limited to passwords. Keyloggers also capture chat messages, draft emails, search queries, cryptocurrency seed phrases, and PII. Most modern families augment raw keystroke capture with **form grabbers** (intercepting HTTP form submissions inside the browser), **clipboard monitors**, and **screenshotters** that trigger on mouse clicks — extending reach to data that is pasted, auto-filled, or entered via an on-screen keyboard.

Legitimate uses exist but are narrow: parental monitoring, authorized [[Data Loss Prevention|DLP]] telemetry, forensic investigation, and QA/usability research. Most jurisdictions require informed consent; covert deployment against another person's device typically violates statutes such as the U.S. [[Computer Fraud and Abuse Act|CFAA]], the UK Computer Misuse Act, and EU [[GDPR]] rules on lawful processing.

Keyloggers are delivered via the same vectors as other malware: phishing attachments, malicious Office macros, drive-by downloads, cracked-software droppers, vulnerable-driver loaders, and supply-chain compromises. Persistence is commonly achieved through registry Run keys, scheduled tasks, Windows services, Startup folder shortcuts, or browser extensions.

---

## How It Works

A keylogger must perform three tasks: **hook** input, **record and filter** it, and **exfiltrate** the result. Implementations differ sharply in privilege level and stealth.

### Software Keyloggers — User Mode (Windows)

The canonical Windows implementation installs a low-level keyboard hook with `SetWindowsHookEx`:

```c
HHOOK hHook = SetWindowsHookEx(
    WH_KEYBOARD_LL,          // low-level keyboard hook type
    LowLevelKeyboardProc,    // callback function pointer
    hInstance,               // module handle
    0                        // 0 = all threads (system-wide)
);

LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {
    if (nCode == HC_ACTION && wParam == WM_KEYDOWN) {
        KBDLLHOOKSTRUCT *p = (KBDLLHOOKSTRUCT *)lParam;
        LogKey(p->vkCode);   // virtual-key code written to log
    }
    return CallNextHookEx(NULL, nCode, wParam, lParam);  // pass to next hook
}
```

Every keystroke delivered to any process on the desktop is routed through the callback before reaching its destination application. Alternative user-mode techniques include:

- **Polling with `GetAsyncKeyState`** — iterate over all 256 virtual-key codes in a tight loop and record any key whose high bit is set. No hook is installed, which evades some hook-detection logic.
- **Raw Input API (`RegisterRawInputDevices`)** — register for `WM_INPUT` messages directly from the HID (Human Interface Device) stack, receiving events independently of the foreground window.
- **DirectInput / raw HID `ReadFile`** on `\\?\HID#...` device paths — bypass the Win32 message queue entirely, useful against sandboxed message-monitoring tools.

### Kernel-Mode and Driver-Based Keyloggers

More privileged implementations install a kernel driver that attaches to the keyboard device stack — typically by calling `IoAttachDeviceToDeviceStack` on `\Device\KeyboardClass0` — and intercepts IRPs (I/O Request Packets) carrying scan codes from the `kbdclass` driver before they propagate upward. Rootkits such as **Rustock** and **ZeroAccess** used variants of this approach. On Windows 10/11, kernel-mode code must be digitally signed; attackers therefore rely on [[BYOVD]] ("Bring Your Own Vulnerable Driver") techniques, loading a legitimately-signed but exploitable driver to escalate into kernel space and then install an unsigned keylogger module.

### Browser Form Grabbers

Banking malware often bypasses the keyboard entirely. Functions such as `PR_Write` (Firefox/NSS), `HttpSendRequest` (WinINet), and Chrome's `SSL_Write` (BoringSSL) are **patched in-memory** so form data is captured *after* the user submits but *before* TLS encryption. This technique:

1. Defeats on-screen keyboards (data is captured post-composition).
2. Bypasses clipboard-only password managers (the grab fires on `submit`, not on `keydown`).
3. Captures auto-filled credentials that the user never typed at all.

### Hardware Keyloggers

Hardware keyloggers are inline devices placed between the keyboard cable and the USB/PS2 port; some embed a microcontroller and flash storage inside the keyboard housing itself. USB variants (e.g., KeyGrabber, KeyCarbon) present as fully transparent pass-throughs — the OS sees a normal keyboard. Advanced models include Wi-Fi or GSM radios for wireless retrieval. Because they operate entirely below the OS, no host-based antivirus or EDR can detect them; however, they require physical access to both install and retrieve.

### Exfiltration

Captured logs are staged in a hidden file (often under `%APPDATA%\Roaming\<random_directory>`) and transmitted via:

| Channel | Details |
|---|---|
| SMTP | Ports 25 / 465 / 587 — Agent Tesla, HawkEye deliver via attacker-owned or compromised mailboxes |
| HTTPS POST | JSON or form-encoded payload to a C2 domain |
| Telegram Bot API | `https://api.telegram.org/bot<token>/sendMessage` — no dedicated infrastructure needed |
| FTP | Port 21 upload to a bulletproof host |
| DNS Tunneling | TXT records carry base64-encoded log chunks through restrictive egress filters |

### Data Enrichment Pipeline

To reduce noise and increase operational value, modern keyloggers:

1. Tag each keystroke with the **foreground window title** and **process name**, so `hunter2` is annotated as `chrome.exe — Sign In — accounts.google.com`.
2. Apply **regex filters** for credit-card numbers (Luhn-valid 13–19 digit sequences), Bitcoin/Ethereum addresses, API tokens, and common credential patterns.
3. Buffer input between `<TAB>` and `<ENTER>` events to reconstruct complete form fields rather than raw character streams.
4. Fire a **screenshot** on each mouse click to capture virtual keyboard selections, CAPTCHA responses, and graphical PIN pads that produce no keyboard events.
5. Monitor the clipboard with `GetClipboardData` to catch passwords pasted from a password manager.

---

## Key Concepts

- **Keystroke Logging** — the act of recording each discrete keyboard event, identified by a virtual-key code or hardware scan code, in the order they are pressed, typically with timestamps and window context.
- **API Hooking** — inserting a callback into an event chain (Win32 message hooks, inline function patches, IRP filters) so attacker-controlled code executes before the legitimate handler. See [[API Hooking]].
- **Form Grabber** — a browser-layer technique that captures HTTP form field values from inside the browser process, bypassing keyboard-level capture entirely and defeating on-screen keyboards and autofill.
- **Clipboard Hijacker** — component that reads (and optionally replaces) clipboard contents; commonly used to swap cryptocurrency wallet addresses mid-copy, stealing funds without keylogging a password.
- **Hardware Keylogger** — an inline or implanted physical device that records keystrokes in its own flash memory, operating entirely independently of the host OS and undetectable by software security tools.
- **Screen Scraper** — captures desktop screenshots on input events to defeat virtual keyboards, graphical PIN pads, and handwriting-input methods that generate no keyboard events.
- **Scan Code vs. Virtual-Key Code** — scan codes are hardware-dependent identifiers emitted by the keyboard controller; virtual-key codes (e.g., `VK_RETURN = 0x0D`) are OS-normalized abstractions delivered by Windows to applications. Low-level hooks work at the virtual-key level; kernel drivers can intercept at scan-code level.
- **Exfiltration Channel** — the network path used to deliver captured data; commonly SMTP, HTTPS to a C2, Telegram Bot API, or DNS tunneling for egress-restricted environments.
- **Persistence Mechanism** — the method by which the keylogger survives reboots: registry `Run`/`RunOnce` keys, Scheduled Tasks, Windows services, WMI event subscriptions, startup folder `.lnk` shortcuts, or malicious browser extensions.

---

## Exam Relevance

On the **Security+ SY0-701** exam, keyloggers appear primarily under **Domain 2 (Threats, Vulnerabilities, and Mitigations)**, specifically objectives **2.4** (indicators of malicious activity — malware types) and **2.2** (threat vectors and attack surfaces). Expect to:

- **Identify** a keylogger from scenario-based questions: *"Unknown credentials are being used to access the CFO's email account despite repeated password resets"* or *"An auditor discovers a small device between the keyboard and PC of a kiosk terminal"* — the first is a software keylogger; the second is a hardware keylogger requiring a **physical security** response, not an AV scan.
- **Distinguish** a keylogger from related malware types:
  - **Spyware** — broader category; keyloggers are one subtype of spyware.
  - **Rootkit** — focused on persistence and concealment; often *contains* a keylogger but the defining trait is stealth, not input capture.
  - **RAT (Remote Access Trojan)** — full remote control capability; keylogging is commonly one *module* among many.
- **Recommend countermeasures** correctly: the exam expects **phishing-resistant MFA** ([[FIDO2]]/WebAuthn or smart cards) as the *strongest* technical control — not just "use MFA," since TOTP codes captured alongside passwords can still be relayed in real-time attacks.

**Common exam gotchas:**

- **On-screen keyboards do NOT defeat modern keyloggers** — form grabbers and screenshot modules capture data regardless of input method. The exam may offer "on-screen keyboard" as a distractor.
- **MFA reduces but does not eliminate keylogger value** — SMS and TOTP codes can be phished in real time. The *correct* "most secure" answer is always FIDO2.
- A hardware keylogger **cannot be detected by antivirus** — the only correct response is periodic physical inspection of hardware.
- Keyloggers are classified as **spyware** when used for surveillance; they may also appear in questions about **insider threats** (authorized employee vs. covert deployment).

---

## Security Implications

Keyloggers are central to many of the most damaging credential-theft campaigns on record.

**Notable malware families:**

- **Agent Tesla** — .NET-based stealer with full keylogging, clipboard monitoring, and credential harvesting from over 70 applications (browsers, FTP clients, email clients, VPN software). Distributed via phishing since ~2014 and consistently ranked among CISA's most-reported malware families. Exfiltrates via SMTP to compromised mailboxes or Telegram bot tokens — infrastructure requiring no C2 server.
- **Emotet / TrickBot** — modular banking trojans whose keylogging and form-grabbing modules enabled pre-ransomware reconnaissance throughout 2018–2021, contributing to hundreds of millions of dollars in losses and enabling downstream Ryuk and Conti ransomware deployments.
- **LokiBot** — credential-stealer and keylogger documented in **CISA Alert AA20-266A** (September 2020); exfiltrates browser-saved passwords, FTP credentials, and email credentials.
- **Snake Keylogger** — .NET-based stealer active since 2020, distributed through high-volume phishing campaigns using CVE-2017-11882 and malicious Excel documents.

**Relevant CVEs enabling keylogger delivery:**

| CVE | Description |
|---|---|
| CVE-2017-11882 | Microsoft Office Equation Editor RCE — widely exploited to drop Agent Tesla and LokiBot |
| CVE-2018-0802 | Equation Editor RCE bypass (patch bypass for -11882) |
| CVE-2022-30190 | "Follina" — MSDT RCE via Office documents; used to deliver keylogger payloads in 2022 campaigns |
| CVE-2021-40444 | MSHTML RCE — used to download stealer/keylogger families via weaponized Office docs |

**Detection signals to monitor:**

- Processes registering system-wide keyboard hooks via `SetWindowsHookEx` — visible in EDR telemetry and via Sysinternals Process Explorer.
- Outbound connections on SMTP ports (25/465/587) from non-mail processes; DNS queries for `api.telegram.org` from workstation processes.
- Hidden files in `%APPDATA%\Roaming\<random>` with `.log`, `.dat`, or `.tmp` extensions whose size grows monotonically with user activity.
- Registry `Run` / `RunOnce` keys under `HKCU` or `HKLM` pointing to unsigned binaries in user-writable paths.
- Sysmon **Event ID 10** (process access to LSASS) in conjunction with keylogger-associated processes.

---

## Defensive Measures

### Credential Architecture

- Deploy **phishing-resistant MFA**: [[FIDO2]] / [[WebAuthn]] security keys (YubiKey, platform passkeys), PIV smart cards. Captured passwords alone become useless because authentication requires hardware-bound proof of presence.
- Use a **[[Password Manager]]** with browser autofill (1Password, Bitwarden, KeePassXC) — credentials are injected directly into form fields without being typed, generating no keyboard events.
- Enforce **short session lifetimes** and step-up authentication for sensitive operations (financial transactions, admin console access, privileged cloud APIs).

### Endpoint Controls

- Deploy **[[Endpoint Detection and Response|EDR]]** with behavioral detection for `SetWindowsHookEx`, `GetAsyncKeyState` polling loops, LSASS access, and known keylogger signatures (Microsoft Defender for Endpoint, CrowdStrike Falcon, SentinelOne).
- Enforce **[[Application Allowlisting]]** via [[AppLocker]] or [[Windows Defender Application Control|WDAC]] to prevent unapproved binaries (dropped keylogger executables) from running.
- Enable **Attack Surface Reduction (ASR) rules** to block Office macro child processes, credential-dump LOLBins, and unsigned code injected