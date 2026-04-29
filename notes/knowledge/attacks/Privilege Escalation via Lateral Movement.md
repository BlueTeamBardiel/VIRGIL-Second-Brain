# Privilege Escalation via Lateral Movement

## What it is
Like a hotel burglar who steals a housekeeper's master key rather than breaking through every individual door, an attacker uses compromised low-privilege credentials to move sideways across systems, harvesting increasingly powerful access until they own the domain. Technically, it is the combination of lateral movement (traversing systems using valid credentials or exploits) with privilege escalation (gaining higher-level permissions on each new system reached), forming a compounding attack chain.

## Why it matters
During the 2020 SolarWinds breach, attackers moved laterally from compromised build systems into customer networks using forged SAML tokens (a "Golden SAML" attack), escalating from on-premises Active Directory access to cloud admin privileges in Microsoft 365 — all while appearing as legitimate authenticated users. Defenders who monitored only perimeter traffic missed the internal east-west movement entirely.

## Key facts
- **Pass-the-Hash (PtH)**: Attackers reuse NTLM credential hashes without knowing the plaintext password, enabling lateral movement across Windows systems sharing the same local admin credentials
- **Kerberoasting**: A low-privilege domain user requests service tickets, cracks them offline, and gains service account credentials — which often have elevated rights
- **Least Privilege + Network Segmentation** are the primary defensive controls; they limit both the reach of lateral movement and the privileges available to harvest
- **Local Administrator Password Solution (LAPS)** directly counters PtH by randomizing local admin passwords per machine, breaking the credential reuse chain
- On Security+/CySA+, lateral movement is classified under **TA0008** in the MITRE ATT&CK framework, distinct from but linked to privilege escalation (TA0004)

## Related concepts
[[Pass-the-Hash Attack]] [[Kerberoasting]] [[MITRE ATT&CK Framework]] [[Credential Dumping]] [[Zero Trust Architecture]]