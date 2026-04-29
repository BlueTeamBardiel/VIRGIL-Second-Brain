# rogue access point

## What it is
Like a con artist setting up a fake information booth at a conference — same logo, same uniform, but they're harvesting every question you ask — a rogue access point is an unauthorized wireless access point connected to a legitimate network without the network owner's knowledge or consent. It can be planted by an attacker or innocently set up by an employee wanting better Wi-Fi, but either way it creates an uncontrolled entry point into the network.

## Why it matters
In a classic attack, a penetration tester plugs a $35 Raspberry Pi into an open Ethernet port in a corporate conference room, configures it as an access point, and walks out — now remote attackers can tunnel into the internal network through that Wi-Fi signal, completely bypassing the firewall perimeter. Network administrators using wireless intrusion prevention systems (WIPS) can detect this by correlating MAC addresses seen on the wired network with those broadcasting SSIDs on the air.

## Key facts
- A rogue AP differs from an **evil twin**: a rogue is physically connected to your network, while an evil twin mimics a legitimate SSID to intercept wireless clients externally.
- Detection relies on **RF scanning** and correlating wired/wireless MAC addresses — if a MAC appears on both the switch and the air, it's bridging the two.
- Rogue APs undermine **network access control (NAC)** by creating an unmanaged entry point that bypasses 802.1X authentication.
- Organizations use **wireless intrusion prevention systems (WIPS)** to automatically detect and contain rogue APs.
- Under PCI-DSS, quarterly **wireless scans** are required specifically to detect rogue APs in cardholder data environments.

## Related concepts
[[evil twin attack]] [[wireless intrusion prevention system]] [[network access control]] [[evil twin]] [[802.1X authentication]]