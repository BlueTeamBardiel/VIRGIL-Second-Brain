# Brute Ratel C4

## What it is
Think of it as a lockpick set *designed by a locksmith specifically to defeat the alarm systems locksmiths install* — it was built by a former red teamer with intimate knowledge of EDR detection logic. Brute Ratel C4 (BRc4) is a commercial adversary simulation and post-exploitation framework, similar to Cobalt Strike, but engineered from the ground up to evade endpoint detection and response (EDR) tools by avoiding common behavioral signatures.

## Why it matters
In 2022, threat intelligence researchers at Palo Alto Unit 42 discovered BRc4 samples being deployed by APT groups, including actors linked to Russia's APT29 (Cozy Bear), after cracked/leaked copies circulated outside legitimate red team purchasers. This demonstrated that commercial offensive tools designed for authorized testing can rapidly become weapons for nation-state actors, forcing defenders to build specific detections for legitimate-but-weaponized tooling.

## Key facts
- Developed by Chetan Nayak (aka RastaMouse) and sold commercially as a licensed red team tool, distinct from open-source C2 frameworks
- Uses **badgers** (BRc4's term for implants/agents) rather than Cobalt Strike's "beacons," with built-in EDR and AMSI bypass capabilities
- Specifically designed to avoid ETW (Event Tracing for Windows) telemetry, making it harder for SIEMs and AV engines to log its activity
- Cracked versions appeared in the wild by mid-2022, distributed via ISO files mimicking legitimate software — a tactic mirroring APT tradecraft
- Detection relies on behavioral indicators (e.g., unusual parent-child process relationships, memory injection patterns) rather than static signatures

## Related concepts
[[Cobalt Strike]] [[Command and Control (C2)]] [[EDR Evasion]] [[Advanced Persistent Threat (APT)]] [[Post-Exploitation]]