# deauthentication attacks

## What it is
Imagine a bouncer who can be impersonated by anyone wearing a black shirt — the real bouncer shouts "everyone out!" and the crowd obeys without checking his badge. A deauthentication attack works the same way: an attacker forges 802.11 management frames (specifically deauth frames) and broadcasts them to a Wi-Fi network, tricking clients into disconnecting from a legitimate access point. Because classic 802.11 management frames carry no cryptographic authentication, any device in range can spoof them.

## Why it matters
Deauthentication attacks are the engine behind WPA2 password cracking: an attacker forces clients offline, waits for them to automatically reconnect, and captures the four-way handshake during reconnection. That handshake is then taken offline for dictionary or brute-force attacks against the pre-shared key — making a passive eavesdropper suddenly capable of cracking network credentials without ever authenticating themselves.

## Key facts
- Deauth frames are 802.11 **management frames**, which in WPA2 and earlier carry **no cryptographic signature**, making spoofing trivial with tools like `aireplay-ng`.
- This is classified as a **Denial of Service (DoS)** attack at Layer 2, but it also enables credential harvesting as a secondary objective.
- **802.11w (Management Frame Protection / MFP)** was introduced specifically to cryptographically sign management frames and is the primary mitigation; it is mandatory in **WPA3**.
- WPA3 mandates 802.11w, making deauth-based handshake capture ineffective against WPA3-only networks.
- Relevant Security+ objective: attacks against **wireless protocols** and the importance of **WPA3** adoption as a control.

## Related concepts
[[802.11w Management Frame Protection]] [[WPA3]] [[evil twin attack]] [[four-way handshake]] [[wireless denial of service]]