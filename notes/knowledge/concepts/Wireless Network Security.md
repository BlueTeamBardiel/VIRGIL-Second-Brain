# Wireless Network Security

## What it is
Think of a wireless network like a conversation happening in a crowded café — anyone nearby can potentially eavesdrop unless you're whispering in a code only your friend understands. Wireless network security encompasses the protocols, configurations, and controls used to protect data transmitted over radio frequencies from unauthorized interception, injection, or disruption. Unlike wired networks, the physical medium is the open air itself, making the attack surface fundamentally harder to contain.

## Why it matters
In 2017, the KRACK (Key Reinstallation Attack) vulnerability demonstrated that WPA2 — then considered the gold standard — could be exploited by forcing nonce reuse during the four-way handshake, allowing attackers on the same network to decrypt traffic without knowing the passphrase. This attack affected virtually every Wi-Fi device in the world and forced the industry to accelerate the adoption of WPA3. It proved that even a well-established protocol can harbor architectural weaknesses exploitable in real environments.

## Key facts
- **WPA3** introduced Simultaneous Authentication of Equals (SAE), replacing the Pre-Shared Key (PSK) handshake to eliminate offline dictionary attacks
- **Evil twin attacks** deploy a rogue AP mimicking a legitimate SSID to perform man-in-the-middle interception — defended against using 802.1X/EAP with certificate validation
- **WEP** is cryptographically broken (RC4 keystream reuse); its IV space of 24 bits means key collisions occur within ~5,000 packets
- **802.1X port-based authentication** with RADIUS provides enterprise-grade access control, preventing unauthenticated devices from joining even if they know the passphrase
- **Disassociation/deauthentication attacks** exploit unauthenticated 802.11 management frames; 802.11w (Management Frame Protection) mitigates this

## Related concepts
[[WPA3 and SAE]] [[Evil Twin Attacks]] [[802.1X Authentication]] [[KRACK Vulnerability]] [[Rogue Access Points]]