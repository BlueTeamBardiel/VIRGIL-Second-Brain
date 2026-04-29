# Evil Twin

## What it is
Imagine a con artist wearing a perfect uniform and name tag from your favorite coffee shop, setting up a fake counter right next to the real one — that's an Evil Twin attack. It's a rogue wireless access point configured to mimic a legitimate Wi-Fi network (same SSID, often stronger signal) to trick devices into connecting, enabling interception of all transmitted traffic.

## Why it matters
At a hotel conference, an attacker sets up a hotspot named "Marriott_Guest_WiFi" near the lobby. Business travelers auto-connect, and the attacker performs a man-in-the-middle attack, harvesting credentials from unencrypted HTTP sessions and capturing VPN authentication handshakes. The victim sees nothing unusual — they're online and everything "works."

## Key facts
- Evil Twin attacks exploit **auto-connect behavior** in devices that remember and trust previously joined SSIDs
- The attacker often uses a **deauthentication (deauth) attack** to disconnect victims from the legitimate AP first, forcing reconnection to the rogue one
- **SSID alone cannot authenticate an access point** — this is why matching the network name is sufficient to fool most users
- Mitigation includes using **802.1X/WPA-Enterprise** with certificate-based authentication, which validates the AP's identity cryptographically
- A **Captive Portal Evil Twin** variant presents a fake login page to harvest credentials directly, even without intercepting encrypted traffic
- Detection methods include **Wireless Intrusion Prevention Systems (WIPS)** that flag duplicate SSIDs with different BSSIDs (MAC addresses)

## Related concepts
[[Rogue Access Point]] [[Man-in-the-Middle Attack]] [[Deauthentication Attack]] [[WPA Enterprise]] [[WIPS]]