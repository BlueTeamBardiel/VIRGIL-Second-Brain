# SQL operator precedence bugs

## What it is
Like assuming "salt and pepper or sugar" means "(salt and pepper) or sugar" when the chef meant "salt and (pepper or sugar)" — wrong grouping changes everything. SQL operator precedence bugs occur when a query's logical operators (`AND`, `OR`, `NOT`) are evaluated in an unintended order due to missing parentheses, causing the database to enforce a different condition than the developer expected.

## Why it matters
A classic authentication bypass exploits this directly: a login query like `WHERE username='admin' AND password='x' OR '1'='1'` evaluates `AND` before `OR`, making the entire `WHERE` clause true for every row — granting access without valid credentials. Developers who don't explicitly parenthesize their conditions hand attackers a free pass through the front door.

## Key facts
- SQL operator precedence order is: `NOT` → `AND` → `OR`, meaning `AND` always binds tighter than `OR` without explicit parentheses
- The canonical injection string `' OR '1'='1` weaponizes this — it appends a tautology that wins the `OR` evaluation against the `AND`-bound credential check
- Parameterized queries (prepared statements) eliminate this attack surface entirely because user input is never parsed as SQL logic
- Input validation alone is insufficient defense — the structural fix is query parameterization, not blacklisting operators
- These bugs appear in ORM-generated queries too, not just raw SQL, when dynamic `WHERE` clauses are built by concatenating user-controlled fragments

## Related concepts
[[SQL injection]] [[authentication bypass]] [[parameterized queries]]