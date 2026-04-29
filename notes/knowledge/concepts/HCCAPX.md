# HCCAPX

## What it is
Like a standardized shipping container that holds all the evidence a detective needs to crack a safe — HCCAPX is a binary file format used to store captured WPA/WPA2 four-way handshake data in a structured, portable form. It is the successor to the older HCCAP format, adding fields like message pair bitmask and replay counter to improve cracking accuracy and reduce false positives.

## Why it matters
During a wireless penetration test, an attacker uses a tool like `airodump-ng` to capture a WPA2 handshake by forcing a client to deauthenticate and reconnect. That raw capture is then converted to HCCAPX format using `cap2hccapx`, enabling GPU-accelerated offline dictionary attacks with tools like Hashcat — without ever touching the target network again, making the cracking phase completely silent and untraceable.

## Key facts
- **File extension:** `.hccapx`; each captured network handshake is stored as a fixed **392-byte record**
- **Hashcat mode:** HCCAPX files are cracked using Hashcat's `-m 2500` mode (WPA/WPA2); newer versions use `-m 22000` (PMKID/EAPOL unified format)
- **Contains:** ESSID, BSSID, client MAC address, EAPOL frames, and the MIC (Message Integrity Code) — everything needed to verify a passphrase offline
- **Conversion tool:** `cap2hccapx` converts standard `.pcap` files to HCCAPX; `hcxtools` is the modern preferred toolkit
- **Defense relevance:** Long, high-entropy WPA2 passphrases (20+ characters) are the primary mitigation — a captured handshake is useless against a passphrase that falls outside any dictionary or brute-force budget

## Related concepts
[[WPA2 Four-Way Handshake]] [[Hashcat]] [[PMKID Attack]] [[Deauthentication Attack]] [[Offline Password Cracking]]