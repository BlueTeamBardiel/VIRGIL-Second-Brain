# Application Whitelisting

## What it is
Think of it like a velvet-rope nightclub where only pre-approved guests on the list get in — everything else is turned away at the door, no exceptions. Application whitelisting is a security control that permits only explicitly approved software to execute on a system, blocking all unlisted programs by default. It is the inverse of blacklisting, which blocks known-bad software while allowing everything else.

## Why it matters
During the 2010 Operation Aurora attacks against Google and other enterprises, attackers used custom malware that no antivirus signature recognized. Application whitelisting would have stopped the payload cold — the malicious executable wasn't on any approved list, so it simply couldn't run, regardless of whether it was "known bad." This is why whitelisting is considered one of the most effective mitigations against zero-day malware and living-off-the-land attacks.

## Key facts
- **Default-deny posture**: Unlike blacklisting (default-allow), whitelisting blocks execution of *anything* not explicitly authorized — including novel malware.
- **Windows AppLocker** and **Software Restriction Policies (SRP)** are native Windows tools for implementing whitelisting; AppLocker allows rules based on publisher, path, or file hash.
- **NIST SP 800-167** is the authoritative guide for application whitelisting implementation in enterprise environments.
- **Limitations**: High administrative overhead — every legitimate software update may require whitelist updates, and misconfigurations can break business operations.
- **Bypass techniques** include DLL hijacking, trusted process abuse (e.g., using `mshta.exe` or `regsvr32.exe` as LOLBins), making proper policy scope critical.

## Related concepts
[[Default-Deny Security Model]] [[Blacklisting]] [[AppLocker]] [[Living-off-the-Land Attacks]] [[Least Privilege]]