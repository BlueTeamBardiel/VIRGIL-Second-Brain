# evil twin attacks

## What it is
Imagine a forger who sets up a fake passport control booth right next to the real one — same uniform, same stamps, same questions — but everything you hand over goes straight into their pocket. An evil twin attack works the same way: an attacker deploys a rogue wireless access point that mimics a legitimate network's SSID and sometimes its BSSID, tricking clients into connecting to the attacker's hardware instead of the real AP. Once connected, the attacker sits between the victim and the internet, enabling full man-in-the-middle interception.

## Why it matters
At a coffee shop, an attacker with a laptop and a $20 Wi-Fi adapter broadcasts "CoffeeShop_Free" at higher power than the legitimate AP. A customer's device auto-connects, the attacker captures their banking credentials submitted over an unencrypted form, and walks away before anyone notices. The defense is enforcing HTTPS everywhere and using a VPN on untrusted networks — the evil twin can intercept your traffic but can't decrypt a properly established TLS session.

## Key facts
- Evil twin attacks exploit 802.11 protocol behavior: clients trust any AP broadcasting a known SSID and will connect to the strongest signal
- Attackers often use deauthentication (deauth) frames to kick users off the legitimate AP, forcing reconnection to the rogue AP
- A **captive portal** on the rogue AP can harvest credentials by mimicking a login page before granting internet access
- Detection methods include wireless intrusion detection systems (WIDS) that flag duplicate SSIDs with mismatched BSSIDs
- Listed under **rogue access point** and **on-path (MitM) attacks** in the CompTIA Security+ exam objectives

## Related concepts
[[rogue access point]] [[man-in-the-middle attack]] [[deauthentication attack]] [[wireless security protocols]] [[captive portal]]