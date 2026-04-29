# Roaming

## What it is
Like a traveler using their home country's credit card in a foreign airport — the foreign bank checks with your home bank to authorize the transaction — roaming allows a mobile device to authenticate and use network services outside its home carrier's infrastructure. Precisely, roaming is the ability of a wireless device to connect to a visited network (VN) while maintaining services provisioned by its home network (HN), achieved through inter-carrier agreements and authentication protocols like EAP-SIM or 5G's SEPP-mediated N32 interface.

## Why it matters
Attackers have exploited SS7 (Signaling System 7) roaming infrastructure to intercept SMS-based two-factor authentication codes — by sending fraudulent routing requests, they redirect a victim's text messages to attacker-controlled nodes, effectively bypassing MFA on banking and email accounts. This attack vector was used in real-world German bank heists in 2017, demonstrating that carrier-level trust relationships create systemic authentication vulnerabilities.

## Key facts
- **SS7 vulnerabilities** in roaming allow location tracking, call interception, and SMS hijacking without any device compromise — purely a signaling-layer attack.
- **IMSI catchers (Stingrays)** exploit roaming handoff procedures to force devices onto rogue base stations acting as a "visited network."
- **5G introduced SEPP (Security Edge Protection Proxy)** specifically to encrypt inter-operator signaling and mitigate SS7-style roaming attacks on the N32 interface.
- Roaming authentication relies on the **HLR/HSS (Home Location Register / Home Subscriber Server)** — compromising this database exposes all subscribers' authentication vectors.
- From a compliance perspective, roaming data traverses foreign jurisdictions, creating **data sovereignty and GDPR exposure** risks for enterprise mobile device management.

## Related concepts
[[SS7 Attacks]] [[IMSI Catcher]] [[Multi-Factor Authentication Bypass]] [[SIM Swapping]] [[5G Security Architecture]]