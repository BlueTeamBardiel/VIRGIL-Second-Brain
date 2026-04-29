# recursive descent parsing

## What it is
Like a chef reading a recipe by tackling each section (prep, cook, plate) as a self-contained task that may call sub-tasks, recursive descent parsing processes structured input by breaking grammar rules into functions that call each other — each handling one grammar rule, recursing into sub-rules as needed. It is a top-down parsing technique where each non-terminal in a formal grammar maps directly to a function in code, producing a parse tree by consuming tokens left to right.

## Why it matters
Many security vulnerabilities stem from hand-rolled recursive descent parsers that developers write to process untrusted input — HTTP headers, XML, JSON, or protocol messages. If the parser doesn't enforce recursion depth limits, an attacker can craft deeply nested input (e.g., `[[[[[[...]]]]]]` in JSON) to trigger a stack overflow, causing denial of service or exploiting undefined behavior — a class of attack seen against older XML parsers and expression evaluators in WAFs and SIEM rules engines.

## Key facts
- **Stack exhaustion attacks** target recursive descent parsers via deeply nested structures; mitigated by enforcing a maximum recursion depth (e.g., Python's default limit of 1000 frames).
- Ambiguous or left-recursive grammars can cause infinite recursion in naive implementations, a common source of parser bugs in security tools.
- Many regex engines and query language parsers (e.g., LDAP filter parsers) use recursive descent internally — LDAP injection partially succeeds because parsers mishandle malformed filter nesting.
- Correctly implemented recursive descent parsers provide **predictable, auditable control flow**, making them preferable to `eval()`-based parsing in secure-by-design applications.
- Parser differentials — two systems parsing the same input differently — are a root cause of HTTP request smuggling and WAF bypass vulnerabilities.

## Related concepts
[[input validation]] [[stack buffer overflow]] [[XML external entity injection]]