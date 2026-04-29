# Abuse Elevation Control Mechanism

## What it is
Like a thief who sweet-talks a bank guard into opening the vault door instead of picking the lock themselves, this technique involves manipulating *legitimate* OS privilege-escalation features to gain elevated access rather than exploiting a vulnerability directly. Specifically, it is the adversarial abuse of mechanisms designed to control how processes obtain elevated privileges — such as UAC on Windows, sudo on Linux, or setuid binaries — to execute malicious code with higher permissions.

## Why it matters
In the 2020 SolarWinds attack, adversaries leveraged scheduled tasks and service permissions (elevation control features) to run implants under SYSTEM-level context without triggering traditional exploit alerts. Defenders who only hunt for exploit signatures miss these attacks entirely, which is why monitoring *who requests elevation and how* is as important as patching vulnerabilities.

## Key facts
- **MITRE ATT&CK T1548** covers this technique family, including sub-techniques for UAC Bypass, Sudo/Sudo Caching abuse, Setuid/Setgid abuse, and Token Impersonation.
- **UAC Bypass** techniques (e.g., DLL hijacking in auto-elevated processes like `eventvwr.exe`) exploit the fact that certain Windows processes elevate silently without a UAC prompt.
- **Sudo caching** abuses the default 15-minute credential cache window — malware can execute `sudo` commands within that window without re-prompting the user.
- **Setuid binaries** on Linux, if misconfigured or vulnerable, allow a lower-privileged user to run code as root by exploiting the file permission bit.
- Detection focus: log **Event ID 4688** (process creation) on Windows and `/var/log/auth.log` sudo entries on Linux for unexpected elevation chains.

## Related concepts
[[Privilege Escalation]] [[User Account Control (UAC)]] [[Access Token Manipulation]] [[Sudo and Sudo Caching]] [[Least Privilege Principle]]