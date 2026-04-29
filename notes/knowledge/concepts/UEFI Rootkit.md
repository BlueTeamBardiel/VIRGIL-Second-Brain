# UEFI Rootkit

## What it is
Like a parasite that hides inside a pacemaker rather than the patient's bloodstream — where no surgery can reach it — a UEFI rootkit embeds malicious code directly into the motherboard's firmware. It executes before the OS, bootloader, or any security tool ever loads, making it nearly invisible to traditional detection methods.

## Why it matters
In 2018, security researchers discovered **LoJax**, the first in-the-wild UEFI rootkit, deployed by the APT28 (Fancy Bear) threat group against European government targets. Even after victims wiped their hard drives and reinstalled Windows, the rootkit survived untouched in SPI flash memory, re-infecting the system on every boot cycle.

## Key facts
- UEFI rootkits persist in **SPI flash memory** on the motherboard itself — not on the hard drive — meaning disk wipes and OS reinstalls do not remove them
- They bypass **Secure Boot** if attackers can disable it, exploit a firmware vulnerability, or obtain a stolen signing key
- Detection requires specialized tools like **CHIPSEC** (open-source firmware security framework) or vendor firmware integrity checks, since antivirus operates at the OS layer — far too late
- Remediation typically requires **reflashing the firmware** using a known-good vendor image, or in severe cases, physical motherboard replacement
- **Intel Boot Guard** is a hardware-level defense that cryptographically locks firmware at manufacturing time, preventing unauthorized modification even with physical access

## Related concepts
[[Secure Boot]] [[Bootkit]] [[Firmware Security]] [[Persistence Mechanisms]] [[APT (Advanced Persistent Threat)]]