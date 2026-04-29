# kernel memory corruption

## What it is
Imagine a surgeon accidentally nicking an artery while operating on a patient's heart — a small mistake in a critical area causes catastrophic, system-wide failure. Kernel memory corruption occurs when an attacker writes invalid or malicious data into the operating system kernel's protected memory space, overwriting control structures, function pointers, or security-critical variables. Because the kernel runs with the highest privilege level (Ring 0), corrupting it can grant an attacker complete, unrestricted control over the entire system.

## Why it matters
The 2016 **Dirty COW** vulnerability (CVE-2016-5195) exploited a race condition in the Linux kernel's copy-on-write mechanism, allowing an unprivileged local user to write to read-only memory mappings and escalate to root. Attackers used it to overwrite `/etc/passwd`, creating root-level accounts with no password. This illustrates how kernel corruption often begins with low-privilege access and ends with full system compromise.

## Key facts
- Kernel memory corruption typically results from **buffer overflows, use-after-free bugs, or race conditions** within kernel code or drivers
- Exploitation often targets **function pointers or kernel data structures** (e.g., `cred` struct in Linux) to redirect execution or escalate privileges
- Mitigations include **SMEP/SMAP** (prevents kernel from executing/accessing user-space memory), **KASLR** (randomizes kernel address layout), and **stack canaries**
- Kernel exploits frequently bypass traditional security controls because antivirus and EDR tools operate at user space — below the attacker's new privilege level
- **CVE severity ratings** for kernel memory corruption vulnerabilities are routinely scored 7.0–10.0 (Critical) due to privilege escalation potential

## Related concepts
[[privilege escalation]] [[buffer overflow]] [[use-after-free]] [[ASLR]] [[rootkit]]