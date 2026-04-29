# WEP Cracking

## What it is
Imagine a lock where every key ever used leaves scratch marks on the keyhole — gather enough scratches and you can forge the master key. WEP (Wired Equivalent Privacy) cracking exploits fundamental flaws in the RC4 stream cipher implementation, specifically the reuse of weak Initialization Vectors (IVs), allowing an attacker to statistically recover the encryption key by collecting enough encrypted packets.

## Why it matters
In a real-world scenario, an attacker passively captures traffic on a WEP-protected network using a tool like `airodump-ng`, then injects ARP packets with `aireplay-ng` to artificially generate IV collisions at scale. After collecting roughly 40,000–85,000 weak IVs, `aircrack-ng` can crack a 128-bit WEP key in under a minute — meaning a coffee shop running legacy hardware in 2009 could expose every customer's session to a teenager with a laptop.

## Key facts
- WEP uses a **24-bit IV** prepended to the key, producing massive IV reuse on busy networks — the core statistical vulnerability exploited by the **FMS (Fluhrer, Mantin, Shamir) attack**
- The RC4 keystream can be recovered without brute force because weak IVs leak information about the key bytes sequentially
- WEP was deprecated by the IEEE in **2004** and replaced by WPA/WPA2 using TKIP and CCMP respectively
- Tools in the **Aircrack-ng suite** (airodump-ng, aireplay-ng, aircrack-ng) are the standard toolkit for WEP exploitation and are commonly referenced in Security+ exam scenarios
- A **passive-only attack** is possible but slow; **ARP replay injection** dramatically accelerates IV collection by forcing the AP to re-encrypt predictable packets

## Related concepts
[[RC4 Cipher]] [[WPA2 Cracking]] [[IV Attack]] [[Aircrack-ng]] [[802.11 Wireless Security]]