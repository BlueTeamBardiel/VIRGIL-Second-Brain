# Safe DLL Search Mode

## What it is
Think of it like a librarian who checks the restricted archive *first* before browsing the open public shelves — Safe DLL Search Mode forces Windows to look in trusted system directories before searching the application's current working directory. Specifically, it changes the DLL search order so that `%SYSTEMROOT%\System32` is prioritized over the current directory when resolving dynamic link library calls. It is controlled by the registry value `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\SafeDllSearchMode`.

## Why it matters
Without Safe DLL Search Mode enabled, an attacker performing **DLL Search Order Hijacking** can drop a malicious `version.dll` (or similar) into a writable directory like `C:\Program Files\TargetApp\`, and when the legitimate application launches, Windows loads the attacker's DLL instead of the real one. This technique was used in real-world privilege escalation chains — including against poorly configured enterprise software installers — to achieve code execution under SYSTEM context.

## Key facts
- **Enabled by default** on Windows Vista and later (`SafeDllSearchMode = 1`); when enabled, the current directory drops from position 2 to position 4 in the search order.
- Standard search order (Safe Mode ON): Known DLLs → executable's directory → System32 → 16-bit system → Windows directory → **current directory** → PATH directories.
- **KnownDLLs** registry key (`HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs`) provides an additional layer — these DLLs are cached at boot and bypass the search order entirely.
- Setting `SafeDllSearchMode = 0` reintroduces the current directory vulnerability and is a red-flag misconfiguration in security audits.
- DLL hijacking that exploits disabled Safe DLL Search Mode is a **MITRE ATT&CK T1574.001** technique.

## Related concepts
[[DLL Search Order Hijacking]] [[DLL Sideloading]] [[Privilege Escalation]] [[Windows Registry Security]] [[KnownDLLs]]