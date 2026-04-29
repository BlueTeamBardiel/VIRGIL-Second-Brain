# Windows API Abuse

## What it is
Think of the Windows API as a master keyring hanging in every process's reach — legitimate programs borrow keys to open doors like memory, network sockets, and file handles. Windows API abuse occurs when attackers call these same legitimate system functions (VirtualAlloc, WriteProcessMemory, CreateRemoteThread, etc.) to execute malicious code, bypassing security tools that focus on files rather than behavior.

## Why it matters
The "Process Injection" technique used in the Cobalt Strike framework relies almost entirely on Windows API abuse: an attacker calls VirtualAllocEx to carve memory in a legitimate process like explorer.exe, writes shellcode with WriteProcessMemory, then triggers execution via CreateRemoteThread — all using documented, "authorized" API calls. EDR solutions must therefore monitor API call sequences and behavioral patterns rather than just scanning for malicious files.

## Key facts
- **VirtualAlloc/VirtualAllocEx** — allocates executable memory; the combination of MEM_COMMIT + PAGE_EXECUTE_READWRITE is a classic malicious signature
- **CreateRemoteThread** — spawns a thread inside another process; primary mechanism for classic DLL injection and shellcode execution
- **NtWriteVirtualMemory** — the lower-level (NT/Native API) syscall equivalent; attackers "go direct" to syscalls to evade API hooks placed by EDR tools in ntdll.dll
- **MITRE ATT&CK T1055** covers Process Injection as a whole; sub-techniques map specific API chains (T1055.001 = DLL Injection, T1055.002 = PE Injection)
- **API hooking detection evasion**: malware may use direct syscalls or "Heaven's Gate" (switching from 32-bit to 64-bit mode) to bypass userland hooks monitoring standard API calls

## Related concepts
[[Process Injection]] [[DLL Injection]] [[Defense Evasion]] [[LOLBAS]] [[EDR Bypass]]