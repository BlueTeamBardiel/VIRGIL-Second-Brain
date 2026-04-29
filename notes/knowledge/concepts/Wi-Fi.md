# Wi-Fi

## What it is
Think of Wi-Fi like a radio station broadcasting music — anyone with the right receiver tuned to that frequency can listen in, whether you invited them or not. Wi-Fi is a wireless networking technology using radio waves (typically 2.4 GHz or 5 GHz bands) to implement IEEE 802.11 standards, allowing devices to communicate without physical cables. The "broadcast" nature of the medium is precisely what makes it both convenient and inherently risky.

## Why it matters
At a coffee shop, an attacker sets up a rogue access point named "CoffeeShop_Free" — indistinguishable from the legitimate one. Victims connect automatically, and the attacker performs a man-in-the-middle attack, intercepting unencrypted HTTP traffic and harvesting credentials. This evil twin attack is trivially executed with tools like hostapd and requires no physical access to the target network.

## Key facts
- **WEP** (Wired Equivalent Privacy) is cryptographically broken — its RC4 implementation can be cracked in minutes using IV reuse attacks; never use it.
- **WPA2** uses AES-CCMP for encryption; its main vulnerability is the 4-way handshake, which can be captured and subjected to offline dictionary attacks.
- **WPA3** mitigates offline dictionary attacks by implementing SAE (Simultaneous Authentication of Equals), replacing the Pre-Shared Key handshake.
- **Disassociation attacks** exploit the fact that 802.11 management frames are unauthenticated — attackers send spoofed deauth frames to kick clients off a network (addressed by 802.11w Management Frame Protection).
- **SSID hiding** is security theater — passive scanners and tools like Kismet reveal hidden networks from probe requests almost instantly.

## Related concepts
[[Evil Twin Attack]] [[WPA3]] [[Man-in-the-Middle Attack]] [[Rogue Access Point]] [[802.1X Authentication]]