# locks

## What it is
Like a bouncer checking IDs at a club door — a lock is a physical or logical mechanism that restricts access to a resource until the correct credential is presented. Precisely, locks are access control mechanisms that enforce authorization by requiring authentication (a key, PIN, credential) before granting entry to a physical space or logical resource.

## Why it matters
In 2016, the Mirai botnet compromised hundreds of thousands of IoT devices because manufacturers shipped them with default credentials — the equivalent of every lock in a building using the same master key that's printed on the box. Had proper credential management and lock-out policies been enforced, lateral movement would have been dramatically limited. Physical locks matter too: tailgating attacks bypass even the strongest network security when someone simply holds a door open.

## Key facts
- **Lockpicking analogy in digital systems**: Brute-force attacks mimic picking a lock pin by pin — account lockout policies (e.g., 3-5 attempts) are the equivalent of a lock that jams after failed picks
- **Mantrap/airlock**: A physical double-door system using electronic locks that prevents tailgating; only one door opens at a time
- **Mutex locks** in software prevent race conditions by ensuring only one process accesses a shared resource simultaneously — a critical concept in secure coding
- **High-security locks** (Grade 1 deadbolts, cipher locks, biometric locks) map to multi-factor authentication in the physical world
- **Key management** is the hardest part — NIST SP 800-57 governs cryptographic key lifecycle just as a locksmith governs physical key duplication rights

## Related concepts
[[access control]] [[physical security]] [[multi-factor authentication]] [[tailgating]] [[least privilege]]