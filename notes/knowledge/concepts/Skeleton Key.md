# Skeleton Key

## What it is
Like a master key cut to open every lock in a building without changing the locks themselves, a Skeleton Key attack injects malicious code directly into a domain controller's LSASS process, allowing an attacker to authenticate as *any* user with a single hardcoded password — while legitimate user passwords continue working normally. It is an in-memory implant, not a persistent backdoor written to disk, that patches Active Directory authentication in real time.

## Why it matters
In a 2015 incident investigated by Dell SecureWorks, attackers who had already gained domain admin access deployed Skeleton Key against a financial organization's domain controllers, enabling them to move laterally across the entire enterprise using the password "mimikatz" for any account — including service accounts — while defenders saw nothing unusual in user login behavior. Detection required memory forensics rather than log analysis, because no new accounts were created and no passwords were changed.

## Key facts
- Requires **Domain Admin or SYSTEM privileges** on the domain controller before deployment — it is post-exploitation, not an initial access technique
- Patches the `msv1_0.dll` authentication provider inside **LSASS memory** to accept a second, attacker-chosen password for all accounts
- Attack is **not persistent** — a domain controller reboot removes the implant entirely
- Primarily implemented via **Mimikatz** using the command `misc::skeleton`
- Kerberos with **AES encryption enforced** (rather than RC4/NTLM fallback) significantly reduces effectiveness; enabling **Protected Users security group** and **Credential Guard** blocks the LSASS injection vector

## Related concepts
[[Pass-the-Hash]] [[LSASS Dumping]] [[Mimikatz]] [[Golden Ticket]] [[Credential Guard]]