# Load_File

## What it is
Like a librarian who can retrieve any book from the stacks and hand it directly to you, `LOAD_FILE()` is a MySQL built-in function that reads a file from the server's filesystem and returns its contents as a string. It requires the executing database user to hold the `FILE` privilege and the file must be readable by the MySQL process owner.

## Why it matters
During a SQL injection attack against a misconfigured MySQL server, an attacker who has identified injection-vulnerable input can call `UNION SELECT LOAD_FILE('/etc/passwd'), NULL, NULL--` to exfiltrate the server's password file directly through the web application's response. This turns a database vulnerability into full local file read access, potentially exposing SSH keys, configuration files with hardcoded credentials, or application source code.

## Key facts
- Requires the `FILE` privilege granted to the database user — least-privilege hardening directly mitigates this attack vector
- The target file must be owned or readable by the OS user running MySQL (typically `mysql`) and its size must be under `max_allowed_packet`
- Commonly chained with `UNION-based` or `error-based` SQL injection to exfiltrate file contents through HTTP responses
- Its counterpart, `INTO OUTFILE` / `INTO DUMPFILE`, performs the reverse — writing attacker-controlled data to the filesystem (e.g., dropping a web shell)
- Disabling it in hardened configurations: set `--secure-file-priv` to an empty or restricted path in `my.cnf`, which limits or blocks filesystem access entirely

## Related concepts
[[SQL Injection]] [[Union-Based Injection]] [[File Privilege Escalation]] [[INTO OUTFILE]] [[Least Privilege]]