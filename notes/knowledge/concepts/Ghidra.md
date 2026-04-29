# Ghidra

## What it is
Like an MRI machine for software — it lets you see the internal structure of a program without cutting it open. Ghidra is a free, open-source reverse engineering framework developed by the NSA that disassembles and decompiles binary executables into human-readable code, allowing analysts to understand what a program does without access to its source code.

## Why it matters
When analysts discovered a novel ransomware sample (e.g., a variant of Conti) on a compromised endpoint, Ghidra enabled them to decompile the binary, identify the encryption key generation routine, and develop a decryptor — saving victim data without paying the ransom. Without reverse engineering tools, malware analysis would require running live samples in sandboxes alone, missing critical logic hidden by anti-sandbox evasion techniques.

## Key facts
- Released publicly by the NSA in 2019; written in Java and runs cross-platform (Windows, Linux, macOS)
- Supports disassembly and decompilation for dozens of architectures including x86, ARM, MIPS, and PowerPC
- Includes a scripting engine (Python and Java) for automating repetitive analysis tasks, such as identifying all XOR-based decryption loops
- Differs from IDA Pro in that it is free and open-source, making it the go-to tool for CTF competitions and budget-constrained security teams
- The decompiler output (pseudo-C code) is a key feature that distinguishes Ghidra from pure disassemblers like `objdump`, dramatically reducing analysis time

## Related concepts
[[Reverse Engineering]] [[Malware Analysis]] [[Static Analysis]] [[Disassembly]] [[IDA Pro]]