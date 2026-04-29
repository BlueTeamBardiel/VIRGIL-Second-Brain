# MITRE ATT&CK T1552.001

## What it is
Like a burglar who, after breaking into a house, immediately checks the notepad by the phone for passwords written down — adversaries search compromised filesystems for credentials stored in plaintext files. Formally, T1552.001 describes the technique of searching local file systems and network shares for files containing unsecured credentials such as passwords, API keys, or private keys stored in plaintext or weakly encoded formats.

## Why it matters
During the 2020 SolarWinds campaign, post-compromise actors searched victim environments for configuration files and scripts containing hardcoded credentials, enabling lateral movement across networks. Defenders counter this by implementing Data Loss Prevention (DLP) tools and running tools like `truffleHog` or `git-secrets` to detect credential exposure before attackers do.

## Key facts
- Common target files include `.bash_history`, `web.config`, `unattend.xml`, `.env` files, PowerShell scripts, and Group Policy Preference XML files (which historically stored encrypted but easily reversible passwords via `cpassword`)
- Windows Group Policy Preferences stored AES-256 encrypted passwords, but Microsoft published the decryption key — making GPP credentials trivially recoverable until MS14-025 patched it
- Attackers frequently use commands like `findstr /si password *.txt *.xml *.ini` on Windows or `grep -r "password" /` on Linux to automate credential discovery
- This technique falls under the **Credential Access** tactic (TA0006) and is a sub-technique of T1552 (Unsecured Credentials)
- Detection focus: monitor for bulk file reads across sensitive directories, especially by processes not normally associated with file scanning

## Related concepts
[[T1552 Unsecured Credentials]] [[Credential Dumping]] [[T1083 File and Directory Discovery]] [[Group Policy Preferences Abuse]] [[Secrets Management]]