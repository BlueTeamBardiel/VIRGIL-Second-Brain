# WPA

## What it is
Think of WPA as a security patch bolted onto a leaky pipe — it fixed the worst holes in WEP without replacing the entire plumbing system. Wi-Fi Protected Access (WPA) is a wireless security protocol introduced in 2003 as an interim replacement for the broken WEP standard, using TKIP (Temporal Key Integrity Protocol) to dynamically rotate encryption keys per packet.

## Why it matters
In a real-world scenario, an attacker using a tool like Aircrack-ng can capture a WPA handshake from a coffee shop network, then run an offline dictionary attack against it. If the network uses a weak pre-shared key (PSK) like "coffee123," the passphrase can be cracked in minutes — demonstrating why WPA alone isn't sufficient and why strong passphrases are critical even when the protocol itself is functional.

## Key facts
- WPA uses **TKIP** for encryption, which was a software fix layered over WEP's RC4 cipher — making it vulnerable to the TKIP MIC (Michael) attack
- WPA operates in two modes: **Personal (PSK)** using a pre-shared key, and **Enterprise** using 802.1X/RADIUS authentication
- The **4-way handshake** used to establish session keys can be captured and attacked offline — this is the core attack surface for WPA cracking
- WPA was designed as a **transitional standard**; WPA2 (using AES-CCMP) replaced it and is considered the real security improvement
- TKIP was officially deprecated by the IEEE in **2012** due to known weaknesses, making WPA itself largely obsolete

## Related concepts
[[WEP]] [[WPA2]] [[TKIP]] [[802.1X]] [[Four-Way Handshake]]