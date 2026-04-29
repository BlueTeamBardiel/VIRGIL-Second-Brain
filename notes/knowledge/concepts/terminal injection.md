# terminal injection

## What it is
Imagine someone slipping a forged order into a stack of legitimate restaurant tickets — the kitchen can't tell the difference and executes it. Terminal injection is exactly that: an attacker embeds malicious control characters or escape sequences into data that gets displayed in a terminal emulator, causing the terminal itself to interpret and execute unintended commands. Unlike command injection, the payload targets the *display layer*, not the shell directly.

## Why it matters
A classic scenario involves log poisoning for terminal injection: an attacker sends an HTTP request with a crafted User-Agent string containing ANSI escape sequences like `\x1b[A` (cursor up) and carriage returns (`\r`). When an administrator `cat`s the log file in a terminal, the sequences rewrite visible text, hiding malicious entries or even injecting commands into the terminal's input buffer via sequences like `\x1b[?1049h`. This has been weaponized to trick admins into unknowingly executing attacker-controlled commands.

## Key facts
- Terminal injection exploits ANSI/VT100 escape sequences interpreted by terminal emulators (xterm, iTerm2, Windows Terminal), not the shell parser itself
- The escape character `ESC` (0x1B) is the trigger; sequences like `\x1b]0;title\x07` can silently change window titles used for social engineering
- Attack vectors include log files, filenames, environment variables, and any untrusted data rendered in a terminal
- Defense: sanitize output before displaying in terminals; tools like `cat -v` reveal hidden escape characters without interpreting them
- CVE-2023-45853 and similar CVEs demonstrate that terminal injection remains an active, underestimated attack surface in modern DevOps workflows

## Related concepts
[[command injection]] [[log poisoning]] [[ANSI escape sequences]] [[output encoding]] [[privilege escalation]]