# User-Defined Functions

## What it is
Like a custom stamp you carve yourself — you define its shape once, then press it anywhere in your document. In programming, a user-defined function (UDF) is a named, reusable block of code that a developer writes to perform a specific task, called by name whenever that task is needed. Unlike built-in library functions, UDFs are created by the application developer and live in the application's own codebase.

## Why it matters
Attackers exploit poorly written UDFs in SQL databases (MySQL, PostgreSQL) to escalate privileges — a UDF compiled as a malicious `.dll` or `.so` file can be loaded into a database engine running as SYSTEM, turning a SQL injection foothold into full OS command execution. Defenders audit UDF usage in database servers as a high-priority hardening step because legitimate applications rarely need custom database-level functions.

## Key facts
- **SQL UDF abuse** is a documented privilege escalation technique (MITRE ATT&CK T1068): attackers write a shared library to disk via `INTO DUMPFILE`, then load it with `CREATE FUNCTION` to execute OS commands.
- UDFs inherit the permissions of the process running them — a database service running as root or SYSTEM makes malicious UDFs catastrophically dangerous.
- Secure coding standards require UDFs to validate all inputs internally; they are *not* automatically protected by parameterized queries at the calling layer.
- In static code analysis, UDFs are common sources of **taint flow** — unvalidated user input entering a UDF that later touches a dangerous sink (file write, exec call).
- CySA+ emphasizes reviewing custom code (including UDFs) during application security assessments as part of the software assurance lifecycle.

## Related concepts
[[SQL Injection]] [[Privilege Escalation]] [[Input Validation]] [[Static Code Analysis]]