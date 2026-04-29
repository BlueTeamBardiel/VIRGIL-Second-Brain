# Screen Lock

## What it is
Like a bank vault that automatically seals itself after the teller steps away, a screen lock automatically restricts access to a device after a defined period of inactivity, requiring authentication before use resumes. It is a preventive physical security control that prevents unauthorized access to an active session when a device is left unattended.

## Why it matters
In 2014, a journalist left their laptop unlocked at a conference; an attacker performed a "evil maid" style attack in minutes, exfiltrating credential files before the owner returned. A properly configured screen lock with a 5-minute timeout and strong PIN/password would have closed that window entirely — no malware, no network exploit required.

## Key facts
- **CompTIA Security+ objective**: Screen locks fall under mobile device management (MDM) and physical security controls; expect scenario questions pairing screen locks with **device encryption** as layered defenses
- **Timeout thresholds matter**: NIST SP 800-53 (AC-11) recommends automatic session lock after no more than **15 minutes** of inactivity for most federal systems
- **Bypass risks are real**: Cold boot attacks can sometimes extract memory contents even from locked screens if full-disk encryption is not also enabled
- **Authentication factors**: Screen locks may use PINs, passwords, biometrics, or patterns — pattern locks are statistically the weakest due to smudge attacks (fingerprint residue reveals the pattern)
- **MDM enforcement**: Enterprise MDM platforms (Intune, Jamf) can enforce minimum lock timeout and complexity remotely and report non-compliant devices

## Related concepts
[[Mobile Device Management]] [[Full-Disk Encryption]] [[Physical Security Controls]] [[Session Timeout]] [[Authentication Factors]]