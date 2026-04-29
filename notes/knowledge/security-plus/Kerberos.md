# Kerberos

## What it is
Think of it like a concert venue: instead of showing your ID at every booth, you show it once at the entrance, get a wristband, and flash that wristband everywhere else. Kerberos is a network authentication protocol that uses time-stamped, encrypted tickets issued by a trusted third party (the Key Distribution Center) to prove identity without repeatedly transmitting passwords across the network.

## Why it matters
In a Pass-the-Ticket attack, an adversary steals a valid Kerberos Ticket Granting Ticket (TGT) from memory using tools like Mimikatz and uses it to request service tickets — gaining access to resources without ever knowing the user's password. This is why defenders monitor for anomalous ticket requests and why Microsoft introduced Protected Users security groups to limit ticket lifetime and caching.

## Key facts
- **Three components**: Key Distribution Center (KDC), Authentication Service (AS), and Ticket Granting Service (TGS) — the KDC contains both the AS and TGS
- **Default ticket lifetime** is 10 hours for TGTs; tickets are time-stamped and require clocks to be synchronized within **5 minutes** to prevent replay attacks
- **Port 88 UDP/TCP** — Kerberos traffic is identifiable on the network by this port
- **Kerberoasting** targets service accounts by requesting service tickets (TGS) for accounts with SPNs and cracking their encryption offline — no elevated privileges required to execute
- **Golden Ticket** attacks forge TGTs using the KRBTGT account's password hash, granting persistent, near-unlimited domain access that survives password resets for regular accounts

## Related concepts
[[Pass-the-Hash]] [[Active Directory]] [[Lateral Movement]]