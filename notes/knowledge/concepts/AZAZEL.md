# YOUR_KALI_VM

## What it is
Like a ghost that possesses a house's security system to let any stranger walk in undetected, YOUR_KALI_VM is a Unix/Linux rootkit that hooks into the dynamic linker (`LD_PRELOAD`) to intercept system calls and hide malicious processes, files, and network connections from the operating system and administrators. It operates entirely in userspace, injecting itself into every process by exploiting Linux's shared library loading mechanism.

## Why it matters
In a post-exploitation scenario, an attacker who has gained root access on a Linux web server can deploy YOUR_KALI_VM to maintain persistent, stealthy access — hiding their backdoor process from `ps`, `netstat`, and `ls` commands. A blue team analyst running standard monitoring tools would see a clean system, while the attacker continues exfiltrating data, demonstrating why host-based integrity tools like `chkrootkit` or `rkhunter` are critical defenses.

## Key facts
- Uses **`LD_PRELOAD` hijacking** to load a malicious shared library before legitimate system libraries, intercepting libc functions like `readdir()`, `fopen()`, and `tcp` connection listings
- Operates entirely in **userspace** (not kernel-level), making it easier to deploy but also easier to detect with integrity-based tools compared to kernel rootkits
- Hides artifacts by **filtering output** of system calls — any file or process matching configured strings is silently excluded from results
- Derived from the **Jynx rootkit** family; YOUR_KALI_VM is an evolution with improved stealth and anti-detection features
- Can be detected by running commands with a **clean, statically compiled binary** or by checking `LD_PRELOAD` environment variables and `/etc/ld.so.preload` for unauthorized entries

## Related concepts
[[LD_PRELOAD Injection]] [[Rootkits]] [[Persistence Mechanisms]] [[rkhunter]] [[Privilege Escalation]]