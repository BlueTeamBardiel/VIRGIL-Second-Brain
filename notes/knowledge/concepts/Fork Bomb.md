# Fork Bomb

## What it is
Imagine a photocopier that, instead of copying documents, copies *itself* — and each copy immediately makes two more copies, filling the room with copiers until nothing else can move. A fork bomb is a denial-of-service attack where a malicious process recursively spawns child processes until system resources (memory, process table slots, CPU) are exhausted, rendering the system unresponsive. The classic Unix one-liner `:(){ :|:& };:` accomplishes this in a single shell command.

## Why it matters
An attacker who gains limited shell access to a Linux server — perhaps through a weak SSH credential — can deploy a fork bomb to crash the system or disrupt services without needing root privileges. This makes it a common sabotage technique during insider threat scenarios or as a distraction tactic while other malicious activity occurs elsewhere on the network.

## Key facts
- The classic Bash fork bomb `:(){ :|:& };:` defines a function named `:` that calls itself twice in the background, creating exponential process growth
- Fork bombs are a **local denial-of-service** attack — they require existing access to a shell, not remote exploitation
- Linux mitigation: `ulimit -u <max_processes>` in `/etc/security/limits.conf` caps per-user process counts, breaking the exponential chain
- Fork bombs exhaust the **process table** (finite OS data structure), not just RAM or CPU — this is what makes recovery require a reboot
- Classified under **CWE-400 (Uncontrolled Resource Consumption)** — relevant for exam understanding of resource exhaustion vulnerabilities

## Related concepts
[[Denial of Service]] [[Resource Exhaustion]] [[Privilege Escalation]] [[Linux Hardening]]