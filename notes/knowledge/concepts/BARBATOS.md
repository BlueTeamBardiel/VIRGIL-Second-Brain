# LAB_HOST

## What it is
Like a master locksmith who doesn't just pick one lock but carries a skeleton key ring for every door in the building, LAB_HOST is a UEFI bootkit malware framework designed to bypass firmware-level security controls. It targets the UEFI (Unified Extensible Firmware Interface) to persist below the operating system, surviving reboots, OS reinstalls, and even hard drive replacements.

## Why it matters
In documented threat actor operations, LAB_HOST-style UEFI implants were used to maintain persistence on high-value targets where traditional endpoint detection tools were completely blind — because by the time Windows loaded, the malicious code was already in control. Defenders responding to incidents found clean hard drives but still-compromised machines, illustrating why firmware integrity verification (via Secure Boot and TPM attestation) is critical in enterprise environments.

## Key facts
- LAB_HOST operates at Ring -1 (firmware level), below Ring 0 (kernel), making it invisible to OS-based antivirus and EDR solutions
- It exploits vulnerabilities in UEFI firmware to write a persistent implant to the SPI flash chip on the motherboard
- Removal typically requires flashing the firmware — OS reinstallation or disk wiping is insufficient
- Detection methods include using tools like **CHIPSEC** or monitoring for unauthorized UEFI module additions via firmware integrity checks
- Associated with sophisticated APT (Advanced Persistent Threat) actors targeting espionage objectives, requiring physical or privileged firmware access for initial deployment

## Related concepts
[[UEFI Rootkit]] [[Secure Boot]] [[LoJax]] [[Bootkits]] [[Firmware Integrity]]