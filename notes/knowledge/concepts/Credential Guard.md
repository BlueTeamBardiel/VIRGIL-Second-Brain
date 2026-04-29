# Credential Guard

## What it is
Think of it as putting your house keys inside a bank vault *within* your house — even if a burglar breaks in, they can't reach the vault. Credential Guard is a Windows 10/11 and Server 2016+ feature that uses hardware-based virtualization (VBS — Virtualization-Based Security) to isolate the LSASS process and credential hashes in a separate, protected memory region called a Trustlet. Even a compromised OS kernel cannot directly read or extract secrets stored inside this isolated environment.

## Why it matters
Pass-the-Hash (PtH) attacks rely on tools like Mimikatz dumping NTLM hashes directly from LSASS memory in userspace. With Credential Guard enabled, those hashes are locked inside the virtualized secure enclave — Mimikatz returns empty or garbage results because the OS itself no longer has direct access to the plaintext credentials. This effectively kills the most common lateral movement technique on Windows enterprise networks.

## Key facts
- Requires **UEFI firmware**, **Secure Boot**, **64-bit CPU with virtualization extensions** (Intel VT-x / AMD-V), and **HVCI** support
- Protects **NTLM hashes, Kerberos TGTs, and cached domain credentials** stored by LSASS
- Does **NOT** protect credentials of locally logged-in users in real-time (e.g., a keylogger can still capture passwords being typed)
- Enabled via **Group Policy** → *Device Guard* settings, or through Windows Defender Security Center
- Credential Guard is **disabled by default** — organizations must explicitly configure and deploy it via GPO or MDM (e.g., Intune)

## Related concepts
[[Pass-the-Hash Attack]] [[LSASS Memory Dumping]] [[Virtualization-Based Security]] [[Kerberos]] [[Mimikatz]]