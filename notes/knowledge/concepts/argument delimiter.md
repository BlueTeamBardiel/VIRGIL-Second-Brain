# argument delimiter

## What it is
Think of a restaurant order ticket where a comma separates each dish — the kitchen knows where one item ends and the next begins. An argument delimiter is a character or sequence (such as a space, comma, semicolon, or null byte) that a parser uses to distinguish where one argument ends and the next begins in a command, function call, or data stream. Mishandling delimiters is where injection attacks are born.

## Why it matters
In command injection attacks, an attacker exploits argument delimiters to escape the intended command context. For example, passing `; rm -rf /` in a web form field that feeds unsanitized input into a shell command uses the semicolon as a delimiter to terminate the original command and inject a new destructive one — a classic OS command injection vector tested on Security+ exams.

## Key facts
- Common argument delimiters include: space (` `), semicolon (`;`), pipe (`|`), ampersand (`&`), comma (`,`), and null byte (`\x00`).
- **Null byte injection** (`%00`) can truncate strings in languages like C or older PHP, causing parsers to ignore everything after the null — used to bypass file extension filters.
- SQL injection exploits SQL-specific delimiters like single quotes (`'`) and comment sequences (`--`) to reinterpret argument boundaries.
- Improper delimiter handling is the root cause of **argument injection**, where attacker-controlled input is parsed as additional flags/options rather than data (e.g., injecting `--config=evil` into a CLI tool).
- Defense: input validation, allowlisting expected characters, and using parameterized APIs that treat user input as data — never as part of the command structure.

## Related concepts
[[command injection]] [[SQL injection]] [[null byte injection]] [[input validation]] [[parameterized queries]]