# firewall

## What it is
Like a bouncer at a club checking IDs against a guest list, a firewall inspects network traffic and decides what gets in or out based on a defined ruleset. It is a network security device (hardware or software) that monitors and filters traffic between networks using rules based on IP addresses, ports, protocols, and state. Modern stateful firewalls track the full context of a connection, not just individual packets.

## Why it matters
In 2016, the Bangladesh Bank heist succeeded partly because their network lacked a proper firewall separating the SWIFT payment terminal from the broader network — attackers pivoted freely once inside. A properly configured firewall with deny-by-default rules and network segmentation would have contained the breach and blocked unauthorized outbound SWIFT transactions. This illustrates why firewall placement and rule hygiene are as important as having one at all.

## Key facts
- **Stateful vs. Stateless**: Stateful firewalls track TCP session state (SYN, SYN-ACK, ACK) and block unsolicited inbound packets; stateless firewalls filter each packet in isolation — stateless is faster but easier to spoof.
- **Default-deny (implicit deny)**: Best practice is to block all traffic by default and explicitly allow only what's needed — rules are read top-to-bottom, first match wins.
- **Next-Generation Firewalls (NGFW)**: Add Layer 7 deep packet inspection, application awareness, IPS integration, and user identity tracking beyond traditional port/protocol filtering.
- **DMZ architecture**: Firewalls are used to create a demilitarized zone, placing public-facing servers between two firewalls — one facing the internet, one protecting the internal network.
- **Egress filtering**: Blocking suspicious outbound traffic prevents data exfiltration and C2 callback connections — often overlooked compared to ingress filtering.

## Related concepts
[[network segmentation]] [[intrusion prevention system]] [[DMZ]] [[packet filtering]] [[stateful inspection]]