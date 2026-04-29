# PAM

## What it is
Think of PAM like a bouncer at a club who doesn't just check your ID once — he checks it at the door, again at the VIP section, and again at the bar, using whatever credential system the club owner decides (wristband, stamp, or phone app). Privileged Access Management (PAM) is a security framework that controls, monitors, and audits access to high-value accounts — think domain admins, root accounts, and service accounts — enforcing least privilege and just-in-time access for users who need elevated permissions.

## Why it matters
In the 2020 SolarWinds breach, attackers moved laterally by harvesting privileged credentials that were overly permissive and poorly monitored. A mature PAM solution with session recording and credential vaulting would have flagged anomalous admin activity and prevented attackers from reusing standing privileges across systems for months undetected.

## Key facts
- PAM vaults store privileged credentials encrypted and rotate them automatically, so humans never see the actual password
- **Just-in-time (JIT) access** grants elevated privileges only for a defined window, then revokes them — eliminating standing admin accounts
- Session recording provides a full audit trail of privileged activity, critical for forensic investigation and compliance (PCI-DSS, HIPAA)
- PAM differs from IAM: IAM handles all user identities; PAM specifically governs *privileged* accounts (admins, service accounts, shared accounts)
- Common PAM tools include CyberArk, BeyondTrust, and Delinea — all commonly referenced in enterprise security architecture discussions
- Credential vaulting + MFA on privileged accounts is a top mitigation for ransomware lateral movement per CISA advisories

## Related concepts
[[Least Privilege]] [[Identity and Access Management]] [[Just-in-Time Access]] [[Credential Stuffing]] [[Zero Trust Architecture]]