# Network protocols

## What it is
Think of network protocols like the rules of diplomatic correspondence between nations — both parties must agree on language, format, and procedure before any message means anything. Precisely, a network protocol is a standardized set of rules governing how data is formatted, transmitted, and received between devices across a network. Without these agreed-upon rules, two systems exchanging bytes would produce only noise.

## Why it matters
In 2014, attackers exploited weaknesses in the **SSLv3** protocol (the POODLE attack), forcing browsers to downgrade from TLS to the older, broken protocol — then decrypting supposedly secure traffic. This is a textbook example of a **protocol downgrade attack**, where the vulnerability isn't in the implementation but in the protocol's design itself. Defenders responded by disabling SSLv3 entirely across servers.

## Key facts
- **TCP** guarantees delivery via three-way handshake (SYN → SYN-ACK → ACK); **UDP** sacrifices reliability for speed — both are exploitable (SYN flood targets TCP's handshake)
- **ICMP** carries no payload data but is weaponized in ping floods, Smurf attacks, and used for covert **tunneling** of data out of networks
- **DNS (port 53)** operates over UDP by default; attackers abuse it for data exfiltration and C2 communication because it's rarely blocked at firewalls
- Protocol layers matter for the Security+ exam: attacks at Layer 2 (ARP spoofing), Layer 3 (IP spoofing), Layer 4 (session hijacking), and Layer 7 (HTTP injection) each require different defenses
- **Cleartext protocols** (Telnet port 23, FTP port 21, HTTP port 80) transmit credentials in the open — always flag these as findings during network assessments

## Related concepts
[[TCP/IP Model]] [[DNS Security]] [[SSL TLS]] [[Packet Analysis]] [[Firewall Rules]]