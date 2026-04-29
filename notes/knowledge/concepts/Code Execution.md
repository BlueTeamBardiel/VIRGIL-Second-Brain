# Code Execution

## What it is
Like a theater stage where only the script should run, but someone sneaks in their own lines and the actors perform them anyway — code execution is when an attacker causes a target system to run instructions they supplied, outside of what the software was designed to do. Precisely: it is the ability to execute arbitrary commands or machine instructions on a system, typically by exploiting a vulnerability that blurs the line between data and instructions.

## Why it matters
In 2017, the WannaCry ransomware leveraged EternalBlue, an NSA-developed exploit targeting a buffer overflow in Windows SMB (MS17-010), to achieve remote code execution across unpatched systems globally — encrypting files on over 200,000 machines in 150 countries. Defenders respond by enforcing Data Execution Prevention (DEP) and Address Space Layout Randomization (ASLR) to make it harder for attacker-supplied data to be treated as runnable code.

## Key facts
- **Remote Code Execution (RCE)** means the attacker executes code without needing local access — often the highest-severity vulnerability class (CVSS scores frequently 9.0+)
- **Local Code Execution** requires the attacker to already have some system access and escalates impact, often chained with privilege escalation
- Common root causes include buffer overflows, injection flaws (SQLi, command injection), deserialization vulnerabilities, and memory corruption bugs
- **DEP/NX bit** marks memory regions as non-executable, blocking shellcode placed in the stack or heap from running
- **Sandboxing** (used in browsers, PDF readers, email clients) limits what code can *do* even if execution is achieved, containing blast radius

## Related concepts
[[Buffer Overflow]] [[Remote Code Execution]] [[Privilege Escalation]] [[Shellcode]] [[Exploit Mitigation]]