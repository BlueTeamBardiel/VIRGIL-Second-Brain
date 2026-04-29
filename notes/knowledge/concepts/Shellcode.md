# shellcode

## What it is
Like a locksmith's skeleton key hidden inside a greeting card — once the envelope is opened (the vulnerability triggered), the key falls out and opens whatever door it's pointed at. Shellcode is a small, self-contained payload of machine instructions injected into a vulnerable process to give an attacker control, classically by spawning a command shell (`/bin/sh` on Linux or `cmd.exe` on Windows).

## Why it matters
In 2003, the Slammer worm exploited a buffer overflow in Microsoft SQL Server by injecting 376 bytes of shellcode — the entire worm fit in a single UDP packet. This shellcode caused infected machines to spray copies of itself, taking down 75,000 hosts in 10 minutes, demonstrating how compact shellcode enables rapid, automated exploitation at scale.

## Key facts
- Shellcode is typically written in **position-independent code (PIC)** so it executes correctly regardless of where in memory it lands
- **NOP sleds** (`\x90\x90\x90...`) are prepended to shellcode to increase the chance of a successful jump when the exact injection address is uncertain
- Shellcode must **avoid null bytes** (`\x00`) in many exploits because C string functions treat them as terminators, prematurely cutting off the payload
- Modern defenses like **DEP/NX (Data Execution Prevention / No-Execute)** mark memory regions as non-executable, directly blocking shellcode from running
- **ASLR (Address Space Layout Randomization)** combats shellcode delivery by randomizing memory addresses, making hardcoded jump targets unreliable

## Related concepts
[[buffer overflow]] [[exploit development]] [[DEP/NX]] [[ASLR]] [[reverse shell]]