# Common Threat Vectors

## What it is

In Bloodborne, the threats don't just charge the front gate. A Brainsucker latches onto your skull from a side corridor and drains your Insight. A Winter Lantern in the Nightmare Frontier melts your sanity from across a foggy field. The Snatchers shove you in a sack and ship you to the Hypogean Gaol the moment your blood echoes hit a certain threshold. Each one is a different *route* to the same outcome: you die. That's exactly what threat vectors do — they are the distinct paths an attacker uses to reach and compromise a target.

A **threat vector** is the specific method or pathway by which a threat actor gains unauthorized access, delivers a payload, or exfiltrates data from a system or organization.

## Why it matters

If you don't enumerate the vectors, you can't defend the perimeter — and the perimeter no longer means a firewall. SY0-701 Objective **2.2** explicitly requires the candidate to "explain common threat vectors and attack surfaces," covering message-based, image-based, file-based, voice-call, removable-device, vulnerable-software, unsupported-systems, unsecure-network, open-service-port, default-credential, and supply-chain vectors. The classic CompTIA trap: confusing **threat vector** (the *path*) with **attack surface** (the sum of *exposed points*) and with **threat actor** (the *who*). Expect a scenario where you must pick the vector, not the actor or the vulnerability.

## Key facts

### Message-based vectors

| Vector | Mechanism | Primary defense |
|---|---|---|
| **Email** | [[Phishing]], [[Spear phishing]], malicious attachments, embedded links | [[SPF]], [[DKIM]], [[DMARC]], secure email gateway, user training |
| **SMS (smishing)** | Malicious links via text, often impersonating banks or carriers | Mobile threat defense, carrier filtering, awareness |
| **Instant messaging** | Slack, Teams, WhatsApp — link drops, malicious file shares | DLP integration, link sandboxing |

### Image-based vectors

- **[[Steganography]]** — payloads hidden in pixel data of PNG/JPG.
- **Malicious SVG** — SVGs are XML and can carry embedded JavaScript.
- **EXIF metadata abuse** — used for tracking and occasional payload smuggling.

### File-based vectors

- **Macro-enabled documents** (.docm, .xlsm) — VBA macros remain a top initial-access path.
- **PDF** — embedded JavaScript, malicious form actions, [[Living off the land]] launchers.
- **Archive smuggling** — password-protected ZIPs and ISOs to evade [[Mark of the Web]] and AV scanning.
- **LNK files** — Windows shortcuts pointing to PowerShell or rundll32.

### Voice call vectors

- **[[Vishing]]** — phone-based social engineering, often paired with caller-ID spoofing.
- **Help-desk impersonation** — attacker calls IT pretending to be an executive, or vice versa. Notable in recent ransomware intrusions.

### Removable device vectors

- **USB drop attacks** — staged in parking lots; user curiosity does the rest.
- **[[BadUSB]]** — firmware-level reprogramming so the device acts as a [[HID]] keyboard injecting commands.
- **Defense:** [[USB port control]], device control policies, disabling autorun, endpoint DLP.

### Vulnerable software vectors

| Software type | Risk |
|---|---|
| **Client-based** | Locally installed app with known [[CVE]]; patch lag exposes the host |
| **Agentless** | No installed agent — relies on credentials and network reachability; compromise of the management plane affects everything |

### Unsupported systems and applications

End-of-life OSes (Windows 7, Server 2012 R2 outside ESU) receive no patches. They become permanent footholds. Compliance frameworks ([[PCI DSS]], [[HIPAA]]) explicitly forbid them.

### Unsecure networks

- **Wireless** — rogue APs, [[Evil twin]], weak [[WPA2]]/open networks, [[KRACK]].
- **Wired** — unsecured switch ports, no [[802.1X]], no [[MAC filtering]].
- **Bluetooth** — [[Bluejacking]], [[Bluesnarfing]], [[BlueBorne]].

### Open service ports

Any listening service is a potential vector. Frequently abused:

| Port | Service | Why attackers love it |
|---|---|---|
| **22** | SSH | Credential brute force |
| **23** | Telnet | Cleartext, default creds |
| **445** | SMB | EternalBlue, lateral movement |
| **3389** | RDP | Brute force, [[BlueKeep]], ransomware initial access |
| **1433** | MSSQL | Weak SA passwords |
| **5900** | VNC | Often unauthenticated |

### Default credentials

Routers, IoT cameras, IPMI/iDRAC/iLO, databases shipped with `admin/admin` or `root/calvin`. Mirai botnet's entire business model.

### Supply chain vectors

- **Managed service providers ([[MSP]])** — compromise one MSP, reach hundreds of clients (Kaseya, SolarWinds).
- **Vendors** — third-party software updates as delivery mechanism ([[SolarWinds]] Orion).
- **Hardware** — implants or tampered firmware in transit.
- **Defense:** [[SBOM]], vendor risk assessments, code signing, [[Zero Trust]] for third-party access.

### Vector vs. surface vs. actor — the exam distinction

- **Threat actor** — the *who* (nation-state, insider, hacktivist).
- **Threat vector** — the *how/where* (email, USB, open RDP).
- **Attack surface** — the *total* of all reachable vectors.

## Related concepts

[[Attack surface]] · [[Threat actor]] · [[Phishing]] · [[Social engineering]] · [[Supply chain attack]] · [[Zero-day]] · [[Living off the land]] · [[Initial access]] · [[Lateral movement]] · [[Defense in depth]]

---
*Source: VIRGIL knowledge base — 2026-05-08*