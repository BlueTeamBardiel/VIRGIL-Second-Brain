# Morris Worm

## What it is
Like a curious grad student who picked every lock in a dormitory just to see if he could — and accidentally jammed every door in the building — the Morris Worm was a self-replicating program released in 1988 that exploited multiple Unix vulnerabilities simultaneously. It is widely considered the first worm to gain significant attention on the internet, infecting roughly 6,000 machines (about 10% of the connected internet at the time) and causing widespread slowdowns through uncontrolled replication.

## Why it matters
The Morris Worm directly led to the creation of the first Computer Emergency Response Team (CERT/CC) at Carnegie Mellon University in 1988, establishing the institutional model for incident response that security teams still follow today. It demonstrated that a single piece of malicious code could cascade across interconnected systems, making defense-in-depth and patch management foundational security principles rather than afterthoughts.

## Key facts
- **Author:** Robert Tappan Morris, a Cornell graduate student; he was the first person convicted under the Computer Fraud and Abuse Act (CFAA) of 1986
- **Exploits used:** sendmail DEBUG vulnerability, fingerd buffer overflow, rsh/rexec trusted host exploitation, and weak/default password cracking via `/etc/passwd`
- **Intent vs. impact:** Morris claimed it was not designed to cause damage, but a replication logic flaw caused machines to run dozens of worm copies, grinding them to a halt
- **Legal outcome:** Morris received 3 years probation, 400 hours community service, and a $10,050 fine — no prison time
- **Legacy:** Directly motivated the establishment of CERT/CC and accelerated federal computer crime legislation enforcement

## Related concepts
[[Buffer Overflow]] [[Computer Fraud and Abuse Act]] [[Incident Response]] [[Worm vs Virus]] [[Patch Management]]