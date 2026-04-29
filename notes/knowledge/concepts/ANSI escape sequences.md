# ANSI escape sequences

## What it is
Like hidden stage directions embedded in an actor's script that control lighting and movement rather than being spoken aloud, ANSI escape sequences are special byte strings embedded in text output that instruct terminals to change colors, move the cursor, or clear the screen instead of displaying literal characters. Formally, they begin with the ESC character (0x1B) followed by `[` and a command code — for example, `\x1b[31m` switches text to red. They are interpreted by terminal emulators, not the underlying OS, which creates a dangerous gap between what data *is* and what it *looks like*.

## Why it matters
An attacker who controls log file content can inject escape sequences to overwrite previously displayed lines in a terminal — a technique called **terminal log injection** or **log poisoning**. When an administrator `cat`s a malicious log file, injected sequences can make legitimate entries vanish and forge clean-looking output, hiding evidence of compromise. This same vector was exploited in real supply-chain attacks targeting developer terminals via npm package output.

## Key facts
- The canonical escape sequence prefix is `ESC [` (CSI — Control Sequence Introducer), where ESC = byte `0x1B` (decimal 27)
- **`\x1b[2J`** clears the entire screen; **`\x1b[1A`** moves the cursor up one line — both weaponizable in log tampering
- ANSI injection is classified under **CWE-116** (Improper Encoding or Escaping of Output)
- Defense: sanitize or strip escape sequences before writing untrusted input to logs or terminals; tools like `ansi-regex` can detect them programmatically
- Some CVEs exploit ANSI sequences in terminal titles (`\x1b]0;...`) to inject commands via terminal title-bar copy-paste tricks

## Related concepts
[[Log Injection]] [[Output Encoding]] [[Terminal Emulator Security]]