# CWE-88

## What it is
Imagine ordering a coffee "large, no sugar" but a malicious customer whispers extra instructions to the barista by inserting a comma and new order mid-sentence. Argument Injection is exactly that — an attacker injects additional arguments or flags into a command that is being passed to an external program, altering its behavior without breaking the original syntax. The injected content isn't a new command (like OS Command Injection), but an extra *parameter* that changes what the legitimate command does.

## Why it matters
A classic example is email header injection via sendmail: if user input is passed unsanitized to a script calling `sendmail`, an attacker can inject `-X /var/www/shell.php` to write an arbitrary log file as a web shell. The program runs as intended on the surface, but the extra argument silently opens a backdoor — making this difficult to detect with simple command-logging.

## Key facts
- Distinct from CWE-78 (OS Command Injection): CWE-88 doesn't inject a *new* command — it injects *flags or parameters* into an existing one (e.g., `--output=evil.sh`)
- Commonly exploited in programs that call `git`, `curl`, `rsync`, `ffmpeg`, or `sendmail` with user-controlled input
- The `--` (double dash) convention in Unix tells many programs to stop interpreting arguments, and is a common mitigation technique
- Allowlist validation of acceptable arguments is more reliable than blocklisting dangerous flags
- Wget's `--post-file` and curl's `-o` flag are well-known exploit targets when filenames are user-supplied

## Related concepts
[[CWE-78 OS Command Injection]] [[CWE-77 Command Injection]] [[Input Validation]] [[Allowlist Filtering]] [[Least Privilege]]