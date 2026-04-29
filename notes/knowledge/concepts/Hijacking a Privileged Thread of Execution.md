# Hijacking a Privileged Thread of Execution

## What it is
Imagine a night-shift security guard who leaves their master keycard on the desk — a thief doesn't need to break in, they just borrow the card and return it before morning. Hijacking a privileged thread of execution works the same way: an attacker injects malicious code or redirects an already-running, high-privilege thread (such as a kernel thread or SYSTEM-level process thread) to execute their payload, inheriting all existing permissions without needing to escalate independently. The attacker doesn't create new privilege — they borrow it mid-flight.

## Why it matters
This technique is central to advanced rootkit deployment and EDR evasion. For example, malware like Stuxnet used thread hijacking to inject code into legitimate, trusted processes (e.g., `lsass.exe`), making the malicious execution appear as normal system activity to security tools. Defenders must monitor for anomalous thread creation calls (`CreateRemoteThread`, `NtQueueApcThread`) in high-privilege process memory space.

## Key facts
- **APC Injection** (Asynchronous Procedure Call) is a common mechanism: attackers queue malicious code onto an alertable thread already running with elevated privileges
- `CreateRemoteThread` and `NtQueueApcThread` are Windows API calls frequently abused for thread hijacking and flagged by behavioral detection tools
- Thread hijacking can bypass UAC (User Account Control) because no new privilege elevation request is triggered — the stolen thread already has it
- MITRE ATT&CK maps this under **T1055 – Process Injection**, with thread execution hijacking as sub-technique **T1055.003**
- Detection relies on memory integrity monitoring and flagging when a thread's instruction pointer is redirected to non-module-backed (shellcode) memory regions

## Related concepts
[[Process Injection]] [[Privilege Escalation]] [[APC Queue Abuse]] [[LSASS Memory Access]] [[Defense Evasion]]