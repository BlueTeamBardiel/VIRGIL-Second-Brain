# WEP

## What it is
Imagine locking your front door with a combination lock where everyone in the neighborhood uses the *same* combination — and the lock itself tells you hints about it each time you turn the dial. WEP (Wired Equivalent Privacy) is a deprecated 802.11 wireless security protocol from 1997 that used RC4 stream encryption with static shared keys and a critically flawed 24-bit Initialization Vector (IV) to protect Wi-Fi traffic.

## Why it matters
In 2001, researchers demonstrated that passive eavesdropping on WEP traffic could recover the encryption key in under a minute using tools like Aircrack-ng — no brute force required, just collecting enough packets containing repeated IVs. This attack, known as the FMS attack, means any coffee shop or office still running WEP is essentially broadcasting its traffic in plaintext to any attacker with a laptop running Kali Linux.

## Key facts
- WEP uses RC4 with a **24-bit IV**, which is so short (~16 million values) that IV collisions are statistically guaranteed on busy networks within hours
- The IV is transmitted **in plaintext** alongside each packet, handing attackers the very data needed to crack the key
- WEP was officially retired by the IEEE in **2004** and deprecated by the Wi-Fi Alliance; using it today violates PCI-DSS compliance
- Both **40-bit and 104-bit** key lengths exist, but neither fixes the IV problem — longer keys provide false confidence
- Tools like **Aircrack-ng** can crack WEP keys by capturing as few as **~40,000 IVs**, achievable in minutes on active networks

## Related concepts
[[WPA2]] [[RC4]] [[IV Reuse Attack]] [[802.11 Wireless Security]] [[Aircrack-ng]]