# Application Whitelisting Bypass

## What it is
Like sneaking contraband into a stadium by hiding it inside an approved vendor's uniform, application whitelisting bypass tricks security controls into executing malicious code by piggybacking on trusted, pre-approved applications. Precisely: it is a technique where an attacker leverages legitimately signed or trusted binaries — already permitted by policy — to execute arbitrary commands or payloads, circumventing controls that block unknown executables.

## Why it matters
In 2017, threat actors targeting financial institutions used **regsvr32.exe** (a trusted Windows binary) to pull down and execute malicious COM scriptlets from remote servers — a technique called "Squiblydoo." The attack bypassed AppLocker entirely because regsvr32 was whitelisted and the payload never touched disk in a traditional executable form.

## Key facts
- **Living off the Land Binaries (LOLBins)** like `mshta.exe`, `certutil.exe`, `regsvr32.exe`, and `rundll32.exe` are the primary vehicles for bypass because they are signed by Microsoft and trusted by default
- **AppLocker and Software Restriction Policies (SRP)** are the two main Windows whitelisting mechanisms; AppLocker is more granular, operating on publisher, path, and hash rules
- Attackers exploit **writable trusted directories** (e.g., `C:\Windows\Temp`) to place malicious DLLs loaded by trusted processes — a path-rule weakness
- **DLL hijacking** against whitelisted applications is a common bypass: the app is permitted, but it loads an attacker-controlled library
- Mitigations include enabling **script block logging**, restricting LOLBin execution via additional AppLocker rules, and deploying **Microsoft Defender Application Control (WDAC)** for stronger enforcement than AppLocker alone

## Related concepts
[[Living Off the Land (LOLBins)]] [[AppLocker]] [[DLL Hijacking]] [[Defense Evasion]] [[Code Signing]]