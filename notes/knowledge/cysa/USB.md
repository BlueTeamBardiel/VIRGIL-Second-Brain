# USB — Universal Serial Bus

## What it is

In **Minecraft**, you place a hopper next to a chest and suddenly anything in that hopper flows straight into your storage — no permission check, no questions asked. Now imagine a stranger drops a hopper into your base while you're AFK, full of TNT minecarts pointed at your spawn chunk. That's a malicious USB device. The port is the hopper interface. The OS trusts whatever physical thing connects to it the same way the chest trusts the hopper.

**Plain English:** USB is the universal "plug it in and the computer figures out what it is" interface. The problem is the computer figures out what it is *by asking the device what it is*. A device can lie. It can say "I'm a keyboard" while actually being a tiny computer that types attack commands at 1,000 keystrokes per second. It can say "I'm a flash drive" while actually serving malicious files to autorun. It can say "I'm a network adapter" and hijack DNS.

**Technical definition:** **USB** (Universal Serial Bus) is a host-controlled, plug-and-play serial interface standard. The host enumerates connected devices via descriptor exchange, loads matching drivers from the **HID** (Human Interface Device) and other class specifications, and grants the device the privileges of its declared class. USB is a **physical-layer attack surface** for endpoint security: it bypasses network controls, often bypasses application allow-lists, and exploits the operating system's implicit trust of physical hardware.

For CS0-003 Domain 2.4, USB is treated as a **vulnerability mitigation control surface** — controls you recommend to prevent the device-based attacks that endpoint security tooling has historically been bad at catching.

## Why it matters

The network firewall doesn't see a USB stick. The web proxy doesn't see a USB stick. The email gateway doesn't see a USB stick. Every dollar spent on perimeter defense is bypassed the moment somebody plugs a $5 device into a workstation in the lobby.

Stuxnet — the most famous nation-state malware in history — crossed an air gap via USB. The 2020 FIN7 BadUSB campaign mailed devices to retail employees with fake gift cards. Every red team that has ever run a physical engagement has dropped USB drives in the parking lot, and *people still pick them up and plug them in*.

For the CySA+ exam, USB sits at the intersection of **Objective 2.4 (mitigation controls)** and **Objective 2.5 (vulnerability response)**. CompTIA tests it as a vector for **remote code execution**, **privilege escalation**, **persistent** malware, and **insecure design** when removable media policy is missing.

## Key facts

### USB attack classes

| Attack | What it is | Class spec abused |
|---|---|---|
| **BadUSB / Rubber Ducky** | Device claims to be a keyboard, types attack commands at machine speed | HID (keyboard) |
| **Malicious mass storage** | Flash drive with autorun malware, malicious LNK files, or weaponized documents | Mass Storage |
| **USB drop attack** | Adversary leaves USB devices in target's physical space, relies on human curiosity | Any |
| **Juice jacking** | Public charging port doubles as data port, exfiltrates from phone | Mass Storage / MTP |
| **O.MG cable** | Charging cable with embedded WiFi-enabled microcontroller, accepts remote commands | HID |
| **USB Killer** | Charges capacitors from USB power, discharges -200V back into port, fries the host | Power delivery abuse |
| **NIC impersonation** | Device claims to be a USB Ethernet adapter, becomes default gateway, hijacks DNS | CDC-Ethernet |
| **DMA attacks (Thunderbolt/USB4)** | Device gets direct memory access, reads RAM, extracts keys | Thunderbolt-class |

The unifying weakness: **the OS trusts the descriptor**. Windows, macOS, and Linux all load drivers based on what the device claims to be. A $20 Rubber Ducky, a $5 cable, a re-flashed thumb drive — they all exploit the same trust model.

### The five mitigation tiers

**1. Physical** — Port blockers (the little plastic plugs), epoxy in the ports on kiosk machines, locked workstation cases. Crude but effective for fixed-function endpoints. *Doesn't scale to laptops.*

**2. BIOS/UEFI** — Disable USB ports entirely at firmware level for endpoints that don't need them. Some BIOSes allow keyboard/mouse only.

**3. OS policy** — Windows Group Policy `Removable Storage Access` restrictions; Linux `udev` rules; macOS configuration profiles. Disable autorun/autoplay. Block mass storage class entirely if business doesn't need it.

**4. EDR / device control** — Modern [[EDR]] (CrowdStrike, SentinelOne, Defender for Endpoint) inspect USB device class, vendor ID, product ID, and serial number. Allow-list approved devices by VID/PID. Alert on HID devices that suddenly appear and start typing. Block unknown mass storage outright.

**5. Encryption + DLP** — If users *must* use USB storage, force [[BitLocker]] To Go or equivalent so the drive is unreadable outside the enterprise. [[DLP]] inspects file movement to removable media and blocks classified data egress.

### What "good" USB policy looks like

- **Default-deny** for mass storage class on all corporate endpoints
- **Allow-list** of approved encrypted hardware (IronKey, Apricorn) by serial number
- **HID anomaly detection** in EDR — alert when a new HID enumerates and types more than N characters per second
- **Block USB network adapters** unless explicitly approved for that endpoint
- **No autoplay, no autorun** — registry enforced via GPO
- **Disable Thunderbolt DMA** at boot for laptops (`Kernel DMA Protection` on Windows)
- **Logging** — every USB insertion event ships to [[SIEM]] with VID, PID, serial, user, host

### Mapping to CompTIA vulnerability bullets

USB is the *delivery mechanism* for nearly every Domain 2 vulnerability:

- **Remote code execution** — Rubber Ducky launches PowerShell with `-EncodedCommand`, fetches stage-two payload
- **Privilege escalation** — USB-delivered binary exploits unpatched local kernel CVE
- **Persistent** access — dropper writes scheduled task or registry Run key
- **Insecure design** — environment that allows arbitrary USB devices on privileged workstations is broken by design, full stop
- **Security misconfiguration** — autorun enabled, USB ports unrestricted on DA workstations, no EDR device control
- **End-of-life components** — Windows 7 kiosk with no patches and an open USB port is a Stuxnet replay waiting to happen
- **Broken access control** — physical access to a USB port effectively bypasses logical authentication on most default OS configs

### CompTIA exam traps

> **CompTIA exam trap:** "An attacker plugged in a USB device and gained code execution within seconds. What was the most likely attack?" The right answer is **HID injection / BadUSB**, not "autorun malware." Autorun has been disabled by default on Windows since Vista/7 for USB. HID injection works on every modern OS because keyboards must work the moment they're plugged in — there's no patch for "your keyboard is allowed to type."

> **CompTIA exam trap:** Asked for the **best control** against malicious USB, candidates pick "user awareness training." Wrong on CySA+. The best technical control is **device control via EDR or GPO allow-listing by VID/PID/serial**. Training is a *layer*, not the answer. CompTIA wants technical mitigation when the question says "control."

> **CompTIA exam trap:** USB encryption (BitLocker To Go) is sometimes offered as the answer to "prevent malware from spreading via USB." Wrong. Encryption protects **data at rest if the drive is lost** — it does nothing to stop an attacker plugging in a malicious device. Encryption is a **confidentiality** control. Device control is the **malware** control. Don't conflate them.

> **CompTIA exam trap:** "Air-gapped network compromised — how?" If the question mentions a contractor, vendor, or maintenance laptop, the answer is **removable media (USB)**. Air gaps fail to USB, not to network attacks, by definition. Stuxnet is the canonical example CompTIA expects you to know.

### Incident response when USB is suspected

Follow CompTIA's four-phase lifecycle:

1. **Preparation** — Device control policy live, EDR collecting USB events, [[chain of custody]] forms ready, IR playbook includes "physical media" branch
2. **Detection and Analysis** — EDR alert on unknown HID, mass storage insertion on restricted host, or anomalous process spawn within seconds of USB event. Pull the USB event log (VID/PID/serial/timestamp/user)
3. **Containment, Eradication, and Recovery** — Isolate the host on the network, **do not yank the USB device** (preserve evidence and live state for forensics), image the host, image the USB device with a write blocker, identify what executed, reset credentials touched by that session
4. **Post-incident Activity** — Root cause: how did the device get in? Reception? Mailroom? Insider? Tune EDR rules, update physical security, run a tabletop on USB drop tests

The write blocker on the USB device is non-negotiable. Plugging the suspect drive into an analyst workstation to "just look" is how junior analysts trigger the second-stage payload and burn the evidence.

## SOC reality

- The 3am alert reads: `HID device enumerated on HOST-FIN-04; 847 keystrokes in 2.1 seconds; parent process: explorer.exe → powershell.exe -enc <base64>`. That's a Rubber Ducky. Containment call goes out before you finish decoding the base64.
- L1's first move: isolate the host via EDR network containment, *do not log the user out* (preserves volatile memory), notify L2, ticket the physical security team to pull badge logs for that workstation in the last hour.
- The CISO asks three questions in this order: "Was anything exfiltrated? Was the credential cached on that host privileged? Is the device still plugged in?" Have answers ready.
- Never promise "we caught it in time" until you've confirmed no outbound C2 traffic from the host post-insertion. The Ducky takes 2 seconds; the beacon to attacker infrastructure can be sub-second. *Detection-time speed is not containment-time speed.*
- Handoff path: L1 isolates → L2 confirms scope and pulls the EDR timeline → IR lead owns the host imaging and USB device acquisition → physical security pulls camera footage → legal gets looped if the device came from outside the org (mail, drop, vendor).
- The dirty secret: most orgs only learn they have a USB problem when somebody runs a red team drop test and 4 out of 10 devices come back beaconing within an hour. *Run the drop test before the adversary does.*

## Related concepts

[[EDR]] · [[DLP]] · [[BitLocker]] · [[BadUSB]] · [[HID injection]] · [[Removable media policy]] · [[Air gap]] · [[Stuxnet]] · [[Chain of custody]] · [[Write blocker]] · [[Physical security]] · [[Endpoint hardening]] · [[Group Policy]] · [[SIEM]] · [[Insecure design]] · [[Security misconfiguration]] · [[Remote code execution]] · [[Privilege escalation]]

*Source: VIRGIL knowledge base — 2026-05-11*