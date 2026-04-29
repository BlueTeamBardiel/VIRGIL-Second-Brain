# Windows API

## What it is
Think of the Windows API as a hotel concierge desk — applications slide requests across the counter ("open this file," "create this process," "send this network packet") and Windows handles the actual work behind the scenes. Precisely, the Windows Application Programming Interface (API) is a standardized set of functions exposed by the Windows OS that allows programs to interact with hardware, memory, files, and system services without direct kernel access.

## Why it matters
Malware authors abuse Windows API calls constantly — ransomware typically chains `CreateFile()`, `ReadFile()`, `CryptEncryptMessage()`, and `WriteFile()` to encrypt victim data entirely through legitimate OS functions, making behavioral detection harder. Defenders use API call monitoring (via tools like Sysmon or EDR platforms) to flag suspicious sequences, since malicious intent often reveals itself through *which* APIs are called and *in what order*, not just what binary is running.

## Key facts
- **`VirtualAllocEx()` + `WriteProcessMemory()` + `CreateRemoteThread()`** is the classic three-API combo for process injection attacks — a red flag in any behavioral analysis
- Windows APIs are primarily accessed through **DLLs** like `kernel32.dll`, `ntdll.dll`, and `advapi32.dll`
- **`ntdll.dll`** sits closest to the kernel; malware uses direct syscalls through it to bypass security hooks placed by AV/EDR in higher-level DLLs
- **API hooking** is both an attacker technique (intercept credentials) and a defender technique (intercept malicious calls) — same mechanism, opposite goals
- The Windows API is distinct from the **Native API** (undocumented syscalls) — security tools must monitor both layers to catch evasion

## Related concepts
[[Process Injection]] [[DLL Hijacking]] [[EDR Evasion]] [[Sysmon]] [[Malware Analysis]]