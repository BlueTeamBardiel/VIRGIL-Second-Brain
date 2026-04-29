# blind SQL injection

## What it is
Like interrogating a suspect who can only nod or shake their head — you never see the database output directly, but you infer secrets one yes/no question at a time. Blind SQL injection is a variant of SQL injection where the application returns no visible error or data, forcing the attacker to extract information by observing indirect signals like true/false page differences (Boolean-based) or deliberate time delays (time-based).

## Why it matters
In 2008, attackers used time-based blind SQL injection against Heartland Payment Systems, eventually extracting credit card data for over 130 million accounts — one of the largest breaches in history. Defenders must watch for unusual patterns of near-identical queries with slight variations, or database CPU spikes caused by repeated `SLEEP()` or `WAITFOR DELAY` calls, since no obvious error messages will betray the attack in logs.

## Key facts
- **Boolean-based**: attacker sends queries like `AND 1=1` (page loads) vs `AND 1=2` (page breaks) to infer truth conditions character by character
- **Time-based**: uses database functions like `SLEEP(5)` (MySQL) or `WAITFOR DELAY '0:0:5'` (MSSQL) — a measurable pause confirms a true condition
- **Extremely slow but effective**: extracting a single 8-character password may require hundreds of requests; tools like `sqlmap` automate this
- **WAF evasion is easier** than with classic SQLi because no error strings are returned, making signature-based detection less reliable
- **Mitigation**: parameterized queries/prepared statements eliminate the vulnerability entirely; additionally, monitor for anomalous query volume and response-time outliers

## Related concepts
[[SQL injection]] [[time-based attack]] [[parameterized queries]] [[sqlmap]] [[web application firewall]]