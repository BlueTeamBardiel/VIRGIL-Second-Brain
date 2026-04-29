# Obfuscation Techniques

## What it is
Like a chef who replaces plain ingredient names with obscure culinary jargon so a competitor stealing the recipe can't easily reproduce the dish — obfuscation is the deliberate act of making code, data, or communications difficult to understand without changing their functionality. It is a technique used by both attackers (to hide malware logic from analysts and AV engines) and defenders (to protect intellectual property or slow reverse engineering).

## Why it matters
The 2017 NotPetya malware used heavily obfuscated PowerShell scripts to execute its payload while evading signature-based detection — the obfuscation bought critical time before defenders understood what was executing on their networks. This is why static analysis alone is insufficient; analysts must also perform dynamic (behavioral) analysis to catch obfuscated threats.

## Key facts
- **Base64 encoding** is the most common obfuscation primitive — it doesn't encrypt data but makes it unreadable at a glance; defenders should treat Base64-encoded commands in logs as an immediate red flag
- **String concatenation and variable substitution** fragment recognizable keywords (e.g., `"pow" + "ershell"`) to defeat simple signature matching in AV and SIEM rules
- **Packers and crypters** compress or encrypt executables and decompress them in memory at runtime, hiding malicious payloads from static file scanning (UPX is the most common packer)
- **Dead code insertion and junk instructions** inflate malware size and confuse disassemblers, making reverse engineering slower and costlier
- On Security+/CySA+, obfuscation is classified as an **anti-forensics technique** and is closely tied to **indicators of compromise (IoC)** identification challenges

## Related concepts
[[Anti-Forensics]] [[Static vs Dynamic Analysis]] [[Malware Analysis]] [[Indicators of Compromise]] [[PowerShell Attack Techniques]]