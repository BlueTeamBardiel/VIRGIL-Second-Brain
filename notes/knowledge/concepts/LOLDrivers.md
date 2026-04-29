# LOLDrivers

## What it is
Like a corrupt security guard who uses their official badge to let thieves into the building, LOLDrivers (Living Off the Land Drivers) are legitimate, vendor-signed kernel drivers that attackers abuse to execute malicious code at the deepest level of the OS. These drivers are cryptographically signed by trusted vendors but contain known vulnerabilities that adversaries exploit to bypass security controls, disable EDR tools, or gain kernel-level privileges — all while appearing fully legitimate to the operating system.

## Why it matters
In the BlackByte ransomware campaign (2022), attackers dropped a known-vulnerable MSI AfterBurner graphics driver (`RTCore64.sys`) to kill EDR processes before deploying ransomware — a technique called Bring Your Own Vulnerable Driver (BYOVD). Because the driver was legitimately signed by MSI, Windows loaded it without complaint, and security tools couldn't block it through standard signature checks alone.

## Key facts
- **BYOVD (Bring Your Own Vulnerable Driver)** is the primary attack pattern: attacker drops a known-vulnerable signed driver onto the victim machine to gain kernel access
- The [loldrivers.io](https://www.loldrivers.io) project catalogs vulnerable, malicious, and known-abused drivers as a community defense resource
- Windows **Driver Signature Enforcement (DSE)** does NOT protect against LOLDrivers because the drivers ARE legitimately signed
- Attackers use vulnerable drivers to **terminate EDR/AV processes** from kernel space — a privilege user-space malware cannot achieve
- **Microsoft's Vulnerable Driver Blocklist** (enforced via HVCI / Memory Integrity) is the primary mitigation; enabling HVCI blocks many known-abused drivers from loading

## Related concepts
[[Living Off the Land (LOTL)]] [[Kernel Exploitation]] [[Endpoint Detection and Response (EDR)]] [[Bring Your Own Vulnerable Driver (BYOVD)]] [[Windows Driver Signature Enforcement]]