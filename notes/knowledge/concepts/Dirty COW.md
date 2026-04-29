# Dirty COW

## What it is
Imagine a library with a strict "read-only" policy on rare books — but if you ask a clerk to photocopy a page *exactly* as another patron requests the original, the timing confusion lets you slip a forged page into the master copy. Dirty COW (CVE-2016-5195) is a race condition vulnerability in the Linux kernel's Copy-On-Write memory mechanism that allowed unprivileged users to write to read-only memory mappings they should never be able to modify. Exploiting the race between two competing threads caused the kernel to skip its write-protection check before committing changes to the underlying file.

## Why it matters
In 2016, attackers exploited Dirty COW on Android devices to achieve local privilege escalation — turning a low-privilege app into root, bypassing SELinux entirely. This made it a favorite for rooting tools and malware that needed persistent, elevated access without user interaction, since the exploit required no special permissions to trigger.

## Key facts
- **CVE-2016-5195** — existed undetected in the Linux kernel for approximately **9 years** (since kernel 2.6.22, released 2007)
- Classified as a **local privilege escalation (LPE)** vulnerability; remote exploitation requires chaining with another vulnerability
- Exploits a **TOCTOU (Time-of-Check to Time-of-Use)** race condition in the `mmap` subsystem
- Patched in Linux kernel versions **4.8.3, 4.7.9, and 4.4.26** (October 2016)
- Affected **Linux, Android, and any OS running a vulnerable Linux kernel** — scope was enormous given Linux's server dominance
- Proof-of-concept exploits were publicly available within days of disclosure, dramatically shortening the patch window

## Related concepts
[[Race Condition]] [[Privilege Escalation]] [[TOCTOU]] [[Memory Corruption]] [[CVE]]