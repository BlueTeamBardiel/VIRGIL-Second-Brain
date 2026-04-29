# WPA PMKID Attack

## What it is
Like stealing a hotel room key card *imprint* from the hallway floor instead of breaking down the door — the PMKID attack extracts a cryptographic identifier directly from the Wi-Fi access point's beacon/association frame without requiring any client device to be present. It targets the PMKID (Pairwise Master Key Identifier), a hash derived from the PMK, AP MAC address, and client MAC address, enabling offline brute-force attacks against the pre-shared key.

## Why it matters
In 2018, Jens Steube (hashcat's creator) discovered this technique while searching for new WPA3 attack vectors. An attacker can park outside an office building, capture a single RSNE (Robust Security Network Element) frame from the target AP using `hcxdumptool`, then walk away and crack the PSK offline using `hashcat` — no de-authentication flood required, no waiting for a client to connect.

## Key facts
- **No client required:** Unlike the 4-way handshake capture method, PMKID attacks need only the AP itself, making them stealthier and faster to execute
- **PMKID formula:** `PMKID = HMAC-SHA1-128(PMK, "PMK Name" || AP_MAC || Client_MAC)`
- **Offline cracking:** Once captured, the hash is fed into hashcat (mode `-m 22000`) for dictionary/brute-force attacks — success depends entirely on PSK complexity
- **Affects WPA2-Personal:** WPA2-Enterprise (802.1X) is not vulnerable because it uses unique per-user PMKs not derived from a static PSK
- **Mitigation:** Use long, random PSKs (20+ characters), deploy WPA3 (SAE handshake eliminates PMKID exposure), and consider 802.1X for enterprise environments

## Related concepts
[[WPA2 4-Way Handshake]] [[Pre-Shared Key Authentication]] [[Offline Password Cracking]] [[WPA3 SAE]] [[Evil Twin Attack]]