# Hot Standby Routing Protocol (HSRP)

## What it is

In *Witcher 3*, when Geralt drinks a Swallow potion mid-fight and it runs out, his second potion slot kicks in automatically — the healing keeps flowing, the drowners keep dying, and Geralt never breaks rhythm. HSRP works the same way for routers. A group of routers share one virtual identity (a virtual IP and virtual MAC), and end devices only ever talk to that virtual identity. Behind the scenes, one physical router is "active" and actually forwarding packets. If it dies, a "standby" router silently takes over the virtual IP/MAC, and your laptop never knows the difference — its default gateway is still alive.

It's a Cisco-proprietary [[First Hop Redundancy Protocol]] (FHRP), meaning it solves the "what happens when the default gateway router explodes" problem at the very first hop out of your subnet.

## Why it matters

Your laptop hard-codes one default gateway IP. Without an FHRP, if that router dies, every device on the subnet is stranded until somebody reconfigures the gateway — like every player on a Counter-Strike 2 server losing connection because the host rage-quit. HSRP makes failover invisible: end devices keep ARPing for the same virtual IP, the standby router answers with the same virtual MAC, and traffic resumes in seconds.

The flip side: HSRP is a juicy attack surface. The protocol decides who's "active" based on a priority value sent in plaintext-ish Hello messages. An attacker on the LAN who can inject HSRP Hellos with a higher priority can hijack the active role — meaning every packet leaving the subnet now flows through the attacker's box. It's a man-in-the-middle dream scenario, basically a Watch Dogs 2 ctOS hack but on real network gear. This is why authentication isn't optional in any serious deployment.

## Key facts

### Core mechanics
- **Virtual IP + Virtual MAC**: the group shares both. End devices use the virtual IP as their default gateway and never see the real router IPs.
- **Active router**: forwards traffic for the virtual IP. Like the raid leader in an MMO — only one at a time, everyone else is on standby waiting for them to wipe.
- **Standby router(s)**: monitor the active router via Hellos, ready to take over.
- **Priority**: integer value; highest priority wins the active role. Default is 100. This is the knob attackers abuse.

### Timers and transport
- **UDP port 1985** — HSRP's dedicated channel.
- **Hello timer**: 3 seconds default. The "I'm still alive" heartbeat.
- **Hold timer**: 10 seconds default. If no Hello arrives within the hold timer, the active router is presumed dead and failover triggers. Like Among Us — if nobody's seen Red in 10 seconds, assume Red got got.

### Version differences
| | HSRPv1 | HSRPv2 |
|---|---|---|
| Group numbers | 0–255 | 0–4095 |
| Multicast address | 224.0.0.2 | 224.0.0.102 |
| Virtual MAC format | 0000.0C07.AC**xx** | 0000.0C9F.F**xxx** |

- The `xx` (v1) or `xxx` (v2) in the MAC is the HSRP group number in hex. Group 10 in HSRPv1 → MAC `0000.0C07.AC0A`.
- HSRPv2 exists largely because v1 ran out of group numbers and needed better support for IPv6 and millisecond timers.

### Security
- **The attack**: send crafted Hello packets with priority 255 (the max). The legitimate active router sees a higher-priority peer and steps down — you are now the gateway. Every outbound packet from the subnet hits your interface first. Classic on-path positioning.
- **MD5 authentication**: configured via key-chains in IOS. Hellos carry an MD5 hash; routers reject Hellos that don't match. Attackers without the key can't forge valid Hellos.
- **Plaintext authentication**: exists, but it's the equivalent of a "Keep Out" sign on a screen door. The "password" rides in cleartext inside the Hello — sniff once, replay forever. Don't use it.
- **Key-chain based MD5** also lets you rotate keys with overlap windows, so you can change credentials without dropping the HSRP relationship.

## Related concepts
- [[VRRP]] — the open-standard, non-Cisco equivalent
- [[GLBP]] — Cisco's load-balancing FHRP cousin
- [[First Hop Redundancy Protocols (FHRP)]]
- [[ARP spoofing]] — related on-path attack on the same LAN segment
- [[Default Gateway]]
- [[Multicast addressing]]
- [[MD5 authentication / key-chains]]
- [[Man-in-the-Middle attacks]]