# UNION-based injection

## What it is
Imagine a waiter who reads your order, then sneaks a second order from a secret menu onto the same tray — that's UNION-based injection. It exploits SQL's `UNION` operator to append a second `SELECT` statement onto a legitimate query, forcing the database to return data from tables the application never intended to expose. The attacker essentially hijacks the result set to retrieve arbitrary data — usernames, passwords, API keys — displayed directly in the application's output.

## Why it matters
In 2008, the Heartland Payment Systems breach began with SQL injection techniques that extracted cardholder data directly from database tables. UNION-based injection is particularly dangerous because it returns data *visibly* in the application's response (login pages, search results, product listings), meaning an attacker can exfiltrate structured data quickly without needing out-of-band channels or timing analysis.

## Key facts
- **Column count must match:** The injected `SELECT` must return the same number of columns as the original query — attackers use `ORDER BY` increments or `NULL` padding to fingerprint this.
- **Data types must be compatible:** Each column in the UNION must have a compatible data type; mismatches cause errors that help attackers enumerate structure.
- **Requires visible output:** UNION-based attacks only work when query results render in the HTTP response — blind injection requires different techniques.
- **Classic payload example:** `' UNION SELECT username, password, NULL FROM users--` appended to a vulnerable parameter.
- **Detection signature:** WAFs and IDS tools flag keywords like `UNION`, `SELECT`, and `--` in input parameters as high-confidence SQLi indicators.

## Related concepts
[[SQL Injection]] [[Blind SQL Injection]] [[Error-based SQL Injection]] [[Web Application Firewall]] [[Input Validation]]