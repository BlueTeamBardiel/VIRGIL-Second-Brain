# RFID Cloning

## What it is
Like photocopying someone's library card while it's still in their pocket, RFID cloning captures the radio signal broadcast by an RFID tag and writes an exact duplicate onto a blank, writable card. An attacker with a cheap reader (as little as $20) can silently harvest credential data from proximity cards within inches — or even feet with amplified equipment — without the victim ever knowing.

## Why it matters
In a physical penetration test, a red teamer brushes past employees in a lobby using a concealed Proxmark device to clone HID access cards, then replays that cloned credential to badge into restricted server rooms minutes later. This attack bypasses all network-layer security controls entirely, demonstrating why physical access is the ultimate privilege escalation.

## Key facts
- **HID Prox cards (125 kHz)** transmit credentials in cleartext with zero authentication — trivially clonable with off-the-shelf tools like the Proxmark3 or Flipper Zero
- **Mifare Classic (13.56 MHz)** cards use broken CRYPTO1 encryption; keys can be cracked in seconds using known-plaintext attacks, making them also vulnerable despite appearing "secure"
- **Replay attacks** are the mechanism: cloning doesn't decrypt data, it simply duplicates and rebroadcasts the exact signal the legitimate card emits
- **Mifare DESFire EV2/EV3** with mutual authentication and rolling codes is the current hardened standard, significantly raising the bar for cloning
- **Defense layers** include: upgrading to cryptographically strong cards, adding PIN/biometric second factors, deploying RFID-blocking sleeves, and monitoring access logs for anomalous badge patterns

## Related concepts
[[Physical Security Controls]] [[Replay Attack]] [[Proximity Card Authentication]] [[Side-Channel Attack]] [[Badge Access Control Systems]]