# Mobile threat modeling

## What it is
Think of it like designing a bank vault on wheels — you can't just copy the blueprints for a stationary vault because the attack surface changes the moment it moves. Mobile threat modeling is the structured process of identifying, enumerating, and prioritizing threats specific to mobile applications and devices, accounting for unique risks like physical loss, untrusted networks, insecure app stores, and limited user control over the OS.

## Why it matters
In 2023, the SpinOk Android spyware SDK was embedded in over 100 Play Store apps with 420 million+ downloads — developers who never modeled threats around third-party SDK supply chains had no mechanism to anticipate or detect the risk. A team applying STRIDE to their mobile app would have identified "Information Disclosure" and "Tampering" as high-risk threat categories tied to third-party dependencies, prompting supply chain controls before shipping.

## Key facts
- **OWASP Mobile Top 10** is the primary framework referenced in mobile threat modeling; key risks include insecure data storage (M2) and insufficient cryptography (M5)
- **STRIDE** maps directly to mobile: Spoofing (fake apps), Tampering (rooted devices), Repudiation (disabled logging), Info Disclosure (plaintext storage), DoS (battery drain attacks), Elevation of Privilege (privilege escalation via OS exploits)
- **Attack surface categories** unique to mobile: device sensors (GPS/camera), SMS/telephony stack, Bluetooth/NFC interfaces, and app sandbox escapes
- **Data flows to model** include app-to-backend API calls, inter-app communication (Intents on Android), and local storage writes — all potential interception or injection points
- **DREAD scoring** (Damage, Reproducibility, Exploitability, Affected users, Discoverability) is still used in mobile threat modeling to prioritize which risks get mitigated first

## Related concepts
[[STRIDE threat model]] [[OWASP Mobile Top 10]] [[Attack surface analysis]] [[Mobile application security testing]] [[Privilege escalation]]