# time-based blind SQL injection

## What it is
Like a prisoner tapping on a wall to communicate — one tap for yes, two for no — time-based blind SQLi extracts data one bit at a time by measuring whether the database *pauses* before responding. It is a blind SQL injection variant where the attacker injects conditional time-delay functions (e.g., `SLEEP(5)` in MySQL, `WAITFOR DELAY` in MSSQL) to infer true/false answers from response latency when no visible query output is returned.

## Why it matters
In 2012, attackers used time-based blind SQLi against Yahoo! Voices to enumerate the backend database structure before dumping 450,000 plaintext credentials — the database returned no errors, making the delay-based approach the only viable extraction channel. Defenders use query execution time monitoring and WAF anomaly rules to detect the characteristic rhythmic latency spikes this technique produces.

## Key facts
- Uses database-specific delay functions: `SLEEP(n)` (MySQL), `WAITFOR DELAY '0:0:n'` (MSSQL), `pg_sleep(n)` (PostgreSQL), `dbms_pipe.receive_message` (Oracle)
- Inference is binary: attacker asks "Is the first character of the admin password greater than 'M'?" — a delay means YES
- Extremely slow — extracting a single 8-character password can require hundreds of HTTP requests
- Automated tools like **sqlmap** with `--technique=T` flag fully automate time-based extraction
- Network jitter and server load can cause false positives/negatives, making reliable timing thresholds (typically ≥5 seconds) critical for accuracy
- Classified under **CWE-89** (SQL Injection) and detectable via IDS signatures watching for delay-function keywords in HTTP parameters

## Related concepts
[[blind SQL injection]] [[error-based SQL injection]] [[SQL injection]] [[WAF evasion]] [[sqlmap]]