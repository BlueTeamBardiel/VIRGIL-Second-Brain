# Complexity Attack

## What it is
Like a waiter who grinds to a halt when handed a menu order that requires checking every possible combination of substitutions, a complexity attack exploits the worst-case performance of an algorithm to exhaust system resources. Precisely: an attacker crafts malicious input that forces a target system's algorithm into its most computationally expensive execution path, consuming CPU, memory, or time far beyond normal operation — effectively a denial of service through algorithmic weaponization.

## Why it matters
The HashDoS attack (2011) demonstrated this perfectly: attackers discovered that most web frameworks used hash tables vulnerable to crafted HTTP POST parameters that all mapped to the same hash bucket, degrading O(1) lookups to O(n²) operations. Sending a single request with ~65,000 crafted parameters could pin a server's CPU at 100% for 30+ seconds, enabling a single attacker to take down servers without a botnet.

## Key facts
- **ReDoS (Regular Expression DoS)** is the most common variant — a maliciously crafted string causes a backtracking regex engine to evaluate exponentially many paths
- Complexity attacks are a subset of **resource exhaustion DoS**, but require zero bandwidth — a single packet or request can be sufficient
- Mitigations include **input length limits**, algorithmic substitution (e.g., replacing vulnerable hash functions with SipHash), and regex timeout enforcement
- Hash table collision attacks were mitigated in languages like Python and Ruby by introducing **hash randomization** (random seeds per process)
- Complexity attacks exploit **algorithmic assumptions**, not memory corruption — they require no CVE, shellcode, or privilege escalation

## Related concepts
[[Denial of Service]] [[ReDoS]] [[Resource Exhaustion]] [[Hash Collision]] [[Input Validation]]