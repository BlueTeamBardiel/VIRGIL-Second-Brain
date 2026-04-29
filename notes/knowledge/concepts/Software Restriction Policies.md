# Software Restriction Policies

## What it is
Like a bouncer with a strict guest list who turns away anyone not on the approved roster, Software Restriction Policies (SRP) are a Windows Group Policy feature that controls which programs are allowed or denied execution on a system. Administrators define rules based on path, hash, certificate, or network zone to enforce an application allowlist or blocklist across endpoints.

## Why it matters
During a ransomware campaign, attackers frequently drop malicious executables into writable directories like `%APPDATA%` or `%TEMP%` to evade detection. A properly configured SRP with path rules that deny execution from those directories can stop the payload from running entirely, breaking the kill chain before encryption begins — no signature needed.

## Key facts
- SRP is configured via Group Policy under `Computer Configuration > Windows Settings > Security Settings > Software Restriction Policies`
- Four rule types exist: **Hash** (SHA-1 fingerprint), **Certificate** (signed publisher), **Path** (folder or registry path), and **Network Zone** (Internet Explorer zone — largely obsolete)
- Default security levels are **Unrestricted** (allow) or **Disallowed** (block); Unrestricted is the factory default, making explicit blocklisting the out-of-box behavior
- SRP has been largely superseded by **AppLocker** (Vista+) and **Windows Defender Application Control (WDAC)**, which offer more granular rule conditions and better audit logging
- Hash rules are the most tamper-resistant but require maintenance whenever software updates, since the hash changes with each new binary version

## Related concepts
[[AppLocker]] [[Windows Defender Application Control]] [[Group Policy]] [[Allowlisting]] [[Least Privilege]]