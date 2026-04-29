# BIOS

## What it is
Like a building's security guard who checks credentials before unlocking the front door each morning, the BIOS (Basic Input/Output System) is the firmware embedded in a chip on the motherboard that initializes hardware components and launches the bootloader before the operating system ever loads. It is the first code executed when a computer powers on, operating below the OS layer entirely.

## Why it matters
In 2015, the Equation Group's malware (linked to NSA tooling) demonstrated BIOS implants that survived OS reinstalls, hard drive replacements, and factory resets — because the malicious code lived in firmware the OS could never see or clean. This is why Secure Boot and UEFI firmware signing exist: to cryptographically verify that only trusted code runs at this privileged pre-OS layer.

## Key facts
- **BIOS vs UEFI**: Legacy BIOS uses 16-bit real mode and MBR boot; UEFI supports 64-bit, GPT partitions, Secure Boot, and a network stack — making it both more capable and a larger attack surface
- **Secure Boot** (a UEFI feature) uses a signature database (db) and forbidden signature database (dbx) to block unauthorized bootloaders — directly countering bootkits
- **BIOS passwords** only prevent unauthorized *configuration changes*, not physical attacks; an attacker with physical access can clear CMOS via jumper or battery removal
- **Persistence tier**: BIOS/UEFI implants are the most persistent threat tier — surviving reimaging, making firmware integrity tools (e.g., CHIPSEC) critical for forensic validation
- **Supply chain risk**: Malicious BIOS modifications can be introduced pre-delivery (interdiction attacks), which is why firmware signing and TPM attestation are supply-chain controls

## Related concepts
[[UEFI]] [[Secure Boot]] [[TPM]] [[Rootkit]] [[Supply Chain Attack]]