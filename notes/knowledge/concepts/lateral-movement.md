# lateral-movement

## What it is
Like a thief who breaks into a hotel room and then uses a stolen master keycard to quietly slip into other rooms on the same floor, lateral movement is how an attacker expands access across a network after their initial foothold. Precisely: it is the set of techniques an adversary uses to progressively move through an environment, compromising additional systems and accounts to reach high-value targets like domain controllers or databases.

## Why it matters
In the 2020 SolarWinds breach, attackers didn't stop at their initial entry point — they used stolen SAML tokens to pivot from on-premises networks into Azure AD environments, reaching email systems and sensitive government data. Defenders who monitored only perimeter traffic missed the movement entirely because it used legitimate credentials and protocols. This is why behavioral analytics and east-west traffic monitoring are now considered essential controls.

## Key facts
- **Pass-the-Hash (PtH)** and **Pass-the-Ticket (PtT)** are the two canonical lateral movement techniques, abusing NTLM hashes and Kerberos tickets respectively without needing plaintext passwords
- **MITRE ATT&CK Tactic TA0008** catalogs lateral movement techniques including Remote Services, SMB/Windows Admin Shares, and WMI execution
- Attackers commonly abuse legitimate tools (LOLBins) like `PsExec`, `WMI`, and `RDP` to blend in with normal admin activity
- Detection relies heavily on identifying **unusual authentication patterns** — e.g., a service account suddenly logging into 15 workstations in 3 minutes
- Network segmentation and **least privilege** are the primary preventive controls; they limit blast radius even when one host is compromised

## Related concepts
[[credential-dumping]] [[pass-the-hash]] [[privilege-escalation]] [[network-segmentation]] [[MITRE-ATT&CK]]