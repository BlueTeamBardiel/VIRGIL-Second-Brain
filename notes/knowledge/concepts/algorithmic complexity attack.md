# algorithmic complexity attack

## What it is
Imagine a librarian who normally sorts books in seconds — but you keep handing them books with titles designed to trigger their worst-case sorting algorithm, forcing hours of work for what should take moments. An algorithmic complexity attack (also called a "complexity attack" or "hash flooding") exploits the gap between an algorithm's average-case and worst-case performance by crafting inputs that deliberately trigger maximum computational cost. The attacker forces a server to burn CPU time processing carefully chosen data, causing denial of service without flooding bandwidth.

## Why it matters
In 2011, researchers demonstrated that most major web platforms (PHP, Java, Python, Ruby) used hash table implementations vulnerable to hash collision attacks — an attacker could send a single HTTP POST request with thousands of specially crafted form fields sharing the same hash value, consuming 100% CPU for minutes and effectively taking down a server. This led to emergency patches across languages and the adoption of hash randomization (ASLR-style seeds for hash functions) as a standard defense.

## Key facts
- The attack exploits worst-case O(n²) behavior in data structures that normally perform at O(1) or O(n log n)
- Hash table collision attacks are the most common variant: adversarial keys force all entries into a single bucket, degrading lookup from O(1) to O(n)
- Defense: hash randomization (randomized seeds per-process/session) makes it computationally infeasible to predict collisions
- ReDoS (Regular Expression Denial of Service) is a related variant where crafted strings trigger catastrophic backtracking in regex engines
- These attacks are resource exhaustion attacks — they appear on Security+ under DoS/availability threats and CySA+ under application-layer attack patterns

## Related concepts
[[denial of service]] [[ReDoS]] [[hash collision]] [[input validation]] [[resource exhaustion]]