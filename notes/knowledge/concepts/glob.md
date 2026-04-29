# glob

## What it is
Like a wildcard in a card game where `*` means "any card of any suit," glob patterns let you match multiple filenames with a single expression using characters like `*`, `?`, and `[]`. Precisely, glob is a pattern-matching syntax used by shells and programming languages to expand file paths based on wildcards, with the shell performing the expansion *before* passing arguments to a command.

## Why it matters
An attacker exploiting a cron job or backup script that uses unquoted glob patterns can perform a **wildcard injection** attack — by creating files named `--checkpoint=1` or `--checkpoint-action=exec=sh shell.sh` in a writable directory, they trick tools like `tar` into interpreting filenames as command-line flags, achieving arbitrary code execution with elevated privileges.

## Key facts
- The shell expands globs *before* execution — so `rm *` in `/tmp` owned by an attacker is dangerous if the attacker controls filenames in that directory
- **Wildcard injection** (a.k.a. glob expansion abuse) is a classic Linux privilege escalation vector, especially targeting `tar`, `rsync`, and `chown` in cron jobs
- In Python, `glob.glob()` does **not** expand `~` or environment variables — use `os.path.expanduser()` separately
- Quoting variables in bash (`"$file"` vs `$file`) prevents unintended glob expansion, a critical secure coding practice
- `?` matches exactly one character; `*` matches zero or more; `[abc]` matches any single character in the set — these behave differently from regex

## Related concepts
[[Command Injection]] [[Cron Job Abuse]] [[Privilege Escalation]] [[Input Validation]]