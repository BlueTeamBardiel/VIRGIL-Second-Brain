# PSAttack

## What it is
Like a lockpick set pre-loaded with the most common lock-bypass techniques, PSAttack is a pre-packaged offensive PowerShell framework that bundles popular attack modules into a single, ready-to-deploy toolkit. It is a portable, self-contained executable that combines multiple PowerShell-based offensive security modules (including components from PowerSploit and PowerTools) into one interface, specifically designed to evade common detection methods by encrypting its modules at rest.

## Why it matters
During a red team engagement, an attacker who lands on a Windows host can launch PSAttack without writing any PowerShell scripts to disk — the encrypted modules decrypt in memory at runtime, bypassing signature-based antivirus tools scanning for known malicious `.ps1` files. Defenders responding to an alert may see unusual process behavior from a standalone executable with no obvious malicious scripts on disk, making forensic attribution harder.

## Key facts
- PSAttack encrypts its bundled PowerShell modules to avoid static signature detection by antivirus solutions
- It operates as a compiled `.exe`, meaning it can execute PowerShell attack capabilities without dropping raw `.ps1` script files to disk (fileless-adjacent behavior)
- Incorporates modules for credential dumping, privilege escalation, and lateral movement — core post-exploitation phases in the cyber kill chain
- Detection relies on **behavioral analysis** and **script block logging** (PowerShell event ID 4104), not file-based signatures
- Enabling **Constrained Language Mode** in PowerShell and **AMSI (Antimalware Scan Interface)** significantly degrades PSAttack's effectiveness

## Related concepts
[[PowerShell Empire]] [[AMSI]] [[Fileless Malware]] [[Credential Dumping]] [[Script Block Logging]]