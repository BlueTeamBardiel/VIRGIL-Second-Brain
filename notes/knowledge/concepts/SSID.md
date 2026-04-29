# SSID

## What it is
Think of an SSID like the name on a storefront — it tells you which shop you're walking into, but anyone can hang the same sign. An SSID (Service Set Identifier) is the human-readable name broadcast by a wireless access point to identify a specific Wi-Fi network. It can be up to 32 bytes long and is transmitted in beacon frames that any nearby device can receive.

## Why it matters
Attackers exploit SSIDs in **evil twin attacks**: they stand up a rogue access point broadcasting the same SSID as a legitimate network (like "AirportFreeWifi"), betting that client devices will auto-connect to the stronger signal. Once connected, the attacker performs a man-in-the-middle attack, intercepting credentials and session tokens in plaintext — a scenario directly tested in Security+ objectives.

## Key facts
- SSIDs are **not authentication mechanisms** — knowing or matching an SSID provides zero proof of legitimacy
- "Hidden" SSIDs (disabling beacon broadcasts) offer **security through obscurity only**; tools like Wireshark or Kismet reveal them instantly from probe requests
- Client devices store SSIDs in their **Preferred Network List (PNL)** and will actively probe for them, enabling karma attacks even when the real AP is absent
- The maximum SSID length is **32 characters (bytes)**; SSIDs are case-sensitive
- Rogue AP detection is a core function of **Wireless Intrusion Prevention Systems (WIPS)**, which monitor for duplicate SSIDs with differing BSSIDs (MAC addresses)

## Related concepts
[[Evil Twin Attack]] [[Rogue Access Point]] [[Wireless Intrusion Prevention System]] [[War Driving]] [[Beacon Frame]]