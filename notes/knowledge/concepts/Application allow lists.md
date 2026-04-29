# Application Allow Lists

## What it is
Like a bouncer with a clipboard who only lets in names already on the list — everyone else gets turned away regardless of how legitimate they look — an application allow list is a security control that permits only pre-approved software to execute on a system. Any executable, script, or library not explicitly authorized is blocked by default.

## Why it matters
During the 2020 SolarWinds supply chain attack, malicious code was injected into a legitimate, signed software update. A properly implemented allow list tied to cryptographic hash verification (not just file name or publisher) would have detected that the *specific binary* changed and blocked execution, even though the software appeared to come from a trusted vendor.

## Key facts
- **Default-deny posture**: contrasts sharply with blocklists, which default to allow — allow lists are far more resistant to zero-day malware since unknown executables are blocked outright
- **Enforcement mechanisms**: implemented via tools like Windows Defender Application Control (WDAC), AppLocker, or SELinux; can filter by file path, publisher certificate, or cryptographic hash
- **Hash-based rules are strongest** but high maintenance; publisher/certificate-based rules are easier to manage but vulnerable to compromised signing certificates
- **NIST SP 800-167** provides the authoritative guide for application allow listing in enterprise environments — referenced in Security+ and CySA+ objectives
- **Living-off-the-land (LotL) attacks** bypass naive allow lists by abusing already-approved system binaries like `powershell.exe` or `mshta.exe`, requiring additional controls like script block logging

## Related concepts
[[Default-deny security model]] [[Windows Defender Application Control]] [[Living off the land attacks]] [[Code signing]] [[Blocklisting]]