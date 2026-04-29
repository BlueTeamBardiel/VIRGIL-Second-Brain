# phpcs

## What it is
Like a grammar checker that flags not just typos but dangerous sentence structures before your essay goes to print, PHP_CodeSniffer (phpcs) is a static analysis tool that scans PHP source code against defined coding standards to detect style violations, insecure patterns, and bad practices — before the code ever executes.

## Why it matters
In a DevSecOps pipeline, phpcs integrated with security rulesets (such as the PHPCompatibility or WordPress Coding Standards sniffs) can catch hardcoded credentials, unsanitized `$_GET`/`$_POST` usage, or direct SQL string concatenation during the commit stage — stopping injection vulnerabilities from reaching production. This represents a shift-left security approach: finding flaws at the cheapest possible moment in the SDLC.

## Key facts
- phpcs is a **static analysis / SAST tool** — it analyzes code without executing it, making it safe to run on untrusted codebases
- It uses **"sniffs"** — small rule plugins — that can be customized or extended to enforce security-specific checks beyond style formatting
- Commonly paired with **phpcbf** (PHP Code Beautifier and Fixer) to automatically remediate certain flagged violations
- Integrates into **CI/CD pipelines** (GitHub Actions, Jenkins, GitLab CI) to enforce quality gates, blocking merges on security-relevant violations
- Alone it does **not detect runtime vulnerabilities** (e.g., logic flaws, authentication bypasses) — it complements but does not replace dynamic testing tools like Burp Suite or DAST scanners

## Related concepts
[[Static Application Security Testing]] [[DevSecOps]] [[Code Review]] [[SQL Injection]] [[Shift-Left Security]]