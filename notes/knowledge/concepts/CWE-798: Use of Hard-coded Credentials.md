# CWE-798: Use of Hard-coded Credentials

## What it is
Imagine a building where the master key is literally painted on the front door — anyone who looks closely enough can get in. Hard-coded credentials are exactly that: usernames, passwords, API keys, or cryptographic secrets embedded directly in source code, firmware, or compiled binaries, unchangeable without modifying the software itself.

## Why it matters
In 2016, researchers found that Fortinet's FortiOS SSH daemon contained a hard-coded backdoor password ("FGTAbc11*xy+Qqz27"), allowing any attacker who discovered it to authenticate as a superuser on any unpatched device. Because the credential was baked into firmware shipped to thousands of enterprise customers, there was no simple "rotate the password" fix — every device required a vendor patch before it could be secured.

## Key facts
- Hard-coded credentials appear in source code repos (GitHub leaks are common), decompiled binaries, firmware extracted via `binwalk`, and configuration files committed to version control.
- Tools like `truffleHog`, `gitleaks`, and `strings` are used by both attackers and defenders to discover embedded secrets.
- CVSS scores for hard-coded credentials are frequently **Critical (9.8)** because they enable authentication bypass with zero user interaction.
- The fix requires externalizing secrets into environment variables, secrets managers (HashiCorp Vault, AWS Secrets Manager), or encrypted configuration files — not just obfuscation.
- Distinct from CWE-259 (Hard-coded Password) which is a child node; CWE-798 is the parent covering all credential types including certificates and API tokens.

## Related concepts
[[CWE-259: Hard-coded Password]] [[Secrets Management]] [[Credential Exposure]] [[Static Code Analysis]] [[Firmware Reverse Engineering]]