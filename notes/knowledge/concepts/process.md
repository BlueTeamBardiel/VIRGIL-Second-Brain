# process

## What it is
Like a recipe being actively cooked on a stove — the recipe is the program (static), but the process is the live, running instance consuming resources and producing results. Precisely: a process is a program in execution, allocated its own virtual memory space, CPU time, file handles, and security context by the operating system.

## Why it matters
Malware like Emotet injects malicious code directly into legitimate processes (e.g., `svchost.exe`) to masquerade as trusted system activity — a technique called process injection. Security analysts using tools like Process Hacker or Sysmon watch for anomalies: a `svchost.exe` spawned from an unusual parent, or carrying a network connection it shouldn't have.

## Key facts
- Every process runs under a security context (user account/token), which determines its privileges — attackers escalate privileges by hijacking high-integrity processes
- Processes are isolated from each other via virtual memory; breaking that isolation (e.g., via `ptrace` or `WriteProcessMemory`) is a hallmark of advanced attacks
- The Process ID (PID) uniquely identifies a running process; parent-child PID relationships reveal suspicious chains (e.g., `Word.exe` spawning `PowerShell.exe`)
- On Windows, processes have integrity levels (Low, Medium, High, System) enforced by Mandatory Integrity Control — relevant to UAC bypass techniques
- Zombie/orphan processes can indicate malware attempting persistence or a killed C2 beacon leaving traces behind

## Related concepts
[[privilege escalation]] [[process injection]] [[memory forensics]]