# Application Allowlisting

## What it is
Like a nightclub with a strict VIP list — if your name isn't on it, you're not getting in, no matter how legitimate you look. Application allowlisting is a security control that permits *only* explicitly approved executables, scripts, and libraries to run on a system, blocking everything else by default.

## Why it matters
During the 2017 NotPetya outbreak, ransomware spread by hijacking legitimate Windows tools like `psexec` and `wmic`. Organizations with mature allowlisting policies could block these execution paths even when the binaries were "trusted" Windows components — because those specific execution contexts weren't pre-approved. It's one of the few controls that stops fileless malware and living-off-the-land (LotL) attacks cold.

## Key facts
- **Default-deny posture**: Unlike blocklisting (deny known bad), allowlisting denies everything unless explicitly permitted — fundamentally inverting the security model.
- **NSA/CISA list it as a top mitigation**: It's consistently ranked in the top controls for preventing advanced persistent threat (APT) activity.
- **Common implementations**: Microsoft AppLocker and Windows Defender Application Control (WDAC) are the primary enterprise tools; WDAC is the modern, more tamper-resistant successor.
- **Rules can be path-, hash-, or publisher-based**: Hash rules are most secure (exact file match), but require maintenance; publisher rules are more flexible but can be spoofed if a cert is compromised.
- **Biggest weakness — admin overhead**: Environments with frequent software updates require constant rule maintenance, and misconfigured policies can break legitimate business applications.

## Related concepts
[[Defense in Depth]] [[Blocklisting]] [[Privilege Escalation]] [[Living off the Land Attacks]] [[Endpoint Detection and Response]]