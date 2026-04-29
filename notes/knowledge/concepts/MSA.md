# MSA

## What it is
Like a master key that opens every lock in a building — a Managed Service Account (MSA) is a special Active Directory account type designed to run Windows services automatically, with passwords managed and rotated by the domain itself, requiring zero human intervention.

## Why it matters
In the 2020 SolarWinds attack, compromised service accounts with overprivileged, static credentials allowed attackers to move laterally undetected for months. Had MSAs been used instead of traditional service accounts, the automatic password rotation and scoped permissions would have significantly reduced the attackers' window of opportunity and limited credential reuse across systems.

## Key facts
- **Two flavors exist**: Managed Service Accounts (MSA, tied to a single host) and Group Managed Service Accounts (gMSA, usable across multiple servers) — gMSA requires a Key Distribution Service (KDS) root key
- **Passwords auto-rotate every 30 days** by default, managed entirely by Active Directory — admins never know or set the password
- **Cannot be used for interactive logon** — this is a security feature, not a limitation; it prevents the account from being used to log into workstations interactively
- **MSAs are tied to specific machines** via their Service Principal Name (SPN), preventing credential reuse on unauthorized systems
- **gMSAs require Windows Server 2012 domain functional level** or higher — a common exam trap when asked about prerequisites

## Related concepts
[[Service Principal Name (SPN)]] [[Active Directory]] [[Privilege Escalation]] [[Kerberoasting]] [[Least Privilege]]