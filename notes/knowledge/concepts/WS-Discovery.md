# WS-Discovery

## What it is
Like a town crier shouting "Any printers nearby? Any cameras?" into a neighborhood — WS-Discovery (Web Services Dynamic Discovery) is a multicast protocol that lets devices on a local network automatically announce and find each other's services without manual configuration. It operates over UDP port 3702, broadcasting queries so devices like IP cameras and printers can be located without a central directory.

## Why it matters
In 2019, attackers weaponized WS-Discovery as a massive DDoS amplification vector — sending a small spoofed UDP probe to port 3702 could return a response up to 75x larger, making it one of the most powerful reflection/amplification attacks observed that year. Exposed IoT devices and network cameras became unwitting amplifiers, flooding victims with gigabits of traffic from what appeared to be legitimate device responses. Network defenders now block or filter UDP 3702 at perimeter firewalls to prevent their infrastructure from being conscripted.

## Key facts
- Operates over **UDP port 3702** using multicast addresses (239.255.255.250 for IPv4)
- Used primarily by **UPnP-adjacent IoT devices**: IP cameras (especially Hikvision/Dahua), printers, and Windows machines
- Amplification factor can reach **75:1**, making it highly efficient for reflection DDoS attacks
- The protocol is part of the **OASIS WS-Discovery standard**, also integrated into Windows (used for network device discovery in File Explorer)
- Mitigation: **block/rate-limit UDP 3702 at network egress**; devices should not be internet-exposed on this port

## Related concepts
[[UDP Amplification Attack]] [[DDoS Reflection]] [[UPnP]] [[IoT Security]] [[Network Reconnaissance]]