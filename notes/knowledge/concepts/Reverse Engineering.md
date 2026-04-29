# Reverse Engineering

## What it is
Like a chef tasting a competitor's dish and working backward to reconstruct the recipe, reverse engineering takes a finished binary or system and reconstructs its logic, structure, and intent without access to the original source code. Formally, it is the process of analyzing a compiled application, firmware, or protocol to understand its functionality, identify vulnerabilities, or extract embedded secrets.

## Why it matters
When the Stuxnet worm was discovered in 2010, researchers had no source code — only a weaponized binary. Through reverse engineering using tools like IDA Pro and OllyDbg, analysts dissected the malware to discover it was specifically targeting Siemens PLCs controlling Iranian uranium centrifuges, revealing one of the most sophisticated cyberweapons ever documented. Without reverse engineering, the attack's true purpose might never have been understood.

## Key facts
- **Disassembly vs. Decompilation**: Disassemblers (e.g., IDA Pro, Ghidra) convert machine code to assembly; decompilers (e.g., Ghidra's decompiler, RetDec) attempt to reconstruct higher-level pseudocode — decompilation is less precise but faster to analyze.
- **Static vs. Dynamic Analysis**: Static analysis examines code without executing it; dynamic analysis runs the binary in a controlled sandbox (e.g., Cuckoo Sandbox) to observe real-time behavior including API calls and network traffic.
- **Anti-reversing techniques**: Malware commonly uses obfuscation, packing (UPX), and anti-debugging tricks (e.g., `IsDebuggerPresent` checks) to resist analysis.
- **Legal boundary**: Reverse engineering for interoperability is protected under DMCA Section 1201(f), but cracking license protections for piracy is illegal — relevant for Security+ legal/compliance objectives.
- **Ghidra** is a free, open-source reverse engineering suite released by the NSA, widely used in both CTF competitions and professional malware analysis.

## Related concepts
[[Malware Analysis]] [[Static Code Analysis]] [[Fuzzing]] [[Obfuscation]] [[Threat Intelligence]]