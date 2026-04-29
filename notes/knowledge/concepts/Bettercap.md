# Bettercap

## What it is
Think of Bettercap as a Swiss Army knife that a pickpocket uses — except instead of stealing wallets, it intercepts, inspects, and manipulates network traffic in real time. Bettercap is an open-source, modular network attack and monitoring framework written in Go, designed for performing man-in-the-middle (MitM) attacks, network reconnaissance, and protocol manipulation across Wi-Fi, Ethernet, and Bluetooth environments.

## Why it matters
During a red team engagement, an attacker on a corporate Wi-Fi network uses Bettercap to perform ARP spoofing, poisoning the ARP cache of a target machine so all its traffic routes through the attacker's laptop first. This allows credential harvesting from unencrypted HTTP sessions and DNS hijacking to redirect users to phishing pages — all without the victim noticing anything unusual.

## Key facts
- Bettercap superseded the older `ettercap` tool and is now the de facto standard for interactive MitM framework testing
- Its **caplets** system allows scripted, automated attack sequences — attackers can deploy repeatable attack chains with a single file
- Built-in modules include `arp.spoof`, `dns.spoof`, `http.proxy`, `https.proxy` (with SSL stripping), and `wifi.recon`
- Bettercap can perform **HSTS bypass** and **SSL stripping** via its `https.proxy` module, downgrading HTTPS connections to HTTP to expose credentials
- Detected defensively through network monitoring for ARP anomalies (duplicate IP-to-MAC mappings), unexpected default gateway changes, or IDS signatures matching Bettercap's user-agent strings

## Related concepts
[[ARP Spoofing]] [[Man-in-the-Middle Attack]] [[SSL Stripping]] [[DNS Spoofing]] [[Network Reconnaissance]]