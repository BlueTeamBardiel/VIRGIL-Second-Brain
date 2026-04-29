# environment variables

## What it is
Think of environment variables like sticky notes plastered inside a process's workspace — they hold configuration details (passwords, API keys, paths) that any program running in that context can read without being explicitly told. Precisely, they are dynamic named values stored in a process's memory space, inherited by child processes, and used to pass configuration data to applications at runtime.

## Why it matters
In 2021, misconfigured `.env` files containing database credentials and API keys were mass-harvested by attackers scanning GitHub repositories — a direct result of developers treating environment variables carelessly by committing them to source control. Defenders use tools like `truffleHog` or `git-secrets` to scan repositories for exposed secrets before they reach production. On the attack side, compromising a web shell gives attackers the ability to run `printenv` and instantly harvest every secret the application was handed at startup.

## Key facts
- Environment variables are inherited by child processes, meaning a privileged parent process can unintentionally expose secrets to spawned subprocesses
- The `PATH` variable is a classic attack vector — path hijacking occurs when an attacker plants a malicious binary in a directory listed earlier in `PATH` than the legitimate binary
- On Linux, `/proc/[PID]/environ` exposes environment variables of running processes and may be readable by low-privileged users depending on system configuration
- The **Shellshock** vulnerability (CVE-2014-6271) weaponized Bash's handling of environment variables to achieve remote code execution on web servers
- Secrets stored in environment variables are still plaintext in memory; container security best practices recommend secrets managers (HashiCorp Vault, AWS Secrets Manager) over raw env vars

## Related concepts
[[path hijacking]] [[privilege escalation]] [[secrets management]]