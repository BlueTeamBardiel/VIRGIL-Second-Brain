# UNION SELECT

## What it is
Imagine you're at a library asking for books on cooking — but you slip a second request onto the same slip: "...AND also hand me all the files from the restricted archive." UNION SELECT works exactly like that: it appends a second SQL query to a legitimate one, forcing the database to combine and return results from a completely different table. It exploits SQL's `UNION` operator, which merges result sets from multiple `SELECT` statements when column counts and data types match.

## Why it matters
In 2008, attackers used UNION-based SQL injection against Heartland Payment Systems to extract credit card data from backend databases — ultimately compromising 130 million card numbers. Defenders learn to detect this by watching application logs and WAF alerts for keywords like `UNION`, `SELECT`, and encoded variants (`%55NION`) appearing inside user-supplied input fields.

## Key facts
- **Column count must match**: The injected `SELECT` must return the same number of columns as the original query — attackers enumerate this using `ORDER BY` incrementing or `NULL` padding.
- **Data type alignment**: Each column's data type in the injected query must be compatible with the original, or the database throws an error.
- **Classic payload pattern**: `' UNION SELECT username, password, NULL FROM users--` appended to a vulnerable input field.
- **Error-based vs. blind**: UNION SELECT is an *in-band* technique — results appear directly in the response, unlike blind SQLi which requires inference.
- **Detection signatures**: WAFs and IDS tools flag `UNION` combined with `SELECT` in HTTP parameters; attackers evade using case variation (`UnIoN SeLeCt`), comments (`UN/**/ION`), or URL encoding.

## Related concepts
[[SQL Injection]] [[Error-Based SQLi]] [[Web Application Firewall]] [[Blind SQL Injection]] [[Input Validation]]