# BMC

## What it is
Think of it as a night watchman who never sleeps, watching over the building even when all the lights are off and everyone's gone home. A Baseboard Management Controller (BMC) is a dedicated microcontroller embedded on a server's motherboard that provides out-of-band management — letting administrators monitor hardware health, reboot systems, and access a console completely independently of the main OS.

## Why it matters
In 2019, researchers discovered the "iLO4" vulnerability in HPE's BMC implementation, allowing unauthenticated remote attackers to gain full control of servers — even powered-off ones — bypassing every OS-level security control entirely. Because the BMC runs its own firmware and network stack, a compromised BMC gives attackers persistent, invisible access that survives OS reinstalls, making it one of the most devastating footholds in enterprise environments.

## Key facts
- BMCs communicate via the **IPMI (Intelligent Platform Management Interface)** protocol, commonly over UDP port **623**
- The infamous **IPMI cipher suite 0 vulnerability** allows authentication bypass — an attacker can authenticate with *any* password when cipher 0 is selected
- BMC access is typically provided through vendor-specific interfaces: **iDRAC** (Dell), **iLO** (HPE), **IMM** (IBM/Lenovo)
- BMCs maintain access even when the host system is **powered off**, as long as the server has standby power — making network segmentation of the management interface critical
- Firmware implants in BMCs (e.g., **iLOBleed** malware) can survive full server wipes and OS reinstallations, qualifying as a **pre-OS persistent threat**

## Related concepts
[[IPMI]] [[Out-of-Band Management]] [[Firmware Security]] [[Supply Chain Attacks]] [[Privileged Access Workstations]]