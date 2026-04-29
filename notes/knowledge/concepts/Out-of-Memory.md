# Out-of-Memory

## What it is
Like a restaurant that keeps seating customers until the kitchen collapses and no one gets served, an Out-of-Memory (OOM) condition occurs when a system has exhausted all available RAM and swap space. The OS can no longer allocate memory to processes, forcing the kernel's OOM killer to terminate processes or causing the system to crash or hang entirely.

## Why it matters
Attackers exploit OOM conditions deliberately through resource exhaustion attacks — for example, sending thousands of malformed TLS handshake requests to a web server, each holding memory open until the server OOM-crashes, achieving a denial-of-service without ever breaking encryption. Defenders watch for OOM events in system logs (`/var/log/syslog` on Linux shows "Out of memory: Kill process") as potential indicators of a DoS attack or runaway malicious process.

## Key facts
- Linux's **OOM Killer** selects a process to terminate based on an "oom_score" — attackers can manipulate this to make critical processes the kill target
- OOM conditions are a primary mechanism behind **memory exhaustion DoS attacks**, a subcategory of resource exhaustion attacks covered under availability threats
- **Fork bombs** (e.g., `:(){ :|:& };:` in bash) cause OOM by spawning processes exponentially until memory is consumed
- Mitigations include **ulimit** (Linux) and **Job Objects** (Windows) to cap per-process/per-user memory allocation
- OOM vulnerabilities can trigger **use-after-free** or **heap corruption** bugs if code doesn't handle failed `malloc()` calls safely — elevating OOM from availability to integrity/confidentiality risk

## Related concepts
[[Denial of Service]] [[Resource Exhaustion]] [[Heap Overflow]] [[Fork Bomb]] [[Memory Management]]