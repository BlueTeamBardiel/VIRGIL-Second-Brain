# AMSI

## What it is
Think of AMSI as a universal USB port built into Windows — it lets any antivirus plug directly into the memory of a running script and inspect its contents before execution. The Antimalware Scan Interface (AMSI) is a Windows API framework introduced in Windows 10 that allows applications (especially scripting engines like PowerShell, VBScript, and Office macros) to request real-time content scanning from any registered security product. Crucially, it scans the *deobfuscated*, in-memory content — meaning it sees what the code actually does, not how it's disguised.

## Why it matters
Fileless malware attacks frequently rely on PowerShell to download and execute malicious payloads entirely in memory, bypassing traditional file-based AV scanning. AMSI breaks this technique by intercepting the script content at runtime and feeding it to the installed AV engine — tools like Empire or Cobalt Strike beacon loaders are flagged this way. This is why AMSI bypass techniques (patching `amsi.dll` in memory, reflection-based nullification, or string obfuscation to avoid trigger signatures) have become a staple of modern red team operations.

## Key facts
- AMSI integrates with PowerShell, Windows Script Host, JavaScript/VBScript, Office VBA macros, and .NET assemblies by default
- Security products must **register** with AMSI to receive scan requests — it is not standalone protection itself
- A classic bypass involves reflectively patching the `AmsiScanBuffer` function in memory to always return `AMSI_RESULT_CLEAN` (error code 0x80070057)
- AMSI events are logged in Windows Event Log under **Microsoft-Windows-AMSI/Operational** (Event ID 1101/1102), useful for threat hunting
- Disabling AMSI requires administrative or SYSTEM privileges, making it a privilege escalation indicator when observed

## Related concepts
[[PowerShell Logging]] [[Fileless Malware]] [[Windows Defender]] [[EDR]] [[Living Off the Land Attacks]]