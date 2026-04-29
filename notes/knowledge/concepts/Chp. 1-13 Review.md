# Chp. 1-13 Review

## What it is
Think of chapters 1-13 as the blueprint and framing of a house — before you install locks and alarms, you need to understand the structure itself. This review consolidates foundational cybersecurity principles spanning threat actors, cryptography, network security, identity management, risk management, and defensive architectures into one unified framework.

## Why it matters
During a real incident response engagement, an analyst who can't connect "this is a nation-state APT using asymmetric encryption for C2 traffic over port 443" to the underlying concepts of threat classification, PKI, and network monitoring will miss critical pivot points. Mastery of these interconnected fundamentals is what separates a responder who contains a breach from one who watches it spread.

## Key facts
- **CIA Triad** (Confidentiality, Integrity, Availability) is the root evaluation framework for every control, threat, and vulnerability decision
- **Threat actors** range from script kiddies (low sophistication, opportunistic) to nation-states (high sophistication, persistent, well-funded) — motive and capability determine response priority
- **Symmetric encryption** (AES) is fast but has key distribution problems; **asymmetric encryption** (RSA) solves distribution but is computationally expensive — hybrid systems use both
- **Authentication factors**: Something you know / have / are / somewhere you are / something you do — MFA requires two or more *different* factor types
- **Risk formula**: Risk = Threat × Vulnerability × Impact; controls reduce likelihood or impact, never eliminate risk entirely
- **Defense-in-depth** layers administrative, technical, and physical controls so no single failure compromises the whole system

## Related concepts
[[CIA Triad]] [[Public Key Infrastructure]] [[Risk Management Framework]] [[Multi-Factor Authentication]] [[Defense in Depth]] [[Threat Intelligence]]