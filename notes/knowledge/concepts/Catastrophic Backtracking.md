# Catastrophic Backtracking

## What it is
Imagine a lost hiker who, at every fork in a maze, backtracks and tries every possible path combination — the number of steps explodes exponentially with each new fork. Catastrophic backtracking is the same phenomenon inside a regex engine: a poorly constructed regular expression causes the engine to explore an exponentially growing number of matching paths when given a crafted malicious input. This is the root mechanism behind **ReDoS (Regular Expression Denial of Service)** attacks.

## Why it matters
In 2016, a single malicious string brought Cloudflare's WAF to its knees for 27 minutes by exploiting a catastrophic backtracking regex in their firewall rule parser, effectively causing a self-inflicted DoS. Attackers who can influence input validated by a vulnerable regex — in login forms, API endpoints, or log parsers — can monopolize CPU cycles and deny service to legitimate users without sending a single exploit payload.

## Key facts
- **Vulnerable pattern signature**: Nested quantifiers like `(a+)+` or `(a|a)*` are the classic triggers — they create ambiguous matching paths the engine must exhaustively explore.
- **Complexity cliff**: A 30-character crafted input against a vulnerable regex can require billions of backtracking steps, turning O(n) matching into O(2ⁿ).
- **Attack vector**: ReDoS is classified under **CWE-1333** (Inefficient Regular Expression Complexity) and is an application-layer DoS requiring no authentication.
- **Detection**: Static analysis tools like `safe-regex` (Node.js) and OWASP's RegexSecurityCheat Sheet identify vulnerable patterns before deployment.
- **Mitigation options**: Use atomic groups/possessive quantifiers (where supported), impose input length limits, set regex timeout limits, or replace complex regex with finite-state machine parsers.

## Related concepts
[[ReDoS]] [[Denial of Service]] [[Input Validation]] [[Web Application Firewall]] [[CWE Vulnerability Classification]]