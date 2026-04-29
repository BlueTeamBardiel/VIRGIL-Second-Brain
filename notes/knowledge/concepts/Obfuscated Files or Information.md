# Obfuscated Files or Information

## What it is
Like a smuggler hiding contraband inside a hollowed-out book, obfuscation conceals malicious code or data by transforming it into something that appears benign or unreadable. Precisely, it is the technique of disguising the true content, purpose, or structure of a file, script, or payload to evade detection by security tools, analysts, or automated scanners. It does not encrypt for confidentiality — it obscures for evasion.

## Why it matters
In the 2020 SolarWinds attack, adversaries embedded backdoor code inside a legitimate software update by obfuscating it as routine telemetry logic, allowing it to bypass static analysis tools for months. Defenders must configure EDR solutions and SIEMs to flag indicators like unusual Base64 strings in scripts, high-entropy file sections, or PowerShell commands invoking `-EncodedCommand`.

## Key facts
- **MITRE ATT&CK T1027** catalogs this technique; sub-techniques include binary padding, software packing, and HTML smuggling
- Common obfuscation methods: Base64 encoding, XOR encryption of payloads, string concatenation in scripts, steganography, and packing executables with tools like UPX
- PowerShell's `-EncodedCommand` flag is a top red-team favorite and a primary detection target in Windows environments
- High entropy (randomness score near 8.0) in a file section is a strong forensic indicator of packed or encrypted content
- Obfuscation is **not** the same as encryption — it prioritizes concealment from analysis, not confidentiality of data

## Related concepts
[[Defense Evasion]] [[Indicator Removal]] [[Steganography]] [[Code Injection]] [[Static vs Dynamic Analysis]]