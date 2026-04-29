# Pass-the-Ticket

## What it is
Like stealing a theme park wristband off someone's arm and wearing it yourself to ride every attraction without buying a ticket — Pass-the-Ticket is an attack where a threat actor steals a Kerberos ticket (TGT or service ticket) from memory and reuses it to authenticate as the victim without ever knowing their password.

## Why it matters
In the 2020 SolarWinds breach, attackers operating inside Microsoft environments used Golden Ticket attacks (a Pass-the-Ticket variant) to forge Kerberos tickets and move laterally across networks for months undetected. Defenders can counter this by monitoring for event IDs 4768, 4769, and 4771 in Windows Security logs, and by limiting the lifetime of Kerberos tickets via Group Policy.

## Key facts
- Kerberos tickets are extracted from LSASS memory using tools like **Mimikatz** (`sekurlsa::tickets`) and injected into a session using `kerberos::ptt`
- A **TGT (Ticket Granting Ticket)** allows impersonation across many services; a **service ticket** grants access to only one specific resource
- **Golden Ticket** = forged TGT using the KRBTGT account hash; **Silver Ticket** = forged service ticket using a service account hash — both are Pass-the-Ticket variants
- Tickets remain valid even after a password change unless the **KRBTGT account password is reset twice**
- Mitigations include enabling **Protected Users Security Group**, enforcing **Credential Guard**, and setting short Kerberos ticket lifetimes (default is 10 hours)

## Related concepts
[[Kerberos Authentication]] [[Golden Ticket Attack]] [[Pass-the-Hash]] [[Lateral Movement]] [[LSASS Memory Dumping]]