# pwntools

## What it is
Like a Swiss Army knife pre-loaded specifically for a safecracker, pwntools is a Python CTF framework and exploit development library that gives attackers ready-made tools for interacting with, manipulating, and exploiting binary programs. It handles the tedious plumbing — socket connections, process spawning, binary parsing, ROP chain construction — so researchers can focus on the vulnerability logic itself.

## Why it matters
During a penetration test against a Linux server running a vulnerable SUID binary, a researcher can use pwntools to automate the entire exploit chain: calculate the exact buffer overflow offset with `cyclic()`, build a ROP gadget chain using `ROP()`, and deliver the payload via `process()` or `remote()` — all in under 50 lines of Python. This dramatically compresses the time from "identified vulnerability" to "achieved shell," which is exactly why it appears constantly in CTF competitions and real-world red team engagements.

## Key facts
- Written in Python 3; installed via `pip install pwntools`; primary import is `from pwn import *`
- `cyclic()` and `cyclic_find()` generate and identify De Bruijn sequences to pinpoint exact EIP/RIP overwrite offsets
- `p32()` / `p64()` pack integers into little-endian bytes, handling the endianness math that manual exploit writing gets wrong
- `ELF()` parses binary files to extract function addresses, GOT/PLT entries, and enabled protections (NX, PIE, canaries) via `checksec`
- Supports multiple tube types: `process()` for local binaries, `remote()` for network sockets, `ssh()` for remote shell sessions — all sharing the same `send()`/`recv()` API

## Related concepts
[[Buffer Overflow]] [[Return-Oriented Programming]] [[ASLR]] [[CTF (Capture the Flag)]] [[ELF Binary Format]]