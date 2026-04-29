# DLL

## What it is
Think of a DLL like a shared toolbox in a workshop — instead of every carpenter bringing their own hammer, everyone borrows from the same box stored in a common room. A Dynamic Link Library (DLL) is a compiled code module containing functions and data that multiple Windows programs can load and use simultaneously at runtime, rather than each program bundling its own copy of that code.

## Why it matters
Attackers exploit DLL loading behavior through **DLL hijacking**: when a vulnerable application searches for a DLL in predictable, user-writable directories before checking System32, an attacker plants a malicious DLL with the same filename. The legitimate application loads the attacker's code with its own privileges — a technique used in real-world campaigns like the SolarWinds supply chain attack and common privilege escalation on Windows endpoints.

## Key facts
- **DLL Search Order** (Windows default): application directory → System32 → System → Windows → current directory → PATH directories; attackers exploit this sequence
- **DLL Injection** places malicious code into a running process's memory space using APIs like `CreateRemoteThread` + `LoadLibrary`, a common malware persistence technique
- **DLL Sideloading** abuses legitimate signed executables that load DLLs by relative path — the signed binary acts as a "carrier," bypassing application whitelisting
- **SafeDllSearchMode** (enabled by default since Windows XP SP2) moves the current working directory lower in the search order, partially mitigating hijacking
- Monitoring for unsigned DLLs loaded by trusted processes is a core **CySA+** detection strategy using tools like Process Monitor or EDR telemetry

## Related concepts
[[Process Injection]] [[Privilege Escalation]] [[Living Off the Land]] [[Supply Chain Attack]] [[Application Whitelisting]]