# NetStumbler

## What it is
Like a metal detector swept across a beach to find hidden coins, NetStumbler passively and actively probes the air to reveal hidden wireless networks. It is a legacy Windows-based 802.11 wireless network discovery tool (released ~2001) that detects SSIDs, signal strength, channel, encryption status, and GPS coordinates of nearby access points by sending probe request frames and logging responses.

## Why it matters
A penetration tester conducting a wireless site survey in 2005 would walk a corporate campus with NetStumbler running on a laptop to map every access point — including rogue APs employees had plugged in without IT approval. Discovering a rogue AP broadcasting with WEP or no encryption would immediately signal an unauthorized entry point into the corporate network, justifying remediation before an attacker could exploit it.

## Key facts
- NetStumbler operates in **active scanning mode** — it transmits 802.11 probe request frames, making it detectable by wireless intrusion detection systems (WIDS), unlike purely passive sniffers
- Identifies key AP attributes: **SSID, BSSID (MAC address), channel, signal/noise ratio, and WEP enabled/disabled**
- A companion tool, **MiniStumbler**, was the same application optimized for Windows CE/Pocket PC handheld devices
- NetStumbler **cannot capture packet payloads** — it is a discovery/enumeration tool, not a packet analyzer like Wireshark or Kismet
- Largely considered **obsolete** today; it does not support WPA/WPA2 detection fields and lacks compatibility with modern 64-bit Windows or 802.11n/ac/ax adapters

## Related concepts
[[Kismet]] [[Wardriving]] [[Rogue Access Point]] [[Wireless Site Survey]] [[SSID Broadcasting]]