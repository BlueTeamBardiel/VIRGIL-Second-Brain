# BGP hijacking

## What it is
Imagine the post office suddenly deciding all mail addressed to your bank should be rerouted through a warehouse in another country — that's BGP hijacking. It's an attack where a malicious or misconfigured Autonomous System (AS) broadcasts false routing information to BGP peers, causing internet traffic intended for a legitimate destination to be redirected through attacker-controlled infrastructure. This can result in traffic interception, blackholing, or surveillance at massive scale.

## Why it matters
In 2018, traffic from Amazon Route 53 DNS servers was hijacked by attackers who announced more-specific BGP routes, redirecting cryptocurrency wallet requests through servers they controlled — stealing roughly $150,000 in Ethereum. This demonstrates that BGP hijacking enables man-in-the-middle attacks at internet-scale without touching any endpoint device. Defenders respond by implementing RPKI (Resource Public Key Infrastructure) to cryptographically validate route origins.

## Key facts
- BGP (Border Gateway Protocol) is the routing protocol that connects Autonomous Systems across the internet and was designed for trust, not security
- **Route hijacking** occurs when an AS advertises a prefix it doesn't legitimately own; **route leak** occurs when valid routes are propagated beyond their intended scope
- RPKI (Resource Public Key Infrastructure) uses signed Route Origin Authorizations (ROAs) to validate that an AS is authorized to announce a specific IP prefix
- BGP hijacking can be **intentional** (nation-state interception) or **accidental** (misconfiguration — Pakistan Telecom took down YouTube globally in 2008)
- Detection tools like BGPmon and RIPE's RPKI validator help identify illegitimate route announcements in near-real-time

## Related concepts
[[Man-in-the-Middle Attack]] [[DNS Poisoning]] [[PKI]] [[Route Leak]] [[Autonomous System Security]]
