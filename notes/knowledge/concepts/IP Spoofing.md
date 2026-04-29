# IP Spoofing

## What it is
Like sending a letter with a forged return address, IP spoofing is the deliberate falsification of the source IP address in a packet header to impersonate another host or conceal the attacker's identity. The receiving system processes the packet as if it originated from the forged address, with replies going to the victim instead of the attacker.

## Why it matters
IP spoofing is the engine behind volumetric DDoS amplification attacks. In a DNS amplification attack, an attacker spoofs the victim's IP address and sends small queries to open resolvers; each resolver sends a response 50–70x larger back to the victim, overwhelming their bandwidth without the attacker ever receiving the traffic.

## Key facts
- Spoofing is most effective on **connectionless protocols (UDP)** because TCP's three-way handshake requires the attacker to receive the SYN-ACK, making blind TCP spoofing extremely difficult on modern networks
- **Ingress filtering (BCP38/RFC 2827)** is the primary network-level countermeasure — routers drop packets whose source IP doesn't match the expected upstream subnet
- Spoofed packets cannot complete authenticated sessions (TLS, SSH) because the attacker never receives the server's response traffic
- **Blind spoofing** occurs when the attacker sends packets without seeing replies; **non-blind spoofing** occurs when the attacker is on the same network segment and can sniff traffic
- IPsec with source authentication (AH header) cryptographically defeats IP spoofing by verifying packet origin at the network layer

## Related concepts
[[DDoS Amplification]] [[Ingress Filtering]] [[TCP Three-Way Handshake]] [[Smurf Attack]] [[IPsec]]