# Security Through Obscurity

## What it is
Imagine hiding your house key under the exact same fake rock every neighbor on the street uses — if someone figures out the hiding spot, the key itself provides zero resistance. Security through obscurity is the practice of relying on secrecy of design, implementation, or configuration as the *primary* defense mechanism, rather than using it as one layer among many robust controls.

## Why it matters
In 2012, Adobe kept its PDF encryption algorithm proprietary, believing secrecy would protect it — researchers reverse-engineered it anyway and discovered weak key generation. This illustrates the core danger: once obscurity fails (and it always eventually does), there is no underlying cryptographic strength to fall back on. Defense-in-depth doctrine explicitly warns against making obscurity your load-bearing wall.

## Key facts
- **Kerckhoffs's Principle** (1883) states a cryptographic system should be secure even if everything about it, except the key, is public knowledge — the direct theoretical rejection of obscurity as sufficient defense
- Security through obscurity is **not inherently wrong** as a *supplemental* layer (e.g., changing default SSH port reduces automated scan noise), but fails as a *sole* control
- The **NIST SP 800-160** framework classifies reliance on obscurity as an architectural weakness, not a security control
- **Common exam trap**: obscurity ≠ confidentiality — encrypting data is a real control; simply hiding where the data lives is obscurity
- Attackers use **reverse engineering, OSINT, and fuzzing** to defeat obscurity; the assumption that no one will look is almost always false

## Related concepts
[[Defense in Depth]] [[Kerckhoffs's Principle]] [[Least Privilege]] [[Open Design Principle]]