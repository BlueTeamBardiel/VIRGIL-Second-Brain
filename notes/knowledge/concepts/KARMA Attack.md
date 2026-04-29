# Karma Attack

## What it is
Like a con artist who says "Yes, I'm whoever you need me to be" to everyone they meet, a Karma attack is when a rogue access point automatically responds to *any* probe request from a Wi-Fi client, impersonating every network the device has ever trusted. Precisely: it exploits the 802.11 probe request mechanism, where devices broadcast SSIDs of previously connected networks, and a malicious AP replies as if it *is* each requested network to lure victims into connecting.

## Why it matters
In a 2014-era penetration test scenario, an attacker running tools like KARMA (or modern variants via hostapd-wpe) in an airport lounge could silently capture the laptops of every business traveler whose device probed for "HomeNetwork" or "CorpWiFi." Once connected, all unencrypted traffic — including credentials passed over HTTP or legacy email protocols — flows directly through the attacker's machine, enabling credential harvesting and man-in-the-middle interception at scale.

## Key facts
- Exploits the **Preferred Network List (PNL)** — the stored list of previously joined SSIDs that devices probe for automatically
- The attack requires **no prior knowledge** of the target; the device advertises its own trusted networks via probes
- Modern mitigations include **randomized probe requests** (iOS 14+, Android 10+) and suppressing active probing entirely
- Tools commonly associated: **Karma, hostapd-wpe, WiFi-Pumpkin, Airbase-ng**
- Largely mitigated on modern OSes, but remains relevant against **IoT devices and legacy systems** that still broadcast SSIDs aggressively
- Classified as an **Evil Twin** variant, distinguished by its automated, opportunistic impersonation rather than targeting a single known SSID

## Related concepts
[[Evil Twin Attack]] [[Rogue Access Point]] [[Man-in-the-Middle Attack]] [[802.11 Probe Requests]] [[Captive Portal Attack]]