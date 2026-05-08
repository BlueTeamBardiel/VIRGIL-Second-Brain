# IEEE 802.11 Wi-Fi Standard

## What it is

In Bloodborne, every hunter in the Hunter's Dream shares the same dream-space — multiple players can be summoned into one host's world, and the game has to enforce strict etiquette about who can act, who can be heard, and which intruders (red phantoms, bell-ringers) are allowed to crash the session. That's exactly what IEEE 802.11 does — it's the rulebook for a shared invisible space where every device technically hears every other device, so the protocol decides who transmits, who listens, and who gets locked out.

IEEE 802.11 is the family of specifications that defines those rules for wireless local area networks (WLANs). It's not one document but a sprawling set of amendments (a, b, g, n, ac, ax, and more) that govern three big things:

- **Physical layer modulation** — how bits get encoded onto radio waves
- **MAC-layer access control** — who gets to transmit and when, so devices don't talk over each other
- **Security protocols** — how to authenticate clients and encrypt the air

Each letter amendment is a generational upgrade in the same way each Soulsborne title refines the formula — new mechanics, sharper performance, but the core ritual of bonfires, bosses, and bloodstains remains recognizable.

## Why it matters

Wi-Fi traffic is broadcast into open air. There's no cable to tap — anyone within range with a cheap USB radio can capture frames, the same way anyone walking past a public bench can hear what you're saying out loud. That changes the entire threat model compared to wired Ethernet.

It also means performance is shared. Pulling up to a coffee shop and watching your throughput tank is the wireless equivalent of joining a Helldivers 2 lobby where everyone's already shooting — the bandwidth and airtime get split among whoever's transmitting. The 802.11 standard is what keeps that chaos from collapsing into total noise, and what determines whether the attacker on the next table can read your traffic or not.

## Key facts

### Frequency bands and channels

- **2.4 GHz**: longer range, penetrates walls better, but crowded. Only **3 non-overlapping channels: 1, 6, and 11**. Every microwave, Bluetooth speaker, and neighbor's router is fighting for the same airtime — this is the Tarkov Customs of frequency bands, packed and noisy.
- **5 GHz**: more channels, less interference, faster — but shorter range and worse at punching through drywall. Think of it as a high-tier raid instance: cleaner experience, but you have to be close to the entrance.

### Channel access — CSMA/CA

- 802.11 uses **Carrier Sense Multiple Access with Collision Avoidance**. Devices listen first, and only transmit if the channel sounds clear. It's the "is anyone talking?" pause before you unmute on a Discord call.
- Wired Ethernet uses CSMA/**CD** (Collision Detection) — it can hear collisions while transmitting. Wireless **cannot detect collisions mid-transmission** because a radio can't simultaneously transmit and listen on the same frequency at useful power levels. So 802.11 has to *avoid* collisions instead of cleaning them up after.

### Beacon frames and discovery

- APs broadcast **beacon frames** roughly 10 times per second, **unencrypted**, advertising the SSID and capabilities (supported rates, security modes, etc.). It's the AP standing on a street corner yelling "I'm here, I support WPA3, come connect."
- **Passive scanning** just listens for beacons — your laptop's Wi-Fi list populates without ever transmitting. Attackers love this because reconnaissance leaves zero trace on the network.

### Authentication and security amendments

- By default, 802.11 authentication verifies the **client to the AP, but not the AP to the client**. The bouncer checks your ID; you don't check the bouncer's. This is exactly how evil-twin and rogue AP attacks work — spin up a fake "Starbucks WiFi" and clients happily associate.
- **802.11i** is the security amendment that formalized **WPA2** and mandates **AES-CCMP** encryption.
- WPA2 replaced the broken stack of **WEP** (cryptographically dead since the early 2000s) and **WPA/TKIP** (a band-aid built on RC4).
- **WPA3** arrived in 2018 and replaced the PSK handshake with **SAE — Simultaneous Authentication of Equals**.

### Why SAE matters

- The old WPA2-PSK 4-way handshake could be **captured off the air and brute-forced offline** — grab one handshake, then run hashcat against a wordlist on your gaming GPU for as long as you want. No interaction with the network needed.
- SAE uses a Dragonfly key exchange that resists offline dictionary attacks. Each guess requires a fresh interaction with the AP, so you can't just farm GPU cycles in your basement against a captured pcap.

### Mutual authentication done right

- For enterprise deployments, **802.1X with certificate-based mutual authentication** forces the AP (technically the RADIUS server behind it) to **prove its identity** with a certificate the client validates. Both bouncer and patron flash ID. This is what kills evil-twin attacks dead — the fake AP can't produce a valid cert chain.

## Related concepts

[[WPA2 and WPA3]] · [[802.1X and EAP]] · [[Evil Twin Attacks]] · [[CSMA/CD vs CSMA/CA]] · [[WEP and TKIP]] · [[RADIUS]] · [[AES-CCMP]] · [[SSID and BSSID]] · [[Wireless Deauthentication Attacks]] · [[PMKID Attacks]]