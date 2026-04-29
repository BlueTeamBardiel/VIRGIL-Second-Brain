# PE files

## What it is
Think of a PE file like a shipping container with a standardized manifest — customs officials (the OS loader) read the manifest to know what's inside, where to unpack it, and what resources it needs. A Portable Executable (PE) file is the standard binary format for executables, DLLs, and drivers on Windows systems. The format defines a structured header containing metadata that tells the OS how to load the program into memory and begin execution.

## Why it matters
Malware analysts routinely inspect PE headers to detect packed or obfuscated executables — a legitimate program rarely has an enormous `.text` section entropy value near 8.0, but a UPX-packed trojan almost always does. Defenders use tools like PEview or PE-bear to examine the Import Address Table (IAT) and spot suspicious API calls like `VirtualAlloc` + `WriteProcessMemory` chained together, a classic shellcode injection signature.

## Key facts
- The PE header begins with the DOS MZ header (`0x4D5A`), followed by the PE signature (`0x50450000` / "PE\0\0") — these magic bytes are primary malware identification markers
- The **Import Address Table (IAT)** lists every external DLL function the executable calls; malware often imports `LoadLibrary` and `GetProcAddress` to hide its true imports at static analysis time
- **Section headers** define segments like `.text` (code), `.data` (initialized data), and `.rsrc` (resources); abnormal section names or mismatched virtual vs. raw sizes are red flags
- High entropy (>7.0) in PE sections indicates compression or encryption, a common indicator of packing used to evade signature-based AV
- PE files are **position-independent** only when compiled as such (ASLR support); the optional header contains the preferred base load address and ASLR/DEP flags (DllCharacteristics field)

## Related concepts
[[ASLR]] [[DLL Injection]] [[Malware Analysis]] [[Import Address Table]] [[Code Obfuscation]]