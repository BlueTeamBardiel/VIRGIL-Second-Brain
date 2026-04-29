# SS7

## What it is
Imagine the world's phone carriers built a shared postal system in 1975 with no locks on the mailroom — and then just agreed to trust each other forever. SS7 (Signaling System No. 7) is exactly that: a suite of telephony protocols from 1975 that routes calls, SMS messages, and location data between telecom carriers globally, with virtually no authentication between nodes.

## Why it matters
In 2017, attackers exploited SS7 vulnerabilities to intercept SMS-based two-factor authentication codes sent to German bank customers, draining their accounts. Because SS7 trusts any connected carrier node by default, an attacker with access to the SS7 network — through a rogue carrier, a bribed insider, or a purchased network access point — can redirect SMS messages intended for any phone number worldwide.

## Key facts
- SS7 was designed for a closed network of trusted telecoms; it has **zero cryptographic authentication** between network nodes
- Attackers can use SS7 to perform **location tracking**, **call/SMS interception**, and **denial of service** against any mobile subscriber globally
- The core attack leverages `SendRoutingInfo` and `ProvideSubscriberInfo` messages to query and redirect subscriber data
- SMS-based MFA is explicitly considered **weak** by NIST (SP 800-63B) partly because SS7 interception makes it bypassable
- SS7 is gradually being superseded by **Diameter** (used in 4G/LTE) — but Diameter inherited many of the same trust-model flaws

## Related concepts
[[Multi-Factor Authentication]] [[SIM Swapping]] [[Diameter Protocol]] [[MITM Attack]] [[VoIP Security]]