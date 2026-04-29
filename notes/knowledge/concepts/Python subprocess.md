# Python subprocess

## What it is
Like a manager who delegates tasks by handing a sticky note to a worker and waiting for results, `subprocess` lets a Python script spawn, communicate with, and control external OS-level processes. It is Python's standard library module for executing shell commands, binaries, and scripts from within Python code, replacing the older `os.system()` calls with far more control over stdin/stdout/stderr.

## Why it matters
Attackers frequently abuse `subprocess` in malware and web exploitation payloads — for example, a compromised Django app might use `subprocess.Popen(user_input, shell=True)` to achieve remote code execution if user-supplied data reaches it unsanitized. Defenders writing automation tools also use it legitimately to invoke `nmap`, `netstat`, or forensic utilities programmatically during incident response scripts.

## Key facts
- **`shell=True` is the cardinal sin**: passing `shell=True` with unsanitized input enables OS command injection, equivalent to handing an attacker a terminal
- `subprocess.run()` (Python 3.5+) is the modern, blocking call; `subprocess.Popen()` is the lower-level, non-blocking alternative for more complex I/O control
- Output is captured via `capture_output=True` or `stdout=subprocess.PIPE` — without this, output goes directly to the console, not your variable
- **Prefer list arguments over strings**: `subprocess.run(["ls", "-la"])` avoids shell interpretation entirely and is the secure default
- Malware analysts encounter `subprocess` calls obfuscated via `base64` decoding into `exec()` or chained with `os.system()` as a persistence or privilege escalation mechanism

## Related concepts
[[Command Injection]] [[Remote Code Execution]] [[OS Command Injection]] [[Python for Security Automation]]