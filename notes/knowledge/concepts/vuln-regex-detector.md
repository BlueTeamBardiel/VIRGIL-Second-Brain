# vuln-regex-detector

## What it is
Like a carbon monoxide detector that sniffs for invisible danger in your home, `vuln-regex-detector` is a static analysis tool that sniffs your codebase for Regular Expression Denial of Service (ReDoS) vulnerabilities. It scans regex patterns and flags those with exponential or polynomial backtracking behavior that an attacker can exploit to freeze an application.

## Why it matters
In 2016, a single malicious input string caused a 30-minute outage at Stack Overflow by triggering catastrophic backtracking in a regex used to validate post content. Security engineers use `vuln-regex-detector` in CI/CD pipelines to catch these "evil regexes" before they reach production — turning a reactive incident into a preventable build failure.

## Key facts
- **ReDoS attack vector**: Crafted input exploits ambiguous quantifiers (e.g., `(a+)+`, `(a|aa)+`) to force the regex engine into exponential backtrack states, consuming 100% CPU.
- **Tool mechanics**: `vuln-regex-detector` integrates multiple analysis backends (e.g., *vuln-regex*, *rxxr2*, *MUTR*) and reports a consensus verdict on whether a pattern is "safe," "vulnerable," or "unknown."
- **Language agnostic**: Supports detection across JavaScript, Python, Java, and other language ecosystems since the backtracking problem is inherent to NFA-based regex engines, not any one language.
- **OWASP relevance**: ReDoS falls under OWASP's *Denial of Service* category and is classified as CWE-1333 (Inefficient Regular Expression Complexity).
- **Mitigation strategies beyond detection**: Use linear-time regex engines (e.g., RE2, Rust's `regex` crate), enforce input length limits, and apply timeouts on regex evaluation.

## Related concepts
[[ReDoS]] [[Static Application Security Testing]] [[Denial of Service]] [[Input Validation]] [[CWE-1333]]