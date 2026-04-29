# Executable

## What it is
Like a recipe that a chef can actually cook versus one written in a foreign language, an executable is a file the operating system can directly run — not just read. Precisely, it's a binary file containing machine code (or bytecode for interpreted runtimes) that the OS loader maps into memory and hands control to the CPU for execution.

## Why it matters
Attackers frequently disguise malicious executables by changing the file extension (e.g., renaming `malware.exe` to `invoice.pdf.exe`) exploiting Windows' default behavior of hiding known extensions. When a victim double-clicks the file, the OS loader executes the payload regardless of the fake extension — a technique heavily used in phishing campaigns delivering ransomware like Emotet and TrickBot.

## Key facts
- On Windows, the PE (Portable Executable) format governs `.exe`, `.dll`, and `.sys` files; on Linux, ELF (Executable and Linkable Format) is the standard
- The OS uses file **magic bytes** (e.g., `MZ` header `4D 5A` for PE files), not extensions, to determine if a file is executable
- **ASLR** (Address Space Layout Randomization) and **DEP/NX** (Data Execution Prevention / No-Execute bit) are OS-level defenses that make arbitrary code execution harder
- Application whitelisting (e.g., Windows AppLocker) blocks unauthorized executables from running, even if they reach the filesystem
- Fileless malware avoids dropping executables to disk entirely — it injects shellcode into legitimate processes like `powershell.exe` to evade file-based AV detection

## Related concepts
[[Portable Executable (PE) Format]] [[Code Injection]] [[Application Whitelisting]] [[ASLR]] [[Fileless Malware]]