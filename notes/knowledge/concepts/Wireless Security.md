# Wireless Security

## What it is
Think of your Wi-Fi network like a conversation happening through the walls of a coffee shop — anyone nearby with the right equipment can potentially eavesdrop unless you scramble your words into gibberish first. Wireless security is the collection of protocols, configurations, and practices that protect data transmitted over radio frequencies from unauthorized interception, injection, and access. It spans encryption standards, authentication mechanisms, and physical controls applied to 802.11 networks and beyond.

## Why it matters
In 2017, the KRACK (Key Reinstallation Attack) vulnerability demonstrated that WPA2 — considered the gold standard at the time — could be exploited by forcing nonce reuse during the four-way handshake, allowing attackers to decrypt traffic on any WPA2-protected network. This attack required no knowledge of the Wi-Fi password and affected virtually every Wi-Fi-capable device globally. The incident directly accelerated the adoption of WPA3, which uses Simultaneous Authentication of Equals (SAE) to eliminate this class of vulnerability.

## Key facts
- **WEP is broken**: Uses RC4 with static keys and weak IVs; crackable in minutes using tools like Aircrack-ng — never use it.
- **WPA2 uses AES-CCMP** for encryption (TKIP is legacy and deprecated); Personal mode uses a Pre-Shared Key (PSK), Enterprise mode uses 802.1X/RADIUS authentication.
- **WPA3-Personal** replaces PSK handshake with SAE, providing forward secrecy — past traffic can't be decrypted even if the password is later compromised.
- **Evil Twin attacks** create rogue access points mimicking legitimate SSIDs to perform man-in-the-middle attacks; mitigated by HTTPS, VPNs, and 802.1X mutual authentication.
- **Disabling SSID broadcast** is security theater — passive scanners like Kismet detect hidden networks trivially.

## Related concepts
[[Network Authentication Protocols]] [[Man-in-the-Middle Attacks]] [[802.1X and RADIUS]] [[Encryption Standards]] [[Rogue Access Points]]