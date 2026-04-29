# ambiguous NFA subexpressions

## What it is
Like a traffic intersection with no stop signs where two cars both think they have the right of way, an ambiguous NFA subexpression is a pattern within a regular expression where multiple valid match paths exist simultaneously. In a Nondeterministic Finite Automaton, certain subexpressions — typically nested quantifiers like `(a+)+` — create exponentially branching state paths when the engine backtracks, because no single "correct" path is obvious. The ambiguity is structural: the NFA genuinely cannot determine the best match without exhaustively exploring all branches.

## Why it matters
This is the precise engine that powers **ReDoS (Regular Expression Denial of Service)** attacks. An attacker submits a crafted input string like `aaaaaaaab` to a web application using a vulnerable regex such as `^(a+)+$`, causing the server's regex engine to explore 2^n backtracking paths and burning CPU for seconds or minutes per request. Cloudflare suffered a global outage in 2019 traced directly to an ambiguous NFA subexpression in a WAF rule consuming 100% CPU.

## Key facts
- Ambiguous subexpressions typically involve **nested or adjacent quantifiers** (`(x+)+`, `(x|xx)+`) on overlapping token sets
- The performance pathology is called **catastrophic backtracking** — time complexity degrades from O(n) to O(2^n) or worse
- **PCRE-based engines** (PHP, Perl, Python `re`) are vulnerable; RE2 and Rust's `regex` crate are immune because they use NFA simulation without backtracking
- A WAF or IDS rule containing an ambiguous pattern can itself become an attack surface — a defensive control turned into a DoS vector
- Detection tools like **`safe-regex`** (Node.js) and **`rxxr2`** statically analyze regexes for ambiguous substructure before deployment

## Related concepts
[[ReDoS attack]] [[catastrophic backtracking]] [[Web Application Firewall bypass]]