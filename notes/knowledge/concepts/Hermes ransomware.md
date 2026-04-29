# Hermes ransomware

## What it is
Like a thief who copies your house keys before robbing you, Hermes doesn't just encrypt your files — it was designed to enable lateral movement and data theft alongside encryption. Hermes is a ransomware-as-a-service (RaaS) strain first observed in 2017, notable for its use by North Korean Lazarus Group as a smokescreen to conceal the true objective of financial theft.

## Why it matters
During the 2017 SWIFT banking heist against Taiwan's Far Eastern International Bank, Lazarus Group deployed Hermes ransomware across the bank's network as a distraction while simultaneously exfiltrating approximately $60 million via fraudulent SWIFT transfers. This dual-purpose attack illustrates why defenders must treat ransomware incidents as potential cover for deeper, more damaging operations rather than standalone encryption events.

## Key facts
- Hermes served as the technical foundation for **Ryuk ransomware**, which later targeted hospitals and enterprises for multi-million dollar ransoms
- It uses **RSA-2048 + AES-256** encryption, storing the victim's AES key encrypted with the attacker's RSA public key — decryption without the private key is computationally infeasible
- The malware checks for **Russian, Ukrainian, and Belarusian keyboard layouts** and terminates itself if found — a common nation-state technique to avoid domestic prosecution
- Hermes was initially sold on underground forums in **early 2017** before Lazarus weaponized it for nation-state operations
- Lateral movement was facilitated using **stolen credentials and SMB exploitation**, making network segmentation a critical defensive control

## Related concepts
[[Ryuk ransomware]] [[Lazarus Group]] [[SWIFT banking attacks]] [[Ransomware-as-a-Service]] [[Lateral Movement]]