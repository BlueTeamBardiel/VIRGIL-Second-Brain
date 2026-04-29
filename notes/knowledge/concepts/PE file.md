# PE file

## What it is
Think of a PE file like a suitcase with a detailed packing manifest on top — the manifest tells Windows exactly what clothes (code), toiletries (data), and customs forms (metadata) are packed inside, and precisely where to find each item. A Portable Executable (PE) file is the standard binary format used by Windows for executables (.exe), dynamic-link libraries (.dll), and drivers (.sys), containing structured headers that the Windows loader reads to map the program into memory and execute it.

## Why it matters
Malware analysts routinely inspect PE headers to detect packed or obfuscated payloads — for example, a PE file where the reported section sizes vastly differ from the raw disk sizes is a classic sign of runtime unpacking used by ransomware families like Emotet. Defenders use tools like `peview`, `pestudio`, and `Detect-It-Easy` to triage suspicious files by examining imports, entropy, and timestamps before executing them in a sandbox.

## Key facts
- The PE header begins with the DOS stub (`MZ` magic bytes — `0x4D5A`), which is why all Windows executables start with "MZ"
- The **Import Address Table (IAT)** lists every DLL function the executable calls at runtime — a critical artifact for understanding malware capabilities (e.g., `CreateRemoteThread` signals injection)
- **Section entropy** above ~7.0 often indicates encryption or packing, a common malware evasion technique
- PE files contain a **TimeDateStamp** field that attackers frequently forge to mislead forensic timelines
- The **Optional Header** (despite the name, always present) specifies the `ImageBase` — the preferred memory load address — and the entry point (`AddressOfEntryPoint`)

## Related concepts
[[DLL Injection]] [[Process Hollowing]] [[Malware Analysis]] [[Import Address Table]] [[ASLR]]