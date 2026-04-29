# time-based blind SQLi

## What it is
Like knocking on a wall and timing the echo to figure out what's behind it, time-based blind SQLi extracts database information through deliberate delays rather than visible output. When an application returns no data but still executes injected SQL, an attacker injects conditional sleep commands (e.g., `IF(1=1, SLEEP(5), 0)`) and measures response time to infer true/false answers about the database — one bit at a time.

## Why it matters
In 2019, attackers exploiting Drupal installations used time-based blind SQLi to enumerate admin credentials on sites where error messages were fully suppressed — a common hardening measure that failed to prevent extraction. This demonstrates that hiding error output is not sufficient protection; parameterized queries are required to actually block injection.

## Key facts
- Uses SQL functions like `SLEEP(n)` (MySQL), `WAITFOR DELAY` (MSSQL), or `pg_sleep(n)` (PostgreSQL) to encode boolean answers in response latency
- Extremely slow — extracting a single password hash can require thousands of requests, making it detectable via anomalous traffic patterns in a SIEM
- Tools like **sqlmap** automate time-based blind SQLi with `--technique=T`, making it trivially scriptable for attackers
- Effective even when the application returns a completely blank page, because the *timing channel* exists independent of HTTP response content
- Mitigation is identical to other SQLi types: **parameterized queries / prepared statements** — WAF rules alone are insufficient because payloads can be obfuscated

## Related concepts
[[SQL Injection]] [[Boolean-based blind SQLi]] [[Prepared Statements]] [[WAF evasion]] [[Out-of-band SQLi]]