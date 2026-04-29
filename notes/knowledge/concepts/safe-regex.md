# safe-regex

## What it is
Like a bouncer who checks IDs in O(n) time rather than calling Interpol for background checks on every patron, safe-regex refers to regular expressions engineered to evaluate in linear time rather than exponential time. Specifically, it is the practice of crafting or validating regex patterns to avoid backtracking catastrophes that enable ReDoS (Regular Expression Denial of Service) attacks.

## Why it matters
In 2016, a single malicious input string caused Cloudflare's WAF regex engine to catastrophically backtrack, taking down their entire platform for ~2.5 hours. Attackers can craft inputs that force a vulnerable regex to perform billions of operations instead of thousands, consuming 100% CPU and denying service without sending a single extra packet.

## Key facts
- **Evil regex patterns** typically contain nested quantifiers like `(a+)+` or alternation with overlap like `(a|a)+` — these are the red flags to memorize
- The `safe-regex` npm package analyzes patterns and returns `false` for any regex exhibiting polynomial or exponential worst-case complexity
- ReDoS is classified under **CWE-1333** (Inefficient Regular Expression Complexity) and is distinct from classic DoS because it exploits CPU, not bandwidth
- Safe regex patterns must be **deterministic finite automaton (DFA)-compatible** — DFAs cannot backtrack by design, guaranteeing O(n) evaluation
- OWASP recommends input length limits as a **defense-in-depth** measure alongside safe regex, since even a mildly inefficient pattern becomes dangerous on gigantic inputs

## Related concepts
[[ReDoS]] [[Input Validation]] [[Denial of Service]] [[OWASP Top 10]] [[Backtracking]]