# HSRP

## What it is
Like a backup pilot sitting in the cockpit ready to grab the controls if the captain passes out, HSRP (Hot Standby Router Protocol) lets a secondary router silently monitor the primary and instantly take over if it fails. It's a Cisco proprietary First Hop Redundancy Protocol (FHRP) that presents a virtual IP and MAC address to end hosts, so the gateway never goes dark even when physical routers fail.

## Why it matters
An attacker on the local network can send crafted HSRP hello messages with a higher priority value, causing their machine to win the "active router" election and become the default gateway — a classic man-in-the-middle position that intercepts all outbound traffic before forwarding it upstream. This attack is trivial with tools like Yersinia and succeeds on networks that haven't enabled HSRP MD5 authentication.

## Key facts
- HSRP uses **UDP port 1985** and multicast address **224.0.0.2** for hello messages between routers
- The router with the **highest priority** (default 100, range 0–255) wins the active role; ties are broken by highest IP address
- HSRP supports **MD5 authentication** (preferred) and plain-text authentication to prevent rogue routers from hijacking the active role
- The virtual gateway IP assigned to hosts is **not tied to any physical interface** — it's a floating address managed by the active router
- HSRP version 2 extended the group range (0–255 → 0–4095) and uses multicast **224.0.0.102** instead of 224.0.0.2

## Related concepts
[[Man-in-the-Middle Attack]] [[ARP Spoofing]] [[Network Authentication Protocols]]