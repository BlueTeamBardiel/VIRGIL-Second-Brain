# Error Handling

## What it is
Like a poker player who accidentally shows their hand when they fold, an application that exposes raw error messages reveals its internal workings to anyone watching. Error handling is the practice of intercepting and managing application failures in a controlled way — logging detailed diagnostics internally while presenting sanitized, generic messages to end users.

## Why it matters
In 2021, attackers targeting misconfigured web applications routinely harvested verbose SQL error messages like `"ORA-00933: SQL command not properly ended"` to confirm injection points and identify backend database vendors. Proper error handling replaces these with generic "An error occurred" responses, denying attackers the reconnaissance they need to craft targeted exploits.

## Key facts
- **Verbose error messages** are classified as an information disclosure vulnerability (CWE-209) and appear explicitly in the OWASP Top 10 under Security Misconfiguration
- **Stack traces** exposed to users can reveal framework versions, file paths, class names, and database schemas — each a gift to an attacker
- **Fail securely** is the core principle: when a system fails, it should default to a denied/locked state rather than an open one (e.g., a failed authentication check should never grant access)
- **Centralized logging** of full error details internally (SIEM-accessible) satisfies both debugging needs and audit requirements without exposing data externally
- Error handling weaknesses directly enable **SQL injection discovery**, **path traversal mapping**, and **credential enumeration** — all testable Security+/CySA+ attack categories

## Related concepts
[[Information Disclosure]] [[Input Validation]] [[SQL Injection]] [[Secure Coding Practices]]