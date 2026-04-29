# Windows Security

## What it is
Think of Windows Security like a castle with multiple defensive rings — a moat (firewall), guards at the gate (authentication), and interior patrols (antivirus/EDR) — each layer compensating when another fails. Windows Security is Microsoft's integrated security architecture encompassing authentication mechanisms, access controls, built-in defenses, and auditing capabilities within the Windows OS. It includes technologies like Windows Defender, BitLocker, UAC, and the Security Account Manager (SAM) working in concert.

## Why it matters
In the 2017 NotPetya attack, adversaries exploited EternalBlue (MS17-010) to compromise unpatched Windows systems, then used credential-harvesting tools like Mimikatz to extract NTLM hashes from LSASS memory — pivoting laterally across entire corporate networks. Organizations with properly configured Windows Security features like Credential Guard and timely patching were largely immune, demonstrating that layered Windows hardening directly determines blast radius.

## Key facts
- **UAC (User Account Control)** enforces least privilege by requiring explicit elevation for administrative tasks, reducing the attack surface of malware running as standard users
- **LSASS protection** via Credential Guard uses virtualization-based security (VBS) to isolate credential material, blocking tools like Mimikatz from dumping plaintext passwords
- **BitLocker** uses AES-256 with TPM binding, protecting data at rest against offline attacks (e.g., stolen laptops)
- **Windows Defender Credential Guard** requires UEFI, 64-bit OS, and Hyper-V support — not available on all hardware configurations (exam gotcha)
- **Security Account Manager (SAM)** stores local account password hashes; it is locked while Windows runs but attackable via VSS shadow copies or offline extraction

## Related concepts
[[NTLM Authentication]] [[Credential Harvesting]] [[Least Privilege]] [[BitLocker]] [[Endpoint Detection and Response]]