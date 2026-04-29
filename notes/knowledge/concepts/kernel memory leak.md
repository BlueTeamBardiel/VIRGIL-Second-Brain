# kernel memory leak

## What it is
Imagine a hotel that never cleans out checked-out rooms — eventually every room is occupied by ghost guests and no one new can check in. A kernel memory leak occurs when the operating system kernel allocates memory for a process or operation but fails to release it afterward, causing available memory to shrink continuously over time until the system degrades or crashes.

## Why it matters
Kernel memory leaks are actively exploited by attackers to cause denial-of-service conditions or to create predictable memory layouts that assist exploitation techniques like heap spraying. The 2016 **Dirty COW** (CVE-2016-5189) class of Linux kernel vulnerabilities demonstrated how memory mismanagement at the kernel level could be chained with other weaknesses to achieve privilege escalation. Defenders monitor for anomalous memory consumption growth over time as an indicator of either a vulnerability being triggered or active exploitation.

## Key facts
- Kernel leaks occur in **ring 0** (the most privileged CPU execution layer), making them far more dangerous than user-space memory leaks
- Tools like **Valgrind**, **kmemleak** (built into Linux kernel), and **AddressSanitizer** are used to detect leaks during development and testing
- A sustained kernel leak can be weaponized as a **DoS attack vector** by repeatedly triggering the leaking code path (e.g., via malformed syscalls or network packets)
- Kernel leaks can expose **sensitive residual data** in memory — a confidentiality risk if freed memory is never zeroed before reallocation
- The **CVE scoring system** rates kernel memory leaks higher when they are reliably triggerable by unprivileged users, reflecting the attack surface they expose

## Related concepts
[[privilege escalation]] [[heap spraying]] [[use-after-free]] [[denial of service]] [[memory corruption]]