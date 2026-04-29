# wireless networking

## What it is
Like radio stations broadcasting music through the air — anyone with the right receiver can tune in — wireless networking transmits data via radio frequencies instead of physical cables. It uses IEEE 802.11 standards to allow devices to communicate with access points (APs) over the 2.4 GHz and 5 GHz bands. Unlike wired networks, the "wire" is invisible and shared, making eavesdropping trivially easy without strong encryption.

## Why it matters
In a classic evil twin attack, an adversary sets up a rogue AP broadcasting the same SSID as a coffee shop's legitimate network. Unsuspecting clients auto-connect, allowing the attacker to perform man-in-the-middle interception of credentials and session tokens. This attack requires zero physical access and can be executed with a $20 USB adapter and Hostapd.

## Key facts
- **WPA3** is the current gold standard; it uses SAE (Simultaneous Authentication of Equals) to resist offline dictionary attacks that crippled WPA2-PSK
- **WEP** is cryptographically broken — an attacker can crack the RC4 key in under 60 seconds by capturing ~50,000 IVs (Initialization Vectors)
- **802.11i** is the IEEE amendment that formally defined WPA2 and introduced AES-CCMP encryption
- **Deauthentication frames** in WPA2 are unauthenticated by default, enabling denial-of-service attacks that force clients to reconnect — WPA3 adds Management Frame Protection (MFP) to fix this
- Wireless site surveys use tools like **Kismet** or **WiFi Analyzer** to map signal strength, channel overlap, and rogue AP detection

## Related concepts
[[WPA2 encryption]] [[evil twin attack]] [[man-in-the-middle attack]] [[rogue access points]] [[network segmentation]]