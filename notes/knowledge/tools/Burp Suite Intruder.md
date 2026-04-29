# Burp Suite Intruder

## What it is
Like a locksmith's bump key that systematically tries every pin combination on a lock, Burp Suite Intruder is an automated HTTP request fuzzer that injects payloads into marked positions within intercepted web requests. It cycles through wordlists or payload sets to probe for vulnerabilities such as weak credentials, injection points, and enumerable resources.

## Why it matters
During a web application penetration test, a tester intercepts a login POST request and uses Intruder's **Cluster Bomb** attack to simultaneously iterate through a username list and a password list — automating credential stuffing across thousands of combinations in minutes. This same technique is used by real attackers against exposed admin panels, making rate limiting and account lockout controls critical defensive countermeasures.

## Key facts
- **Four attack types:** Sniper (one payload set, one position at a time), Battering Ram (same payload in all positions), Pitchfork (parallel iteration across multiple payload sets), and Cluster Bomb (all combinations across multiple sets).
- The **Community Edition throttles requests** to ~1/second, making it impractical for large-scale attacks in free use; Professional Edition removes this restriction.
- Intruder is commonly used for **IDOR testing** by iterating numeric IDs (e.g., `/user?id=§1§`) to detect broken object-level authorization.
- Payloads can include **built-in lists, custom wordlists, character fuzzing sets, or recursive grep-extracted values** from prior responses.
- Results are analyzed via **response length, status codes, and grep-match rules** — a login bypass often shows a different Content-Length than failed attempts.

## Related concepts
[[Credential Stuffing]] [[IDOR (Insecure Direct Object Reference)]] [[Burp Suite Repeater]] [[Fuzzing]] [[OWASP Testing Guide]]