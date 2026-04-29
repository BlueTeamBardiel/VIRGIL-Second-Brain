# ETSI

## What it is
Think of ETSI as the "ISO for European telecommunications" — a standards body that writes the rulebook telecom vendors must follow, like a building code for digital infrastructure. The European Telecommunications Standards Institute (ETSI) is an independent, non-profit organization that produces globally applicable standards for Information and Communications Technology (ICT), including telecommunications, broadcasting, and related areas.

## Why it matters
ETSI's TETRA (Terrestrial Trunked Radio) standard, used by police and emergency services across Europe, was found in 2023 to contain a deliberate backdoor — researchers discovered TETRA:BURST, a suite of vulnerabilities including a cipher (TEA1) intentionally weakened to 32-bit effective key strength, allowing real-time decryption of encrypted radio communications. This exposed decades of sensitive law enforcement communications and demonstrated how standards bodies can become vectors for systemic, nation-scale vulnerabilities baked directly into infrastructure.

## Key facts
- ETSI produces standards like **TETRA**, **DECT**, **GSM**, and **LTE** — protocols embedded in critical infrastructure worldwide
- The **TETRA:BURST** disclosure (2023) revealed that TEA1 cipher had an intentional export-restriction backdoor reducing key strength from 80-bit to ~32-bit effective entropy
- ETSI operates under EU mandate and coordinates with **3GPP** for mobile network standards (4G/5G)
- ETSI's **EN 303 645** is the consumer IoT cybersecurity standard establishing baseline security requirements (no default passwords, vulnerability disclosure policies)
- Standards from ETSI can carry **regulatory weight** in EU member states, meaning vulnerabilities in ETSI specs affect compliance frameworks like NIS2

## Related concepts
[[3GPP]] [[TETRA]] [[Cryptographic Backdoors]] [[IoT Security Standards]] [[Critical Infrastructure Protection]]