# Physical Access Control Bypass

## What it is
Like slipping through a revolving door behind someone before it stops spinning, physical access control bypass exploits the gap between a security system's *intent* and its *implementation*. It refers to techniques used to defeat physical barriers — locks, badge readers, mantraps, or biometrics — without possessing legitimate credentials. The attacker gains unauthorized physical presence inside a protected space.

## Why it matters
In the 2013 Target breach, attackers initially compromised an HVAC vendor with legitimate physical and network access — illustrating that a single trusted third party can unravel layered security. Defending against this requires combining technical controls (badge readers, mantraps) with procedural ones (visitor escorts, access logs) because no single physical control is sufficient alone.

## Key facts
- **Tailgating/Piggybacking**: Following an authorized person through a secure door; tailgating is without their knowledge, piggybacking is with (possibly unwitting) cooperation.
- **Mantrap (airlock)**: A two-door entry system that allows only one person through at a time — the primary countermeasure against tailgating.
- **Shoulder surfing**: Observing someone enter a PIN or password; mitigated by privacy screens and awareness training.
- **Lock picking / shimming**: Mechanical bypass of pin-tumbler or padlocks; high-security locks (Medeco, ABLOY) use security pins and rotating elements to resist this.
- **RFID cloning**: Capturing and duplicating proximity card signals using tools like Proxmark3; mitigated by using encrypted HID credentials (iCLASS SE) and Faraday pouches.
- Under **NIST SP 800-116**, PIV cards must be used with a PIN (two-factor) for access to sensitive federal facilities — possession alone is insufficient.

## Related concepts
[[Social Engineering]] [[Tailgating and Piggybacking]] [[Defense in Depth]] [[Multi-Factor Authentication]] [[RFID Security]]