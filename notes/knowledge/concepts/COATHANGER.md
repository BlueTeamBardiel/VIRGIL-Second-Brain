# COATHANGER

## What it is
Like a hidden coat hook welded *inside the wall* rather than mounted on it, COATHANGER is a rootkit that embeds itself deep within a device's firmware, surviving reboots and factory resets. Specifically, it is a novel, persistent malware implant targeting Fortinet FortiGate SSL VPN appliances, attributed to Chinese state-sponsored threat actors (APT40/TEMP.Hex) and disclosed by Dutch intelligence (MIVD/AIVD) in February 2024.

## Why it matters
In 2023, Chinese actors exploited CVE-2022-42475 (a critical heap buffer overflow in FortiOS) to deploy COATHANGER against the Dutch Ministry of Defence network. Because the implant survives firmware updates by hooking low-level system calls and re-injecting itself during boot, standard incident response — patching, rebooting, even factory resets — failed to evict it without hardware-level intervention.

## Key facts
- **Persistence mechanism:** Overwrites the legitimate `busybox` binary and hooks system calls so it reloads automatically after reboot or firmware flash
- **Initial access vector:** Exploited CVE-2022-42475 (CVSS 9.3), a pre-authentication RCE vulnerability in Fortinet FortiOS SSL-VPN
- **Attribution:** Linked to Chinese state-sponsored espionage; MIVD assessed it was used for persistent access to defense-sector targets
- **Detection difficulty:** Hides processes and files from the OS; standard `ps`, `ls`, and log review are unreliable without integrity checking tools
- **Remediation:** Requires replacing the physical hardware or performing a verified clean-image reinstallation with cryptographic integrity validation — patching alone is insufficient

## Related concepts
[[Rootkit]] [[Firmware Persistence]] [[CVE-2022-42475]] [[Advanced Persistent Threat]] [[Network Appliance Security]]