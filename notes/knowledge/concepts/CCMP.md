# CCMP

## What it is
Think of CCMP like a bank vault that doesn't just lock your money away — it also stamps every bill with a unique serial number so you can detect if anything was swapped out. Counter Mode CBC-MAC Protocol (CCMP) is the encryption protocol used in WPA2 that combines AES in Counter Mode (CTR) for confidentiality with Cipher Block Chaining Message Authentication Code (CBC-MAC) for integrity and authentication.

## Why it matters
When the KRACK (Key Reinstallation Attack) vulnerability was discovered in 2017, attackers could manipulate WPA2's handshake process to force nonce reuse — undermining the Counter Mode component of CCMP and potentially allowing decryption of traffic. CCMP's integrity checking (MIC) was what limited the damage, since forging or injecting packets remained computationally infeasible even during the attack. This demonstrates that CCMP's dual-function design provides defense in depth even when one layer is partially compromised.

## Key facts
- CCMP uses **AES with a 128-bit key** — not RC4 like WEP's flawed predecessor TKIP
- The CBC-MAC component produces a **Message Integrity Code (MIC)** to detect tampering — replacing TKIP's weaker Michael algorithm
- CCMP is **mandatory in WPA2** (IEEE 802.11i) and is the default cipher suite for WPA3 as well
- Uses a **48-bit Packet Number (PN)** as a nonce to prevent replay attacks; reusing a nonce breaks confidentiality (the KRACK vulnerability)
- CCMP adds **16 bytes of overhead** per packet: 8 bytes for the CCMP header and 8 bytes for the MIC

## Related concepts
[[WPA2]] [[AES]] [[TKIP]] [[KRACK Attack]] [[Message Integrity Code]]