# SQL Injection Prevention

## What it is
Think of a SQL query like a form letter with blanks to fill in — SQL injection happens when an attacker writes outside the blanks and rewrites the whole letter. Prevention means enforcing that user input can only ever be *data*, never *instructions*. It's the set of coding and architectural controls that stop malicious SQL syntax from being interpreted as executable database commands.

## Why it matters
In 2008, Heartland Payment Systems suffered one of the largest data breaches in history — over 130 million credit card numbers stolen — because attackers injected SQL through a web form to plant malware on internal database servers. A single parameterized query instead of string concatenation would have broken the attack chain entirely. This class of vulnerability still ranks in the OWASP Top 10 precisely because it remains catastrophically common.

## Key facts
- **Parameterized queries (prepared statements)** are the gold-standard defense — they separate SQL code from user-supplied data at the driver level, making injection structurally impossible
- **Input validation and allowlisting** (rejecting anything not matching an expected pattern) is a secondary defense layer, not a replacement for parameterization
- **Stored procedures** can reduce risk but are NOT automatically safe — dynamic SQL inside a stored procedure is still vulnerable
- **Least privilege** on database accounts limits blast radius: a web app account that can only SELECT/INSERT cannot DROP tables even if injection succeeds
- **WAFs** (Web Application Firewalls) detect and block common injection patterns in transit but are considered a compensating control, not a primary fix

## Related concepts
[[Input Validation]] [[Parameterized Queries]] [[OWASP Top 10]] [[Least Privilege]] [[Web Application Firewall]]