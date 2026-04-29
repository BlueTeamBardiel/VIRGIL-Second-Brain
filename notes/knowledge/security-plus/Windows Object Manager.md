# Windows Object Manager

## What it is
Think of it as the DMV for Windows kernel resources — every named object (files, registry keys, mutexes, processes, pipes) must be registered here and gets a standardized "license plate" before the system will interact with it. The Windows Object Manager is the kernel-level namespace and reference-counting subsystem responsible for creating, naming, tracking, and securing all kernel objects. It enforces access control by attaching a Security Descriptor to each object before any handle is granted.

## Why it matters
Attackers exploit the Object Manager through **symbolic link attacks** — for example, creating a malicious symlink in `\Sessions\0\DosDevices\` to redirect a privileged process from writing to a safe path (e.g., `C:\safe\log.txt`) to an attacker-controlled location, enabling privilege escalation. Defenders use tools like **WinObj** (Sysinternals) to inspect the object namespace for rogue device objects or named pipes that malware plants for inter-process communication and lateral movement.

## Key facts
- Every kernel object has a **Security Descriptor** containing a DACL; the Object Manager checks it on every `OpenHandle` call via the Security Reference Monitor
- The global namespace is visible at `\` in WinObj; user-session namespaces isolate per-user named objects under `\Sessions\<ID>\`
- **Named pipes and mutexes** are classic malware persistence artifacts — many RATs use predictable mutex names to prevent double-infection, which defenders can fingerprint
- **Handle hijacking**: attackers with `SeDebugPrivilege` can duplicate handles from the Object Manager table of a privileged process, inheriting its access rights
- Object Manager symbolic links (`\GLOBAL??\C:`) are frequently abused in **Windows TOCTOU (Time-of-Check/Time-of-Use)** privilege escalation CVEs

## Related concepts
[[Windows Security Reference Monitor]] [[Named Pipes]] [[Access Control Lists]] [[Handle Hijacking]] [[Windows Registry]]