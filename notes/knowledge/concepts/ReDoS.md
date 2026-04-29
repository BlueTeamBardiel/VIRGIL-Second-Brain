# ReDoS

## What it is
Imagine a librarian asked to find "any book whose title almost-but-not-quite matches a pattern" — she checks every possible combination of shelves, backtracks, and checks again, grinding to a halt. ReDoS (Regular Expression Denial of Service) works the same way: an attacker supplies crafted input that forces a regex engine into catastrophic backtracking, consuming CPU time exponentially and denying service to legitimate users.

## Why it matters
In 2016, a single malicious string caused a 30-minute outage on Stack Overflow by triggering catastrophic backtracking in their post-editor's regex validator. The attack required no authentication — just a carefully crafted HTTP request — demonstrating how a logic flaw in input validation can collapse a production service without any memory corruption or privilege escalation.

## Key facts
- **Root cause is "catastrophic backtracking"**: certain regex patterns (especially nested quantifiers like `(a+)+`) cause the engine to explore exponentially many match paths on near-miss input.
- **Complexity jumps from O(n) to O(2ⁿ)**: a string of length 30 can require billions of steps with a vulnerable pattern, making this a resource exhaustion attack.
- **Common in web applications**: input validation, URL routers, and log parsers frequently use regexes, widening the attack surface.
- **Mitigation includes using possessive quantifiers or atomic groups**, switching to linear-time regex engines (like RE2), and enforcing input length limits before regex evaluation.
- **OWASP classifies ReDoS under Denial of Service** and it maps to CWE-1333 (Inefficient Regular Expression Complexity); it appears in secure coding guidelines for both developers and reviewers.

## Related concepts
[[Denial of Service]] [[Input Validation]] [[Catastrophic Backtracking]] [[Resource Exhaustion]] [[OWASP Top 10]]