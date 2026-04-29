# DCSync Attack

## What it is
Imagine impersonating a branch bank and calling the Federal Reserve, saying "Hey, send me a copy of all your account records for synchronization" — and the Fed just... complies. DCSync is exactly that: an attacker with sufficient Active Directory privileges abuses the legitimate Directory Replication Service (DRS) protocol to request password hashes directly from a Domain Controller, without ever touching the DC's file system or running code on it.

## Why it matters
In the 2020 SolarWinds compromise, attackers who gained footholds in victim networks used DCSync-style techniques to harvest Domain Admin credentials, enabling lateral movement across entire enterprise environments. Defenders who monitor for non-DC machines issuing `GetNCChanges` replication requests can catch this attack before credentials are weaponized — making replication traffic auditing a critical detection control.

## Key facts
- **Required permissions:** Requires `Replicating Directory Changes` and `Replicating Directory Changes All` rights — typically held by Domain Admins, Domain Controllers, and Azure AD Connect service accounts.
- **No malware on DC needed:** The attack runs entirely from an attacker-controlled machine using tools like Mimikatz (`lsadump::dcsync`) or Impacket's `secretsdump.py`.
- **What it extracts:** NTLM hashes, Kerberos keys (AES/RC4), and even the `krbtgt` hash — enabling Golden Ticket attacks.
- **Detection signature:** Legitimate replication occurs *between* Domain Controllers only; a workstation or member server issuing `MS-DRSR GetNCChanges` RPC calls is a high-fidelity alert.
- **Mitigation:** Apply the principle of least privilege on AD replication permissions; monitor Event ID 4662 (filtered for replication GUIDs) and use tools like Microsoft Defender for Identity to alert on anomalous replication requests.

## Related concepts
[[Pass-the-Hash]] [[Golden Ticket Attack]] [[Kerberoasting]] [[Active Directory Privilege Escalation]] [[NTLM Authentication]]