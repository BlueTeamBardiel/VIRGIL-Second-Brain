# Golden Ticket Attack

## What it is
Imagine stealing the master key to a hotel — not a room key, but the machine that *makes* keys — so you can forge access cards for any room forever. A Golden Ticket attack does exactly this in Active Directory: by extracting the NTLM hash of the **KRBTGT account** (Kerberos Ticket Granting Ticket account), an attacker can forge valid Kerberos TGTs for any user, including domain admins, with arbitrary lifetimes.

## Why it matters
In the 2020 SolarWinds breach, attackers who achieved domain controller access could have leveraged Golden Tickets to maintain persistent, nearly invisible access even after password resets — because the forged tickets bypass normal authentication checks entirely. Defenders must reset the KRBTGT password **twice** (due to its previous-password retention) to invalidate all forged tickets.

## Key facts
- Requires prior compromise of a **Domain Controller** to extract the KRBTGT hash — this is a post-exploitation persistence technique, not an initial access method
- Forged tickets can be crafted with **10+ year lifetimes**, surviving normal Kerberos policy enforcement
- Detection relies on anomaly detection: look for TGTs with unusually long lifetimes or tickets referencing **non-existent users** (a telltale forgery indicator)
- The attack abuses the fact that domain controllers **do not verify** that a TGT was legitimately issued — they only check the KRBTGT signature
- Mitigation requires resetting KRBTGT password twice (24+ hours apart), enforcing **Protected Users security group**, and monitoring Event ID **4769** (Kerberos service ticket requests) for anomalies

## Related concepts
[[Kerberos Authentication]] [[Pass-the-Hash Attack]] [[Silver Ticket Attack]] [[Active Directory Privilege Escalation]] [[Mimikatz]]