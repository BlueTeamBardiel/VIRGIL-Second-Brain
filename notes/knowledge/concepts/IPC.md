# IPC

## What it is
Think of IPC like the pneumatic tube system in a bank drive-through — processes send messages back and forth through defined channels without ever being in the same "room." Inter-Process Communication (IPC) is the set of OS mechanisms that allow separate processes to share data and coordinate actions, including pipes, sockets, shared memory, message queues, and signals.

## Why it matters
Attackers frequently exploit IPC to perform privilege escalation. A classic example: a low-privileged process communicates with a high-privileged service via a named pipe on Windows — if the service doesn't validate the caller's identity, an attacker can impersonate the pipe client or inject malicious data, hijacking the privileged process's actions. This technique was central to many Windows Local Privilege Escalation (LPE) vulnerabilities, including flaws in print spooler services.

## Key facts
- **Types of IPC**: pipes (anonymous and named), Unix domain sockets, message queues, shared memory segments, semaphores, and signals
- **Named pipes on Windows** (e.g., `\\.\pipe\example`) are a common LPE attack vector when services run as SYSTEM and improperly handle client connections
- **Shared memory** is the fastest IPC method but the most dangerous — no built-in access control means any process with the right handle can read or corrupt the data
- **TOCTOU (Time-of-Check to Time-of-Use)** race conditions frequently appear in IPC contexts when processes share resources without proper locking
- On Linux, **D-Bus** is a high-level IPC system commonly attacked to reach privileged system daemons from unprivileged user sessions

## Related concepts
[[Privilege Escalation]] [[Race Conditions]] [[Named Pipes]] [[Shared Memory]] [[TOCTOU]]