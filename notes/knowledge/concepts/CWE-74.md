# CWE-74

## What it is
Like a mail-sorting machine that blindly follows formatting rules — if you slip a forged label into the input stream, the machine routes your package anywhere you want. CWE-74 is **Improper Neutralization of Special Elements in Output**, where an application constructs a command, query, or document using external input but fails to sanitize characters that carry special meaning in the target interpreter. The downstream system then executes attacker-controlled structure, not just attacker-controlled data.

## Why it matters
CWE-74 is the *parent class* for some of the most exploited vulnerabilities in existence — SQL Injection (CWE-89), OS Command Injection (CWE-78), and Cross-Site Scripting (CWE-79) are all its children. A developer who understands CWE-74 conceptually can recognize injection patterns even in unfamiliar contexts, like LDAP queries, XML parsers, or log forging, before a penetration tester finds them first.

## Key facts
- CWE-74 is a **class-level weakness**, sitting above specific injection types in the CWE hierarchy; it describes the *general pattern* of injection.
- The root cause is always the same: **data and control instructions share the same channel** without proper delimitation or escaping.
- The primary defense is **input validation + output encoding** — validate on the way in, encode for the specific target interpreter on the way out.
- **Parameterized queries and prepared statements** are the gold-standard fix for injection into structured languages like SQL because they enforce data/instruction separation at the protocol level.
- CWE-74 vulnerabilities consistently appear in OWASP Top 10 under **A03:2021 – Injection**, making it high-priority for any AppSec program.

## Related concepts
[[SQL Injection (CWE-89)]] [[Cross-Site Scripting (CWE-79)]] [[OS Command Injection (CWE-78)]] [[Input Validation]] [[OWASP Top 10]]