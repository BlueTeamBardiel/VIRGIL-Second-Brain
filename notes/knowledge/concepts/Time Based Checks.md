# Time Based Checks

## What it is
Like a bouncer who checks your ID at the door but doesn't notice you've swapped wristbands with someone inside — time-based checks validate a condition at one moment but act on it later, creating a window for manipulation. Formally, this is a **Time-of-Check to Time-of-Use (TOCTOU)** vulnerability, a race condition where the state of a resource changes between when it is verified and when it is used. The gap between check and use is the attack surface.

## Why it matters
A classic example: a Unix system checks whether a user has permission to write to a file, then opens it milliseconds later. An attacker with the right timing can replace that file with a symlink pointing to `/etc/passwd` in that tiny window, causing the privileged process to write attacker-controlled data to a sensitive system file. This type of race condition has appeared in real exploits against `sudo`, `sendmail`, and various Linux kernel operations.

## Key facts
- TOCTOU is a subclass of **race condition vulnerabilities**, categorized under CWE-367
- The attack requires the adversary to **win the race** — repeatedly triggering the condition increases success probability (often automated)
- Mitigations include **atomic operations** (check-and-act as a single indivisible step) and file locking mechanisms
- On Security+/CySA+: TOCTOU is an example of a **privilege escalation** technique often seen in local exploitation scenarios
- Secure coding practice: use file descriptors (already-open handles) rather than re-resolving file paths, preventing symlink substitution attacks

## Related concepts
[[Race Conditions]] [[Privilege Escalation]] [[Insecure File Permissions]] [[Atomic Operations]] [[CWE Vulnerability Classification]]