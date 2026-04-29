# UDF injection

## What it is
Imagine a calculator that normally only does math, but someone secretly installs a hidden button that calls your phone — that's UDF injection. It's an attack where a malicious actor uploads a **User-Defined Function** (a custom code library, typically a `.dll` or `.so` file) into a database server like MySQL, then executes it to run arbitrary operating system commands with the database service's privileges.

## Why it matters
In a 2019-era penetration testing scenario, attackers who gained SQL injection access to a MySQL instance used `lib_mysqludf_sys` to upload a UDF, then called `sys_exec()` to spawn a reverse shell — escalating from database access to full server compromise. This attack transforms a data-layer vulnerability into complete system takeover, making it a critical post-exploitation technique in red team engagements.

## Key facts
- Requires **FILE privilege** in MySQL (or equivalent) and write access to the plugin directory (`@@plugin_dir`) to place the malicious library
- The attacker uses `CREATE FUNCTION` SQL syntax to register the UDF after uploading the compiled binary
- Most effective when the database service runs as a **high-privilege OS user** (e.g., `root` or `SYSTEM`) — a common misconfiguration
- **Mitigation**: run database services under least-privilege accounts, restrict `FILE` and `CREATE FUNCTION` privileges, monitor plugin directories for unexpected `.dll`/`.so` files
- Tools like **SQLMap** automate UDF injection with the `--os-shell` flag, making it accessible even to low-skill attackers

## Related concepts
[[SQL Injection]] [[Privilege Escalation]] [[Stored Procedures]] [[Database Hardening]] [[Least Privilege]]