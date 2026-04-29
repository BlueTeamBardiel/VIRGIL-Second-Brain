# UNIX

## What it is
Like a Swiss Army knife that became the blueprint for every multi-tool that followed, UNIX is the foundational operating system architecture developed at Bell Labs in 1969 that established the design philosophy underpinning Linux, macOS, and most server infrastructure today. It introduced the concept of everything-as-a-file, hierarchical directory structures, and small composable programs connected via pipes.

## Why it matters
A penetration tester exploiting a misconfigured SUID (Set User ID) binary on a Linux web server is directly exploiting a UNIX permission concept from the 1970s — the file executes with the owner's privileges rather than the caller's, allowing privilege escalation from a low-privilege web process to root. This single design decision has produced decades of real-world compromises because administrators routinely set SUID without understanding the attack surface it creates.

## Key facts
- UNIX introduced the **three-permission model** (read/write/execute) for three principals (owner/group/other), represented as octal notation (e.g., `chmod 755`)
- **SUID and SGID bits** are a common privilege escalation vector; tools like `find / -perm -4000` enumerate them during post-exploitation
- The `/etc/passwd` and `/etc/shadow` files are UNIX artifacts — shadow was introduced specifically to move password hashes away from world-readable files
- UNIX's **fork/exec model** means every process has a parent; process trees are critical for detecting anomalous behavior in endpoint detection
- **File descriptors 0, 1, 2** (stdin, stdout, stderr) are a UNIX concept exploited in shellcode and command injection attacks through output redirection

## Related concepts
[[Linux Privilege Escalation]] [[File Permissions]] [[Process Injection]] [[Shadow Password File]] [[SUID Exploitation]]