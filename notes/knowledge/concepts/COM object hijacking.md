# COM object hijacking

## What it is
Imagine a city where every business lists its address in a single phone book — if you can publish a *fake* listing before the real one, every caller gets routed to you instead. COM object hijacking works the same way: attackers register a malicious COM object in `HKCU\Software\Classes\CLSID` (the per-user registry hive), which Windows resolves *before* the legitimate entry in `HKLM`, silently redirecting legitimate application calls to attacker-controlled code.

## Why it matters
APT groups like APT29 (Cozy Bear) have used COM hijacking as a persistence mechanism because it requires **no administrative privileges** and blends into normal Windows behavior — the malicious DLL loads whenever a legitimate application (like Task Scheduler or Explorer) calls the hijacked CLSID. Defenders hunting for this technique look for unexpected DLLs loaded from user-writable paths and mismatches between HKCU and HKLM CLSID registrations.

## Key facts
- Exploits Windows COM resolution order: `HKCU` registry is searched **before** `HKLM`, giving unprivileged users insertion priority
- Mapped to **MITRE ATT&CK T1546.015** under Event Triggered Execution (persistence + privilege escalation tactic)
- Requires no UAC bypass — standard user accounts can write to `HKCU\Software\Classes\CLSID`
- Common hunting signal: DLLs loaded from `%APPDATA%` or `%TEMP%` paths instead of `System32`
- Sysinternals **Process Monitor** filtered on `RegOpenKey` with "NAME NOT FOUND" results is the classic discovery method

## Related concepts
[[DLL hijacking]] [[Windows Registry persistence]] [[MITRE ATT&CK persistence techniques]] [[UAC bypass]] [[Living off the Land (LotL)]]