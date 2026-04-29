# Mobile Networks

## What it is
Think of mobile networks like a relay race where your phone passes a baton between towers as you move — each handoff must be authenticated or an impersonator can steal the baton mid-race. Precisely, mobile networks are cellular communication infrastructures (2G/3G/4G LTE/5G) that connect devices to carrier backbones via base stations, using protocols like GSM, CDMA, and NR to handle voice, SMS, and data transmission.

## Why it matters
In a classic SS7 (Signaling System 7) attack, adversaries exploit the aging protocol backbone used by carriers to intercept SMS messages globally — including SMS-based MFA codes — without ever touching the victim's device. This is why NIST SP 800-63B explicitly discourages SMS as a second factor; an attacker with SS7 access can reroute your authentication texts silently and invisibly.

## Key facts
- **SS7 vulnerabilities** allow call interception, SMS hijacking, and real-time location tracking by anyone with carrier-level network access — a known weakness in 2G/3G/4G
- **IMSI Catchers (Stingrays)** are fake base stations that force nearby phones to downgrade to weaker protocols, enabling man-in-the-middle interception of calls and texts
- **5G improves security** with mutual authentication (the network must prove itself to the device) and SUPI/SUCI encryption to prevent IMSI harvesting
- **SIM Swapping** is a social engineering attack where attackers convince a carrier to transfer a victim's number to attacker-controlled SIM, hijacking all SMS-based authentication
- **Rogue access point vs. rogue base station**: distinguishable — rogue base stations operate on licensed cellular frequencies and require more sophisticated hardware than Wi-Fi-based attacks

## Related concepts
[[SS7 Attack]] [[SIM Swapping]] [[Man-in-the-Middle Attack]] [[Multi-Factor Authentication]] [[IMSI Catcher]]