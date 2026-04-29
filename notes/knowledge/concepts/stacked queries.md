# stacked queries

## What it is
Like sneaking a second errand into a phone call by saying "oh, and also..." — stacked queries allow an attacker to append a completely separate SQL statement to the original query using a semicolon as the separator. Precisely: stacked queries (also called batched queries) are a SQL injection technique where multiple SQL statements are executed in a single database call, separated by semicolons, enabling attackers to run arbitrary commands beyond the original query's intent.

## Why it matters
In the 2008 Heartland Payment Systems breach, attackers used SQL injection techniques — including stacked queries — to execute malicious commands that installed packet-sniffing malware directly on database servers, ultimately stealing 130 million card numbers. Defenders use parameterized queries and stored procedures to prevent stacked query execution because these methods treat user input as data, never as executable code.

## Key facts
- Stacked queries require the database driver/connector to support multi-statement execution — MySQL's PHP `mysqli` extension allows it, but PDO with MySQL disables it by default
- The classic payload pattern is `'; DROP TABLE users; --` where the semicolon terminates the first query and begins the second
- Not all databases are equally vulnerable: Microsoft SQL Server and PostgreSQL support stacked queries natively; MySQL support depends heavily on the API/driver in use
- Stacked queries are more dangerous than standard SQL injection because they can execute `INSERT`, `UPDATE`, `DROP`, or even OS-level commands via `xp_cmdshell` in MSSQL
- WAF evasion techniques often involve encoding the semicolon (`%3B`) or using whitespace variations to bypass signature-based detection

## Related concepts
[[SQL injection]] [[parameterized queries]] [[second-order SQL injection]]