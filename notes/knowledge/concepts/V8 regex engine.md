# V8 regex engine

## What it is
Like a postal sorting machine that can jam indefinitely when handed a cleverly folded envelope, V8's regex engine is a pattern-matching system that can get trapped in exponential backtracking. V8 is the JavaScript engine powering Chrome and Node.js, and its regex subsystem uses a backtracking NFA (Nondeterministic Finite Automaton) to evaluate regular expressions against input strings.

## Why it matters
ReDoS (Regular Expression Denial of Service) attacks exploit V8's backtracking behavior by supplying crafted input that forces the engine into catastrophic backtracking — turning a single regex match into millions of computation steps. In 2021, Cloudflare's WAF and several npm packages suffered outages when malicious or accidental ReDoS patterns caused Node.js servers to hang at 100% CPU, effectively DoS-ing the service without a single network flood packet.

## Key facts
- V8 uses a backtracking NFA by default, meaning ambiguous patterns like `(a+)+` evaluated against `"aaaaab"` can trigger O(2ⁿ) time complexity
- Vulnerable regex patterns typically involve nested quantifiers (`(x+)+`), alternation with overlap (`(a|a)+`), or repeated optional groups
- Node.js applications are especially exposed because JavaScript is single-threaded — one blocked event loop blocks all requests
- V8 introduced **Irregexp**, its dedicated regex compiler, which uses JIT compilation to speed up matching but does not eliminate catastrophic backtracking for all patterns
- Defense includes using regex analyzers (e.g., `safe-regex`, `vuln-regex-detector`) and preferring linear-time engines like RE2 via the `re2` npm package
- OWASP classifies ReDoS under A04:2021 (Insecure Design) and it remains testable on CySA+ as an application-layer DoS vector

## Related concepts
[[ReDoS Attack]] [[Denial of Service]] [[Input Validation]] [[Node.js Security]] [[Web Application Firewall]]