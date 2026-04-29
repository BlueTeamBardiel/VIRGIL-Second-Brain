# PMKID

## What it is
Like finding a hotel safe that reveals its combination just by looking at it from the outside — the PMKID is a unique identifier derived from the WPA2 four-way handshake that can be extracted directly from a single beacon frame without needing to capture a full authentication exchange. It is a 128-bit value calculated as `HMAC-SHA1(PMK, "PMK Name" || AP_MAC || Client_MAC)`, embedded in the RSNE (Robust Security Network Element) of association request frames.

## Why it matters
In 2018, Jens Steube (hashcat's creator) discovered that attackers could grab the PMKID from a router's beacon without waiting for any client to connect, then crack the Pre-Shared Key offline using tools like `hcxdumptool` and `hashcat`. This eliminated the "patience tax" of classic WPA2 handshake attacks — no victim client needed, just proximity to the access point.

## Key facts
- **Clientless capture**: PMKID attacks require only one frame from the AP, unlike the traditional 4-way handshake attack requiring an active client
- **Derived value**: PMKID = HMAC-SHA1(PMK || "PMK Name" || BSSID || Client_MAC) — the PMK itself comes from PBKDF2(passphrase, SSID, 4096 rounds, 256 bits)
- **Offline cracking**: Once captured, the PMKID hash is cracked entirely offline, making detection by IDS nearly impossible during the attack phase
- **Mitigation**: WPA3's SAE (Simultaneous Authentication of Equals) replaces the PSK derivation model and eliminates PMKID vulnerability
- **Tool chain**: `hcxdumptool` captures the frame → `hcxtools` converts to hashcat format → hashcat mode `22000` cracks it

## Related concepts
[[WPA2 4-Way Handshake]] [[Pre-Shared Key (PSK)]] [[PBKDF2]] [[WPA3 SAE]] [[Offline Password Cracking]]