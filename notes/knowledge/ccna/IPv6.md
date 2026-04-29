# IPv6

## What it is
Think of IPv4 addresses like old-style 7-digit phone numbers — a city ran out, so everyone switched to 10-digit numbers with area codes. IPv6 is the 128-bit successor to IPv4's 32-bit addressing scheme, providing approximately 340 undecillion unique addresses. It uses colon-separated hexadecimal notation (e.g., `2001:0db8:85a3::8a2e:0370:7334`) and was designed to solve address exhaustion while building in features IPv4 had to bolt on later.

## Why it matters
Many enterprise networks run **dual-stack** configurations — both IPv4 and IPv6 simultaneously — but security tools and firewalls are often configured only to inspect IPv4 traffic. Attackers exploit this blind spot by tunneling malicious traffic inside IPv6 packets (or using transition mechanisms like Teredo and 6to4) to bypass IPv4-focused intrusion detection systems. This is why auditors explicitly check whether security controls enforce parity across both protocol stacks.

## Key facts
- IPv6 has **128-bit addresses**, yielding ~3.4×10³⁸ possible addresses versus IPv4's ~4.3 billion
- **IPsec is natively built into IPv6** (mandatory in the original spec, now optional in practice), unlike IPv4 where it was retrofitted
- The **link-local address** (`fe80::/10`) is automatically assigned to every IPv6 interface and never routed — useful for neighbor discovery but a common recon vector
- **NDP (Neighbor Discovery Protocol)** replaces ARP in IPv6 and is vulnerable to similar spoofing attacks (NDP spoofing ≈ ARP poisoning)
- The `::1` address is the IPv6 **loopback**, equivalent to IPv4's `127.0.0.1`

## Related concepts
[[ARP Poisoning]] [[Dual-Stack Networks]] [[IPsec]] [[Network Address Translation]] [[Firewall Rules]]