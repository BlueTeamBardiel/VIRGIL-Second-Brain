# union-based SQL injection

## What it is
Imagine a waiter who sneaks a second order onto your table's bill by stapling it to the original ticket — the kitchen fulfills both orders, but you only asked for one. Union-based SQL injection works the same way: an attacker appends a `UNION SELECT` statement to a legitimate query, forcing the database to return data from a completely different table alongside the original results. It is a type of in-band SQL injection where results are directly visible in the application's HTTP response.

## Why it matters
In 2008, attackers used union-based SQLi against Heartland Payment Systems to extract cardholder data directly from database tables, eventually compromising over 130 million credit card records. Defenders counter this by using parameterized queries (prepared statements), which separate SQL logic from user-supplied data, preventing any injected UNION clause from being interpreted as executable SQL.

## Key facts
- **Column count must match**: the injected `UNION SELECT` must return the same number of columns as the original query, or the database throws an error — attackers use `ORDER BY` probing or `NULL` padding to determine the count.
- **Data types must be compatible**: each column in the injected query must match the data type of its corresponding column in the original query.
- **In-band exfiltration**: results appear directly in the page response, making it faster and simpler than blind SQLi techniques.
- **Information_schema exploitation**: attackers commonly query `information_schema.tables` and `information_schema.columns` to enumerate all database tables and columns before targeting sensitive data.
- **Detection signature**: WAFs and IDS tools flag keywords like `UNION`, `SELECT`, and `--` appearing in HTTP parameters as high-confidence SQLi indicators.

## Related concepts
[[SQL injection]] [[blind SQL injection]] [[error-based SQL injection]]