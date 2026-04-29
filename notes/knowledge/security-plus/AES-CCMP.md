# AES-CCMP

## What it is
Think of AES-CCMP as a bouncer that both checks your ID *and* searches you for weapons — it authenticates (verifies you are who you claim) AND encrypts simultaneously. AES-CCMP combines AES encryption in Counter mode with CBC-MAC for authentication, protecting both confidentiality and integrity of wireless frames.

## Why it matters
When you connect to a WPA2 network, AES-CCMP is the default encryption protecting your traffic from eavesdropping and tampering. Without it, an attacker on the same coffee shop Wi-Fi could intercept your session cookies or inject malicious packets into your stream. It's the reason WEP networks collapsed — they lacked authenticated encryption entirely.

## Key facts
- **CCMP = Counter with CBC-MAC Protocol** — combines AES-CTR (counter mode encryption) with CBC-MAC (authentication)
- **128-bit AES key length** — uses 128-bit symmetric keys derived from your Wi-Fi passphrase
- **TKIP replacement** — WPA2 mandates CCMP; TKIP (WPA's older algorithm) was cryptographically broken
- **Per-packet nonce** — each frame gets a unique nonce (number used once) preventing replay attacks and pattern recognition
- **MIC field** — adds 8-byte Message Integrity Code to detect tampering; frame is rejected if MIC fails

## Related concepts
[[WPA2]] [[AES]] [[CBC-MAC]] [[TKIP]] [[Wireless Frame Security]]