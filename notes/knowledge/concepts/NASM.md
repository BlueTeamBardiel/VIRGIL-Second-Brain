# NASM

## What it is
Like a translator who converts your handwritten recipe into precise machine-readable barcodes, NASM (Netwide Assembler) converts human-readable x86 assembly language into raw machine code (object files) that a CPU can execute directly. It is an open-source assembler widely used on Linux and Windows for writing low-level programs, shellcode, and exploit payloads.

## Why it matters
In penetration testing and exploit development, attackers use NASM to craft custom shellcode — for example, a 24-byte `execve("/bin/sh")` payload assembled with NASM and injected into a vulnerable buffer overflow to spawn a root shell. Defenders and malware analysts encounter NASM-compiled artifacts when reverse engineering exploits, making familiarity with its output essential for recognizing shellcode patterns in memory forensics.

## Key facts
- NASM uses **Intel syntax** (destination first: `mov eax, 1`), distinct from AT&T syntax used by GAS — this distinction frequently appears in exploit code analysis
- Outputs multiple formats: **ELF** (Linux), **PE** (Windows), **bin** (raw binary/shellcode) — the `-f bin` flag produces format-free shellcode ideal for injection
- Shellcode written in NASM must be **position-independent** and **null-byte free** to survive string-based injection vectors like `strcpy()`
- NASM is the standard tool taught in **OSCP** and exploit development courses for converting assembly exploits into injectable byte strings
- The **NASM + ld** toolchain (assemble then link) is the typical workflow: `nasm -f elf64 shell.asm -o shell.o && ld shell.o -o shell`

## Related concepts
[[Buffer Overflow]] [[Shellcode]] [[Reverse Engineering]] [[Position-Independent Code]] [[ELF Binary Format]]