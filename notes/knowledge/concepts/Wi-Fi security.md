# Wi-Fi security

## What it is
Think of your wireless network like a conversation shouted across a crowded café — anyone nearby can hear it unless you scramble the words into a code only your intended listener can unscramble. Wi-Fi security refers to the suite of protocols and practices that authenticate devices and encrypt wireless traffic to prevent eavesdropping, unauthorized access, and injection attacks on IEEE 802.11 networks.

## Why it matters
In 2017, the KRACK (Key Reinstallation Attack) vulnerability demonstrated that an attacker within radio range could force WPA2-protected clients to reuse cryptographic nonces, allowing decryption of traffic without knowing the password. This exposed millions of devices — including IoT sensors and mobile phones — to man-in-the-middle attacks on networks previously considered secure, underscoring that even widely-trusted protocols can harbor implementation flaws.

## Key facts
- **WEP** uses RC4 with static keys and is completely broken — IVs repeat within hours on busy networks, enabling trivial decryption with tools like Aircrack-ng.
- **WPA2** uses AES-CCMP for encryption and is still widely deployed; its PSK mode is vulnerable to offline dictionary attacks against the 4-way handshake capture.
- **WPA3** introduces SAE (Simultaneous Authentication of Equals), replacing PSK and eliminating offline dictionary attacks by providing forward secrecy.
- **Evil Twin attacks** create a rogue access point mimicking a legitimate SSID, tricking clients into connecting and surrendering credentials or traffic.
- **802.1X / EAP** (Enterprise mode) authenticates individual users via a RADIUS server rather than a shared password, significantly reducing lateral compromise risk.

## Related concepts
[[WPA3]] [[RADIUS Authentication]] [[Man-in-the-Middle Attack]] [[Evil Twin Attack]] [[Network Access Control]]