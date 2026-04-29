# Windows 8

## What it is
Like a house that replaced its traditional deadbolt with a sleek touchscreen keypad but forgot to test it with burglars — Windows 8 is Microsoft's 2012 operating system that introduced a radically redesigned touch-first interface (Metro/Modern UI) while simultaneously overhauling its security architecture. It marked a significant departure from Windows 7, introducing Secure Boot, UEFI integration, and Windows Defender as a full antimalware suite by default.

## Why it matters
Windows 8 introduced **Secure Boot**, a UEFI feature that validates bootloader signatures before execution — directly countering bootkits like TDL4 that had plagued Windows 7 systems. An attacker targeting a Windows 8 machine could no longer silently implant a malicious bootloader without either disabling Secure Boot (requiring physical access or firmware exploits) or stealing a valid signing key.

## Key facts
- **Secure Boot (UEFI):** Prevents unsigned bootloaders from executing, blocking pre-OS malware like rootkits and bootkits at the firmware level
- **Windows Defender upgraded:** First Windows version to ship with full antivirus/antimalware built-in (incorporating Microsoft Security Essentials functionality), eliminating the "unprotected by default" gap
- **Early Launch Anti-Malware (ELAM):** Introduced a driver that loads before third-party drivers, allowing it to inspect and block malicious drivers at startup
- **Picture Password & PIN:** New authentication mechanisms introduced alongside traditional passwords — relevant to multi-factor and authentication policy discussions
- **End of Support:** Windows 8 mainstream support ended January 2016; extended support ended January 2016 as well — Windows 8.1 extended that to January 2023, making unpatched Windows 8 systems a high-risk legacy target
- **SmartScreen Filter** integrated at the OS level, not just the browser, providing application reputation checks before execution

## Related concepts
[[Secure Boot]] [[UEFI Security]] [[Early Launch Anti-Malware]] [[Windows Defender]] [[Rootkit]]