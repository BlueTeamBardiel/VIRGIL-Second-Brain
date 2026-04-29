# Hot Standby Routing Protocol

## What it is
Like a cockpit with a pilot and co-pilot where the co-pilot instantly grabs the controls if the pilot becomes incapacitated, HSRP is a Cisco proprietary First Hop Redundancy Protocol (FHRP) that assigns a virtual IP and MAC address to a group of routers, with one active router handling traffic while standby routers monitor and take over seamlessly if the active fails. End devices point to the virtual IP as their default gateway without ever knowing a failover occurred.

## Why it matters
An attacker on the local network can send crafted HSRP Hello packets with a higher priority value than the legitimate active router, causing their machine to win the active role — a classic man-in-the-middle pivot that redirects all default gateway traffic through an attacker-controlled device. This HSRP hijacking attack can be mitigated by configuring MD5 authentication on HSRP groups, forcing routers to validate the source of Hello packets before accepting priority changes.

## Key facts
- HSRP uses UDP port **1985** and multicast address **224.0.0.2** for Hello messages between group members
- Default Hello timer is **3 seconds**; hold timer is **10 seconds** before failover triggers
- HSRP versions: **v1** supports groups 0–255; **v2** extends to 0–4095 and uses multicast **224.0.0.102**
- The virtual MAC address format for HSRPv1 is **0000.0C07.ACxx** where *xx* is the group number in hex
- MD5 authentication (key-chain based) is the primary defense against HSRP spoofing/hijacking attacks; plain-text authentication exists but is trivially defeated

## Related concepts
[[Default Gateway Redundancy]] [[Man-in-the-Middle Attack]] [[Network Authentication Protocols]]