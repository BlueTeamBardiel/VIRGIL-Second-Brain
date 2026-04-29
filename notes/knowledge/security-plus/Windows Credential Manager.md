# Windows Credential Manager

## What it is
Think of it as a locked filing cabinet built into Windows where the OS stores sticky notes of usernames and passwords so you don't have to retype them. Precisely, Windows Credential Manager is a built-in credential store that saves authentication data — web credentials, Windows credentials, and certificate-based credentials — in an encrypted vault tied to the user's account (DPAPI-protected). It serves applications like Remote Desktop, mapped network drives, and browsers that opt into it.

## Why it matters
An attacker who gains local access or code execution on a victim's machine can dump Credential Manager contents using tools like **Mimikatz** (`sekurlsa::wdigest`) or the built-in `cmdkey /list` command — harvesting plaintext or reusable credentials without ever touching the network. This technique is catalogued under **MITRE ATT&CK T1555.004 (Credentials from Password Stores: Windows Credential Manager)** and is a common lateral movement enabler in enterprise breaches.

## Key facts
- Credentials are encrypted using **DPAPI (Data Protection API)**, tied to the user's login password — if you know the user's password, you can decrypt the vault
- Three types stored: **Windows Credentials** (NTLM/Kerberos), **Certificate-Based Credentials**, and **Generic Credentials** (apps/web)
- Accessible via GUI (`Control Panel > Credential Manager`) or CLI (`cmdkey /list` to view, `cmdkey /delete` to remove)
- Attackers can extract credentials offline from the vault files located at `%APPDATA%\Microsoft\Credentials\`
- Defenders should audit Credential Manager contents during incident response; excessive stored credentials are a persistence risk

## Related concepts
[[DPAPI (Data Protection API)]] [[Mimikatz]] [[Credential Dumping]] [[LSASS Memory Attacks]] [[Lateral Movement]]