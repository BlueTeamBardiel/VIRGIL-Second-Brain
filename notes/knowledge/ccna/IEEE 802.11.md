# IEEE 802.11

## What it is
Think of it like a crowded restaurant where everyone shouts orders across the room using agreed-upon timing rules so the kitchen doesn't get overwhelmed — IEEE 802.11 is the wireless networking standard that defines exactly how devices share radio frequency airspace using that same kind of coordinated, turn-taking communication. Formally, it's the IEEE standard governing Wi-Fi (Wireless LAN) protocols, specifying how devices authenticate, associate, and transmit data over 2.4 GHz, 5 GHz, and 6 GHz bands across variants like 802.11a/b/g/n/ac/ax.

## Why it matters
Because 802.11 frames are broadcast over open air, an attacker with a wireless adapter in monitor mode can passively capture every packet without joining the network — this is how WPA2 4-way handshakes get captured and cracked offline with tools like Hashcat. Understanding the standard also explains why evil twin attacks work: nothing in the base protocol cryptographically authenticates the access point itself, letting attackers stand up rogue APs that clients will willingly join.

## Key facts
- **802.11i** introduced WPA2, replacing the broken WEP with AES-CCMP encryption and the 4-way handshake for key derivation
- **802.11w** added Management Frame Protection (MFP), defending against deauthentication/disassociation attacks used in denial-of-service and forced reconnection exploits
- **WPA3** (built on 802.11ax infrastructure) replaces PSK with SAE (Simultaneous Authentication of Equals), eliminating offline dictionary attacks against the handshake
- **2.4 GHz** travels farther and penetrates walls better but has only 3 non-overlapping channels (1, 6, 11), making it more congested and easier to intercept at range
- SSID broadcast is a Beacon Frame function — hiding it provides **zero real security** since passive scanning still reveals the network

## Related concepts
[[WPA2]] [[Evil Twin Attack]] [[Deauthentication Attack]]