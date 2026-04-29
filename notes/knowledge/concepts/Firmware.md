# firmware

## What it is
Think of firmware as the sheet music permanently printed inside a piano — the instrument can't play without it, and changing it requires more than just pressing keys. Firmware is low-level software embedded in non-volatile memory (ROM, EEPROM, or flash) that provides hardware devices with their fundamental operating instructions, sitting below the OS but above raw silicon.

## Why it matters
In 2015, researchers demonstrated "Equation Group" implants that rewrote hard drive firmware across dozens of manufacturers — giving attackers persistence that survived full OS reinstalls and disk wipes. This is the nightmare scenario: compromise below the OS level means antivirus, EDR, and even Secure Boot cannot see or stop the threat.

## Key facts
- Firmware attacks are **especially dangerous** because they persist through reimaging and can survive factory resets on many devices
- **UEFI/BIOS firmware** is a primary target; Secure Boot is designed to prevent unauthorized firmware from executing during startup
- The **NIST SP 800-193** standard provides guidelines for firmware resilience: protection, detection, and recovery
- Firmware vulnerabilities are patched via **vendor-issued updates** — but many organizations neglect this attack surface compared to OS patching
- **Supply chain attacks** can embed malicious firmware before a device ever reaches the customer (e.g., compromised network equipment shipped pre-backdoored)

## Related concepts
[[UEFI]] [[Secure Boot]] [[supply chain attacks]] [[rootkits]] [[hardware security modules]]