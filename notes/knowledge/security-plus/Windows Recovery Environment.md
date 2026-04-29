# Windows Recovery Environment

## What it is
Think of WinRE as the emergency generator room in a hospital — it kicks on when the main power (Windows) fails, giving technicians access to critical systems outside normal operations. Windows Recovery Environment (WinRE) is a minimal recovery OS built on Windows PE that launches automatically when Windows fails to boot, providing diagnostic and repair tools outside the normal OS context.

## Why it matters
Attackers with physical access can boot into WinRE to bypass Windows authentication entirely — a classic technique involves using WinRE's command prompt to replace `sethc.exe` (Sticky Keys) with `cmd.exe`, granting a SYSTEM-level shell on the login screen without any credentials. Defenders counter this by enabling BitLocker full-disk encryption, which requires a recovery key before WinRE can access the drive contents.

## Key facts
- WinRE is stored in a hidden partition (typically ~500MB) separate from the main Windows installation, labeled as a Recovery Partition
- It can be accessed by pressing F8/F11 at boot, or triggers automatically after two consecutive failed boots
- WinRE includes tools like `bootrec.exe`, `diskpart`, Startup Repair, and System Restore — all operable without a Windows login
- Because WinRE runs outside the normal OS, **Bitlocker is the primary control** that prevents unauthorized use of these tools for credential bypass attacks
- Administrators can disable or restrict WinRE using `reagentc /disable` to reduce the attack surface on high-security systems

## Related concepts
[[BitLocker]] [[Preboot Authentication]] [[Credential Bypass Techniques]] [[Trusted Platform Module (TPM)]]