# Cold Boot Attack

## What it is
Like ripping a page out of a book mid-sentence — the words don't vanish instantly, they linger. A cold boot attack exploits the fact that DRAM memory retains data for seconds to minutes after power is removed, allowing an attacker to reboot a machine into a forensic tool and dump the still-readable RAM contents. The attacker can then extract encryption keys, passwords, or session tokens from that residual data.

## Why it matters
In 2008, researchers at Princeton demonstrated that BitLocker, FileVault, and TrueCrypt encryption keys could all be recovered from RAM by cooling the memory chips with compressed air (slowing decay to minutes) and transplanting the DIMMs into an attacker-controlled machine. This shattered the assumption that full-disk encryption protected a running or sleeping laptop from physical access — a critical lesson for endpoint security policy.

## Key facts
- DRAM data remanence can last **seconds at room temperature** but **minutes or longer** when cooled to around -50°C using canned air or liquid nitrogen
- The attack targets **volatile memory (RAM)**, not storage — making disk encryption alone insufficient
- **Hibernation and sleep modes** are particularly risky because encryption keys remain loaded in RAM
- Mitigations include: **disabling sleep/hibernate**, requiring PIN at boot (not just disk decryption), and using **memory encryption** (e.g., AMD SME/SEV, Intel TME)
- Cold boot attacks are classified as **physical/local attacks** — they require hands-on hardware access, making them relevant to **insider threat** and **lost/stolen device** scenarios

## Related concepts
[[Full Disk Encryption]] [[BitLocker]] [[Data Remanence]] [[Evil Maid Attack]] [[Trusted Platform Module (TPM)]]