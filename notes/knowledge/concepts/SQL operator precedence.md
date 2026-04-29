# SQL operator precedence

## What it is
Like a math expression where multiplication happens before addition regardless of left-to-right reading, SQL evaluates operators in a fixed hierarchy: `NOT` first, then `AND`, then `OR`. This means `WHERE a OR b AND c` is parsed as `WHERE a OR (b AND c)`, not `(a OR b) AND c` — a subtle distinction that attackers exploit deliberately.

## Why it matters
Classic SQL injection bypasses authentication by injecting `' OR '1'='1` into a login query, producing `WHERE username='' OR '1'='1' AND password=''`. Because `AND` binds tighter than `OR`, this evaluates as `WHERE (username='') OR ('1'='1' AND password='')` — and since `'1'='1'` is always true with an empty password match possible, it can collapse into a full table return, granting unauthorized access.

## Key facts
- **Precedence order (high to low):** Arithmetic → Comparison (`=`, `<`, `>`) → `NOT` → `AND` → `OR`
- **`OR` is the weakest logical operator** — injecting it can short-circuit complex `AND` conditions and widen query results unexpectedly
- **Parentheses override all precedence** — parameterized queries that wrap user input safely prevent precedence manipulation entirely
- **`BETWEEN`, `IN`, `LIKE`, and `IS NULL`** bind at the same level as comparisons, above `NOT`
- Developers who rely on "mental left-to-right" reading of SQL conditions introduce logic flaws that appear in OWASP Top 10 A03 (Injection)

## Related concepts
[[SQL Injection]] [[Authentication Bypass]] [[Parameterized Queries]]