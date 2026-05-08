# IEEE 802.11

## What it is

In Need for Speed, every street race needs rules — where the start line is, what counts as crossing the finish, how cops track you, how your crew talks over comms while you're all flooring it through the same intersection. That's exactly what IEEE 802.11 does — it's the rulebook that keeps every wireless device from turning the airwaves into a Most Wanted blacklist demolition derby.

It's the family of standards that defines Wireless LAN: how your laptop finds a network, how it proves it's allowed in, how it negotiates encryption keys, and how the actual data frames get encoded onto radio waves across the 2.4 GHz, 5 GHz, and 6 GHz bands. Every time you connect to coffee shop Wi-Fi, your phone is running an 802.11 state machine: scan → authenticate → associate → exchange keys → send data.

The "802.11" part is the base spec — the stock chassis. Letters after it (a/b/g/n/ac/ax) are amendments, the bolt-on upgrades from the parts shop: bigger turbo, more bandwidth, new bands, new features. 802.11ax is what marketing calls Wi-Fi 6.

## Why it matters

Wired Ethernet is a LAN party in someone's basement — to sniff the traffic you have to physically be in the room with a cable. Wi-Fi is a Discord voice channel with no password screenshot rules: the radio waves don't stop at the wall, and anyone within range with a wireless card in monitor mode can passively record everything without ever "joining" the server.

That single property — broadcast over open air — is why every security mechanism in 802.11 (WEP, WPA, WPA2, WPA3, MFP) exists. Each one is a patch on the original sin that the medium itself is public. Understanding which patches are in play on a given network tells you exactly what an attacker can and cannot do.

## Key facts

### Bands and channels

- **2.4 GHz**: longer range, better wall penetration, but only **3 non-overlapping channels (1, 6, 11)**. It's the crowded Apex Legends lobby where everyone's microwaves, Bluetooth headsets, and neighbors are stepping on each other.
- **5 GHz**: shorter range, worse through walls, but way more channels and less interference. Higher frequency = more bandwidth, less reach — same trade-off as a sniper rifle vs. a shotgun.
- **6 GHz**: introduced with Wi-Fi 6E, even more spectrum, even less wall penetration.

### 802.11 variants (the alphabet)

- **a/b/g**: legacy, slow, mostly historical.
- **n** (Wi-Fi 4): MIMO, dual-band.
- **ac** (Wi-Fi 5): 5 GHz only, wider channels.
- **ax** (Wi-Fi 6/6E): OFDMA, better in dense environments — and the foundation WPA3 is built on.

### Frames and scanning

- 802.11 frames are broadcast over open air — encryption protects payload, not the fact that frames exist.
- A wireless adapter in **monitor mode** is the passive observer in Among Us with no crewmate tasks: it captures every frame in range without ever associating with an AP. No logs, no trace.
- **Beacon Frames** are the AP's "I'm here" pings, broadcast roughly 10x per second. They carry the SSID, supported rates, and security parameters.
- **Hiding the SSID broadcast is security theater.** The AP just stops putting the name in beacons, but the network still exists, clients still probe for it, and **passive scanning** reveals it the moment any real device connects. Like muting your mic in Discord but leaving your camera on.

### Authentication and encryption history

- **WEP**: the original, broken before most people learned what it was. RC4 with reused IVs — crackable in minutes.
- **802.11i**: the amendment that killed WEP and introduced **WPA2**.
- **WPA2**: uses **AES-CCMP** for encryption (proper block cipher, not RC4 duct tape) and the **4-way handshake** to derive session keys from the pre-shared key.
- The 4-way handshake is the WPA2 weakness — it's captured over the air, then brute-forced offline. Like watching someone type their password in a Twitch stream and then guessing variants at home for as long as you want.

### WPA3 and SAE

- **WPA3** is built on 802.11ax infrastructure.
- It replaces the PSK 4-way handshake with **SAE (Simultaneous Authentication of Equals)**, a Dragonfly-based key exchange.
- SAE makes each guess require a fresh interaction with the AP — **no offline dictionary attacks**. You can't capture-once-and-crack-forever anymore. It's the difference between a souls-game boss you can savescum versus one with a permadeath checkpoint.

### Management Frame Protection (802.11w)

- Base 802.11 management frames (deauth, disassoc, beacon) are **unauthenticated**. Anyone can spoof a deauth telling your phone "the AP says go away," and your phone obeys. This is the classic deauth attack — the same trick used to kick people off networks for handshake capture or just to grief.
- **802.11w** adds **Management Frame Protection (MFP)**, cryptographically signing those management frames so spoofed deauths get dropped.
- WPA3 makes MFP mandatory.

### The fundamental gap

- **Access points are not cryptographically authenticated in the base protocol.** Your device trusts an AP because it has the right SSID and knows the PSK — that's it. An attacker with the same SSID and a stronger signal becomes the AP. This is how Evil Twin and Watch Dogs-style fake hotspot attacks work, and only enterprise auth (802.1X with cert validation) or WPA3-SAE meaningfully closes it.

## Related concepts

[[WPA2 4-way handshake]]
[[WPA3 SAE]]
[[Evil Twin attacks]]
[[Deauthentication attacks]]
[[Monitor mode and packet capture]]
[[802.1X / EAP enterprise authentication]]
[[AES-CCMP]]
[[Wi-Fi 6 / 802.11ax]]
[[Beacon and probe frames]]