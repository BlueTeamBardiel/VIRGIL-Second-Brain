# recursive CTE

## What it is
Like a Russian nesting doll that keeps opening itself until it finds the smallest doll inside, a recursive Common Table Expression (CTE) is a SQL query that repeatedly calls itself, building results iteratively until a termination condition is met. Defined with `WITH RECURSIVE`, it consists of an anchor member (base case) and a recursive member joined by `UNION ALL`, processing hierarchical or graph-structured data that flat queries can't reach.

## Why it matters
Attackers who gain SQL injection footholds use recursive CTEs to traverse organizational hierarchies stored in self-referencing tables — for example, dumping an entire Active Directory-style employee-manager tree from a single compromised query without needing multiple round trips. Defenders analyzing log databases use recursive CTEs to trace lateral movement chains: starting from a compromised host and recursively following connection records to map the full blast radius of an intrusion.

## Key facts
- A recursive CTE **must have a termination condition** (e.g., depth counter or NULL parent) — infinite recursion causes denial-of-service via query exhaustion
- SQL injection into recursive CTEs can **bypass row-limit defenses** that assume flat queries, exfiltrating entire relational trees in one request
- Many databases impose a **max recursion depth** (SQL Server defaults to 100; PostgreSQL has no hard default) — misconfiguration can enable resource exhaustion attacks
- Recursive CTEs appear in **privilege escalation queries**: tracing role inheritance chains in PostgreSQL to find overprivileged inherited roles
- Forensically, recursive CTEs in query logs **signal advanced attacker tradecraft** — script kiddies don't write them; their presence suggests skilled threat actors or automated toolkits

## Related concepts
[[SQL Injection]] [[Database Enumeration]] [[Privilege Escalation]]