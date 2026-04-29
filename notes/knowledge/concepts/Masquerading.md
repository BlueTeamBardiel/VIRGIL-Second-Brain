# Masquerading

## What it is
Like a wolf wearing a sheep's wool coat to walk freely through the flock, masquerading is when a threat actor or malicious process pretends to be something trusted to gain access or avoid detection. Precisely, it is the act of disguising an identity — a user, process, or system — by assuming the credentials, name, or attributes of a legitimate entity.

## Why it matters
In the 2020 SolarWinds supply chain attack, malicious code was injected into a legitimate software update signed with a trusted certificate, causing thousands of organizations to willingly install it — a textbook masquerade at the software level. Defenders counter this by implementing code signing validation, multi-factor authentication, and behavioral analytics that flag processes acting outside their expected baseline, even when they carry legitimate names.

## Key facts
- **MITRE ATT&CK T1036** formally categorizes masquerading as a defense evasion technique, including tactics like renaming malicious executables to match system binaries (e.g., naming malware `svchost.exe`)
- Masquerading differs from **impersonation** in scope: impersonation targets a specific user identity, while masquerading can apply to processes, services, or entire systems
- **Token theft/pass-the-hash** attacks are a technical form of masquerading — the attacker doesn't crack a password, they reuse the credential artifact itself
- Placing malware in legitimate-looking directories (e.g., `C:\Windows\System32\`) reinforces the masquerade by exploiting path-based trust
- Detection relies heavily on **process lineage analysis** — a browser spawning `cmd.exe` or a service running from an unexpected directory breaks the expected parent-child process chain

## Related concepts
[[Impersonation]] [[Pass-the-Hash]] [[Defense Evasion]] [[Code Signing]] [[Process Injection]]