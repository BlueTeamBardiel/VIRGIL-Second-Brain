# Workstation Security

## What it is
Like locking your car, closing the windows, AND installing a GPS tracker — not just one measure but layered physical and logical controls applied to end-user machines. Workstation security is the practice of hardening desktop and laptop systems through configuration baselines, access controls, patching, and endpoint protections to reduce attack surface across the user layer of an organization.

## Why it matters
In 2017, the NotPetya worm propagated laterally across corporate networks by exploiting unpatched Windows workstations via EternalBlue (MS17-010). Organizations that enforced strict patch management and disabled SMBv1 on workstations survived largely intact, while those that didn't lost hundreds of millions of dollars in hours. A single unpatched endpoint became the door that opened the entire building.

## Key facts
- **Principle of Least Privilege (PoLP):** Standard users should never have local admin rights; this alone blocks most malware that requires elevated execution
- **Screen lock + inactivity timeout:** Required by most compliance frameworks (PCI-DSS, HIPAA); prevents physical shoulder-surfing and tailgating attacks against unattended machines
- **Full-disk encryption (e.g., BitLocker):** Protects data at rest if a laptop is stolen — without it, an attacker simply boots from USB to access the drive
- **Application whitelisting vs. blacklisting:** Whitelisting (allow-by-default-deny) is stronger than AV blacklisting because it blocks unknown/zero-day malware that hasn't been catalogued yet
- **Host-based firewall + EDR:** Workstations should run local firewalls and Endpoint Detection & Response tools to catch lateral movement even when perimeter defenses are bypassed

## Related concepts
[[Endpoint Hardening]] [[Patch Management]] [[Principle of Least Privilege]] [[Full-Disk Encryption]] [[Endpoint Detection and Response]]