# AMSI Bypass

## What it is
Imagine a security guard at a concert who checks everyone's bag — but a VIP can slip them a note saying "I already checked, it's fine." AMSI (Antimalware Scan Interface) is Windows' built-in API that feeds script content to antivirus engines before execution; a bypass is any technique that corrupts, patches, or lies to that interface so malicious scripts run without ever being inspected.

## Why it matters
In the 2021 NOBELIUM/SolarWinds campaign follow-on activity, attackers used PowerShell-based AMSI bypasses to load Cobalt Strike beacons in memory without touching disk, evading endpoint detection entirely. Defenders hunting for this look for process memory patches in `amsi.dll` or anomalous `AmsiScanBuffer` return values as indicators of compromise.

## Key facts
- AMSI hooks into PowerShell, VBScript, JScript, .NET, and Office VBA — **not** compiled PE executables, which are handled separately by the AV engine.
- The classic bypass patches the `AmsiScanBuffer` function in memory to always return `AMSI_RESULT_CLEAN` (value `1`), requiring only a few bytes changed in the process's own memory space.
- String obfuscation (e.g., splitting `"amsiutils"` into `"amsi"+"utils"`) can evade signature-based AMSI detection because AMSI scans the *assembled* string — but only if concatenation happens at runtime after the scan.
- Running with a **downgraded PowerShell v2** (`powershell -version 2`) bypasses AMSI entirely because v2 predates the interface.
- AMSI bypasses are classified under **Defense Evasion (T1562.001)** in the MITRE ATT&CK framework.

## Related concepts
[[PowerShell Security]] [[Living Off the Land (LOLBins)]] [[Defense Evasion]] [[Endpoint Detection and Response (EDR)]] [[Reflective DLL Injection]]