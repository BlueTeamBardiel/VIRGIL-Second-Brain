# CWE-78 - OS Command Injection

## What it is
Imagine a restaurant where you hand a note to the waiter saying "one soup" — but instead you write "one soup; also open the back door." If the kitchen follows every instruction on the note without questioning it, you've hijacked their process. OS Command Injection works the same way: an attacker embeds shell commands inside user-supplied input that the application blindly passes to a system shell (e.g., `bash`, `cmd.exe`), causing the OS to execute the attacker's commands with the application's privileges.

## Why it matters
In 2021, attackers exploited OS Command Injection in Pulse Connect Secure VPN appliances (CVE-2021-22893) to execute arbitrary commands, gaining persistent access to U.S. government networks. The vulnerability existed because user-controlled data was concatenated directly into a shell command without sanitization — a textbook CWE-78 failure that bypassed authentication entirely.

## Key facts
- **Shell metacharacters are the weapon**: characters like `;`, `|`, `&&`, `||`, `` ` ``, and `$()` chain or redirect commands in Unix/Windows shells.
- **Blind vs. Verbose injection**: in blind injection, output isn't returned to the attacker — they infer execution via time delays (`sleep 5`) or out-of-band DNS callbacks.
- **Root cause**: using functions like `system()`, `exec()`, `popen()` in C/PHP, or `os.system()` in Python with unsanitized input.
- **Mitigation priority**: use parameterized APIs (e.g., `subprocess` with a list argument in Python) that never invoke a shell interpreter; avoid `shell=True`.
- **CWE-78 vs. CWE-77**: CWE-77 is the broader "command injection" category; CWE-78 specifically involves OS shell interpreters.

## Related concepts
[[CWE-77 Command Injection]] [[Input Validation]] [[Principle of Least Privilege]] [[Code Injection]] [[Shell Metacharacters]]