# stored procedure

## What it is
Think of a stored procedure like a vending machine: you press a button (pass parameters), and it executes a pre-programmed sequence inside — you never touch the internal mechanics directly. Precisely, a stored procedure is a named, precompiled set of SQL statements stored in a database that applications call by name, passing parameters rather than constructing raw SQL queries at runtime.

## Why it matters
Stored procedures are one of the most reliable defenses against SQL injection because user input is passed as a typed parameter, never concatenated into executable SQL. For example, a login function that calls `sp_ValidateUser(@username, @password)` prevents an attacker from injecting `' OR '1'='1` because the input is treated as data, not code. However, poorly written stored procedures that internally concatenate strings (dynamic SQL) can still be vulnerable — security teams must audit the procedure's internal logic, not just the calling code.

## Key facts
- Stored procedures implement **parameterized queries**, which separate code from data and directly mitigate SQL injection (CWE-89).
- They enforce **least privilege** at the database layer — applications can be granted EXECUTE permission on specific procedures without needing direct SELECT/INSERT rights on underlying tables.
- Dynamic SQL *inside* a stored procedure (e.g., using `EXEC()` or `sp_executesql` with concatenated strings) reintroduces SQL injection risk despite using a stored procedure wrapper.
- Stored procedures can log and audit usage centrally, supporting **detective controls** and forensic investigation.
- On Security+/CySA+ exams, stored procedures appear as a **secure coding practice** and a mitigation strategy within the OWASP Top 10 for injection flaws.

## Related concepts
[[SQL injection]] [[parameterized queries]] [[least privilege]] [[input validation]] [[database security]]