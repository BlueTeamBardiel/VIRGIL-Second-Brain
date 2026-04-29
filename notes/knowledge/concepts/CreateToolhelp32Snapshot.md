# CreateToolhelp32Snapshot

## What it is
Like a photographer snapping a single frame of a busy street to capture every pedestrian in one frozen moment — `CreateToolhelp32Snapshot` is a Windows API function that takes an instantaneous snapshot of the running system, capturing processes, threads, heaps, and loaded modules at that exact point in time. It returns a handle that other functions (like `Process32First`/`Process32Next`) use to walk through the captured list.

## Why it matters
Malware routinely calls `CreateToolhelp32Snapshot` during its reconnaissance phase to enumerate running processes and detect security tools like antivirus, EDR agents, or sandboxes before executing its payload. For defenders, seeing this API call in a behavioral analysis report — especially followed by string comparisons against known security product names — is a strong indicator of sandbox evasion or defense-disabling behavior.

## Key facts
- **Snapshot types** are controlled by the `dwFlags` parameter: `TH32CS_SNAPPROCESS` captures processes, `TH32CS_SNAPTHREAD` captures threads, `TH32CS_SNAPMODULE` captures loaded DLLs.
- It is a **legitimate Windows API** (lives in `kernel32.dll`), so its mere presence isn't malicious — context and what follows it determines intent.
- Commonly chained with **`OpenProcess` + `TerminateProcess`** to kill security software after identifying it through enumeration.
- **Process injection** workflows use it to find a target process PID before injecting shellcode via `VirtualAllocEx`/`WriteProcessMemory`.
- EDRs and SIEMs flag **repeated rapid calls** to this function as anomalous, since legitimate apps rarely need to re-enumerate processes in tight loops.

## Related concepts
[[Process Injection]] [[API Hooking]] [[Defense Evasion]] [[Living off the Land]]