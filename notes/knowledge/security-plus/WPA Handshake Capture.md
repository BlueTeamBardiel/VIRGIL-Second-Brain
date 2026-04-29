# WPA Handshake Capture

## What it is
Like photocopying a key being duplicated at a locksmith — you don't steal the key itself, just a record of its shape. A WPA handshake capture is the act of intercepting the 4-way authentication exchange between a client and a Wi-Fi access point, which contains enough cryptographic material to attempt offline password cracking without ever connecting to the network.

## Why it matters
An attacker positioned near a coffee shop places their wireless adapter in monitor mode using `airmon-ng`, then uses `airodump-ng` to capture the EAPOL frames when a customer's laptop reconnects after a forced deauthentication packet. The attacker now takes the `.cap` file home and runs it against a wordlist with `hashcat` — the network never logs the attack, and no active intrusion occurred.

## Key facts
- The 4-way handshake uses EAPOL (Extensible Authentication Protocol over LAN) frames to establish the Pairwise Transient Key (PTK) between client and AP
- An attacker does **not** need to know the password to capture the handshake — only to witness the exchange
- Deauthentication attacks (sending spoofed 802.11 disassociation frames) are used to force a client to reconnect and re-initiate the handshake on demand
- WPA2-PSK handshakes are vulnerable to **offline dictionary and brute-force attacks** — the attacker needs only the SSID, handshake capture, and compute time
- WPA3 mitigates this with SAE (Simultaneous Authentication of Equals), which eliminates the static PSK exchange and provides forward secrecy

## Related concepts
[[Deauthentication Attack]] [[Evil Twin Attack]] [[WPA2 PSK]] [[Dictionary Attack]] [[Aircrack-ng]]