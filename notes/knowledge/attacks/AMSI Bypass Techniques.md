# AMSI Bypass Techniques

## What it is
Like spray-painting over a security camera lens before robbing a store, AMSI bypasses blind the scanner before the malicious payload ever runs. The Antimalware Scan Interface (AMSI) is a Windows API that allows security products to inspect scripts and code at runtime — AMSI bypass techniques are methods attackers use to disable, corrupt, or circumvent this inspection layer before executing malicious PowerShell, VBScript, or .NET code.

## Why it matters
During the 2021 LAPSUS$ and numerous ransomware campaigns, attackers used PowerShell-based AMSI bypasses to execute fileless malware that never touched disk — rendering traditional signature-based AV blind. Defenders who monitor for AMSI tamper events (Event ID 4104 with suspicious pattern strings) can catch these techniques even when the payload itself evades detection.

## Key facts
- **Memory patching**: The most common bypass overwrites the `amsi.dll` `AmsiScanBuffer()` function in memory with a return value of `AMSI_RESULT_CLEAN`, neutralizing all subsequent scans in that process.
- **Obfuscation splitting**: Splitting AMSI-flagged strings (e.g., `"Am" + "siUtils"`) defeats static signature matching before the bypass executes.
- **Reflection-based bypass**: Using .NET reflection to access the `AmsiContext` field and set it to null crashes AMSI silently without triggering obvious alerts.
- **Downgrade attacks**: Forcing PowerShell to run in version 2 (`-Version 2`) skips AMSI entirely, since AMSI integration only exists in PowerShell v3+.
- **AMSI Provider unregistration**: Attackers with admin rights can remove AMSI provider registry keys under `HKLM\SOFTWARE\Microsoft\AMSI\Providers`, permanently disabling scanning.

## Related concepts
[[Fileless Malware]] [[PowerShell Attack Techniques]] [[Windows Defender Application Control]] [[Endpoint Detection and Response]] [[Living Off the Land Binaries]]