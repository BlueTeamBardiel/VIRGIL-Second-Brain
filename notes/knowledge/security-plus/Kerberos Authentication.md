# Kerberos Authentication

## What it is
Think of Kerberos like a theme park wristband system: you show your ID once at the entrance booth, get a wristband (ticket), and use that wristband to access every ride without showing ID again. Formally, Kerberos is a network authentication protocol that uses symmetric-key cryptography and a trusted third party — the Key Distribution Center (KDC) — to authenticate users and services without transmitting passwords over the network. It operates on port 88 and is the default authentication protocol in Active Directory environments.

## Why it matters
Pass-the-Ticket attacks exploit Kerberos directly: an attacker who compromises a machine can steal Ticket Granting Tickets (TGTs) from memory using tools like Mimikatz and reuse them to authenticate as the victim user without ever knowing their password. This is why defenders monitor for anomalous ticket requests and why privileged accounts should have short ticket lifetimes. Golden Ticket attacks take this further — a compromised KDC allows forging tickets that grant unlimited domain access for up to 10 years.

## Key facts
- The KDC has two components: the **Authentication Server (AS)** and the **Ticket Granting Server (TGS)**
- Tickets have a default lifetime of **10 hours** and can be renewed for up to 7 days
- Kerberos requires **time synchronization** within 5 minutes — a clock skew beyond this causes authentication failure (exploitable via clock manipulation)
- **Mutual authentication**: both client and server verify each other's identity, preventing impersonation of services
- Kerberos is vulnerable to **AS-REP Roasting** when pre-authentication is disabled, allowing offline brute-force of user hashes without credentials

## Related concepts
[[Active Directory]] [[Pass-the-Hash]] [[Ticket Granting Ticket]] [[NTLM Authentication]] [[Privilege Escalation]]