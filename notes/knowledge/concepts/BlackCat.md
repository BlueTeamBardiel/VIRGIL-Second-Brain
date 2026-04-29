# BlackCat

## What it is
Like a Swiss Army knife that criminals rent by the hour, BlackCat (also called ALPHV) is a Ransomware-as-a-Service (RaaS) operation where developers lease sophisticated ransomware to affiliates who carry out attacks and split the ransom proceeds. Written in Rust, it was the first major ransomware family to use that language, making it highly portable across Windows, Linux, and VMware ESXi environments.

## Why it matters
In 2024, BlackCat affiliates attacked Change Healthcare, encrypting systems that process roughly one-third of all U.S. medical claims — disrupting prescription fulfillment for millions of patients for weeks. The attack demonstrated how RaaS lowers the technical barrier for attackers while maximizing impact on critical infrastructure, and the $22 million ransom payment (which BlackCat's developers then exit-scammed from their own affiliates) showed the chaotic, criminal ecosystem behind these operations.

## Key facts
- Uses a **triple extortion** model: encrypt data, threaten to leak it, and launch DDoS attacks to pressure victims simultaneously
- Written in **Rust**, enabling cross-platform execution and making static analysis and detection harder than traditional C/C++ ransomware
- Operates a **dark web leak site** ("ALPHV Collections") to publish stolen data and shame non-paying victims
- Affiliates keep **80–90% of ransom payments**, with developers taking the remainder — a business model designed to attract skilled criminal operators
- The FBI released a **decryption tool** in December 2023 after disrupting BlackCat infrastructure, allowing ~500 victims to recover files without paying

## Related concepts
[[Ransomware-as-a-Service]] [[Triple Extortion]] [[Lateral Movement]] [[Incident Response]] [[Dark Web]]