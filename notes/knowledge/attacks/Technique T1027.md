# Technique T1027

## What it is
Like a smuggler hiding contraband inside a hollowed-out book, obfuscation conceals malicious code inside something that looks harmless or unreadable. T1027 (Obfuscated Files or Information) is the adversary practice of making payloads, scripts, or configurations deliberately difficult to analyze — through encoding, encryption, compression, or garbled variable names — to evade detection by security tools and analysts.

## Why it matters
During the 2020 SolarWinds supply chain attack, SUNBURST malware used extensive obfuscation including encoded strings and dormant timers to blend into legitimate Orion software updates, delaying detection for months. Defenders who could parse obfuscated PowerShell (e.g., Base64-decoded `-EncodedCommand` strings) were able to identify the threat far sooner than those relying purely on signature-based tools.

## Key facts
- **Sub-techniques include:** Binary Padding (T1027.001), Software Packing (T1027.002), Steganography (T1027.003), Compile After Delivery (T1027.004), and Indicator Removal from Tools (T1027.005)
- PowerShell's `-EncodedCommand` flag is one of the most commonly abused obfuscation vectors in the wild; defenders should log and decode all Base64-encoded PowerShell invocations
- Packed executables have abnormally high entropy values (typically >7.0 out of 8.0) — entropy analysis is a fast triage method for flagging suspicious binaries
- T1027 maps to the **Defense Evasion** tactic in the MITRE ATT&CK framework — its primary goal is bypassing AV/EDR, not achieving initial access
- YARA rules and tools like `de4dot` (for .NET), `unipacker`, and CyberChef are standard analyst tools for deobfuscation

## Related concepts
[[T1059 Command and Scripting Interpreter]] [[T1140 Deobfuscate/Decode Files or Information]] [[Defense Evasion Tactic]] [[Static Malware Analysis]] [[Entropy Analysis]]