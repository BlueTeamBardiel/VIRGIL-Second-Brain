# dynamic code execution

## What it is
Like a chef who doesn't just follow a recipe but lets diners shout ingredients mid-meal that get cooked immediately — dynamic code execution is when a program generates and runs code at runtime rather than using only pre-written, compiled instructions. Functions like `eval()` in Python/JavaScript or `exec()` in PHP accept strings as input and treat them as executable code, blurring the line between data and instructions.

## Why it matters
In 2017, a wave of attacks targeted web applications using PHP's `eval()` with unsanitized user input — attackers passed shell commands disguised as data, achieving Remote Code Execution (RCE) and full server compromise. Defenders must treat any dynamic execution function as a high-risk code smell, often flagged by static analysis tools (SAST) during secure code review.

## Key facts
- `eval()`, `exec()`, `assert()`, and `preg_replace()` with the `/e` modifier are classic PHP RCE vectors
- Dynamic execution violates the **data/code separation principle** — a foundational concept in secure design
- Content Security Policy (CSP) headers can block `eval()` in browsers by disallowing `unsafe-eval`, mitigating JavaScript-based attacks
- Sandboxing and allowlisting are preferred mitigations over trying to sanitize input passed to dynamic execution functions
- CWE-95 (Improper Neutralization of Directives in Dynamically Evaluated Code) and CWE-78 (OS Command Injection) are directly tied to this vulnerability class

## Related concepts
[[remote code execution]] [[code injection]] [[input validation]] [[eval injection]] [[static application security testing]]