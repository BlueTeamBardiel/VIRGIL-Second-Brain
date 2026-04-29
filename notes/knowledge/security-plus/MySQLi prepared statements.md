# mysqli prepared statements

## What it is
Like a cookie-cutter stamp where the shape is fixed before you press it into dough — the structure is locked, and the filling can never reshape the mold. Technically, mysqli prepared statements are a PHP database API feature where SQL query structure is compiled and sent to the database *before* user-supplied data is bound to it, using parameterized placeholders (`?`) instead of concatenated strings.

## Why it matters
In 2008, the Heartland Payment Systems breach exposed 130 million credit card numbers — attackers exploited SQL injection by embedding malicious SQL into input fields that were string-concatenated directly into queries. Had prepared statements been used, the attacker's input (`' OR 1=1 --`) would have been treated as literal data, not executable SQL, making the injection harmless.

## Key facts
- Prepared statements split execution into two phases: **prepare** (sends SQL skeleton) and **execute** (sends bound data separately), so the database engine never interprets user input as SQL syntax
- The key PHP methods are `prepare()`, `bind_param()`, and `execute()` — skipping `bind_param()` and concatenating data manually defeats the protection entirely
- They defend against **first-order SQL injection** but do *not* protect against second-order injection if stored data is later unsafely reused in a dynamic query
- Type specifiers in `bind_param()` (`"s"` for string, `"i"` for integer) enforce basic type validation as a secondary control
- Prepared statements also improve performance on repeated queries because the database caches the compiled query plan after the first `prepare()` call

## Related concepts
[[SQL Injection]] [[Input Validation]] [[Parameterized Queries]] [[OWASP Top 10]]