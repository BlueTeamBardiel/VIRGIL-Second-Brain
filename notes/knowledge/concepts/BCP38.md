# BCP38

## What it is
Like a post office that refuses to mail letters claiming to be from an address in Paris when you're clearly standing in Tokyo, BCP38 is a network filtering standard that requires ISPs to block outbound packets whose source IP addresses don't belong to that ISP's allocated address space. Formally defined in RFC 2827, it's an ingress filtering best practice designed to prevent IP source address spoofing at the network edge.

## Why it matters
Amplification DDoS attacks — like DNS, NTP, and SSDP reflection attacks — depend entirely on the attacker spoofing the victim's IP address as the packet source, so that massive response traffic gets redirected toward the target. If BCP38 were universally adopted, the attacker's ISP would drop those spoofed packets before they ever left the originating network, making reflection attacks effectively impossible. The 2013 Spamhaus attack (~300 Gbps via DNS amplification) could have been neutered at the source with proper BCP38 implementation.

## Key facts
- BCP38 is implemented via **egress/ingress filtering** on routers — typically using ACLs or Unicast Reverse Path Forwarding (uRPF)
- It requires ISPs to only allow outbound packets with source IPs from their **own assigned prefixes** (often called "network edge filtering")
- Adoption is voluntary and remains **incomplete globally**, which is why spoofing-based attacks persist
- **uRPF strict mode** checks that the source address is reachable via the interface the packet arrived on — this is the technical enforcement mechanism
- BCP38 protects the *internet at large*, not just the implementing ISP — making it a classic **collective action problem** (you pay the cost, others get the benefit)

## Related concepts
[[DNS Amplification Attack]] [[IP Spoofing]] [[Unicast Reverse Path Forwarding]] [[DDoS Mitigation]] [[BCP84]]