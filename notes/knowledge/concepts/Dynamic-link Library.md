# Dynamic-link Library

## What it is
Think of a DLL like a power strip in an office — multiple appliances (programs) plug into the same shared outlet (library) rather than each needing their own dedicated power source. Precisely, a Dynamic-link Library (DLL) is a compiled code module containing functions and resources that Windows processes can load and share at runtime, rather than statically embedding that code into each executable at compile time.

## Why it matters
DLL hijacking is a classic privilege escalation and persistence technique: an attacker drops a malicious DLL with the same name as a legitimate one into a directory that Windows searches *before* the real DLL's location (exploiting the DLL search order). When a privileged application loads, it unknowingly executes the attacker's code instead — famously abused in the Stuxnet worm via `.lnk` file loading and in countless red team engagements targeting unquoted service paths.

## Key facts
- **DLL Search Order (Windows):** Application directory → System32 → System → Windows → Current working directory → PATH directories; attackers exploit early positions in this chain
- **DLL Injection** allows attackers to force a running process to load a malicious DLL, enabling code execution within that process's memory space and security context
- **Reflective DLL Injection** loads a DLL entirely from memory without touching disk, evading file-based AV detection — a hallmark of advanced malware
- **SafeDllSearchMode** (enabled by default in modern Windows) moves the current working directory later in the search order, reducing one common hijack vector
- DLL files use the **PE (Portable Executable)** format, same as `.exe` files, and can be identified by `MZ` magic bytes at the file header

## Related concepts
[[DLL Hijacking]] [[Process Injection]] [[Privilege Escalation]] [[Windows Registry]] [[Living off the Land Binaries]]