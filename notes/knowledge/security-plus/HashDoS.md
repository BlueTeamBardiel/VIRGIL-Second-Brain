# HashDoS

## What it is
Imagine a library where every book is filed by the first letter of its title — but a malicious donor sends 10,000 books all starting with "A," grinding the filing system to a halt. HashDoS (Hash Collision Denial of Service) works exactly like this: an attacker crafts HTTP POST parameters with keys that all hash to the same bucket in a hash table, causing O(1) lookups to degrade into O(n²) complexity and consuming server CPU until the service collapses.

## Why it matters
In 2011, researchers Juliano Rizzo and Thai Duong demonstrated HashDoS against virtually every major web platform simultaneously — PHP, Java, Python, Ruby, ASP.NET — using a single laptop sending ~1MB of crafted POST data to hold a server core at 100% CPU indefinitely. This forced emergency patches across the industry and led to the widespread adoption of hash randomization (seed salting) as a language-level default.

## Key facts
- Exploits deterministic hash functions in hash table implementations used to parse HTTP request parameters
- Attack cost is asymmetric: ~1MB of POST data can consume 100% of a single CPU core for 30+ seconds
- Mitigation: hash seed randomization (ASLR for hash functions) breaks the attacker's ability to precompute collisions
- Secondary mitigations include limiting the number of POST parameters per request (e.g., PHP's `max_input_vars`)
- Classified as a **resource exhaustion** attack — a subset of Denial of Service targeting computational complexity rather than bandwidth

## Related concepts
[[Denial of Service]] [[Algorithmic Complexity Attacks]] [[HTTP Parameter Pollution]] [[Input Validation]] [[Hash Functions]]