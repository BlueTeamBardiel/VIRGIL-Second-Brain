# assert

## What it is
Like a bouncer checking IDs at the door — if the condition isn't true, execution stops cold. In programming and security contexts, `assert` is a defensive statement that tests a condition and throws an error (or halts execution) if that condition evaluates to false, preventing logic from continuing under invalid assumptions.

## Why it matters
Python's `assert` statements are **silently disabled** when code runs with the `-O` (optimize) flag, meaning security checks implemented with `assert` instead of proper `if/raise` logic simply vanish in production. Attackers who know a web app strips assertions can bypass input validation, authentication checks, or access controls that developers assumed were always enforced.

## Key facts
- `assert condition` is equivalent to `if not condition: raise AssertionError` — but only when optimizations are disabled
- In Python, running `python -O script.py` removes all assert statements entirely from bytecode, making them **zero-cost and zero-protection** in optimized deployments
- Security-critical checks (authentication, authorization, input validation) must **never** rely on `assert`; use explicit exceptions instead
- In formal verification and secure coding standards (e.g., SEI CERT), assert is recommended only for detecting programmer errors (invariants), not for enforcing security boundaries
- Misuse of assert as a security gate is a **CWE-617** (Reachable Assertion) class vulnerability, where attackers can craft inputs that trigger assertion failures to cause denial of service

## Related concepts
[[Input Validation]] [[Defense in Depth]] [[Secure Coding Practices]]