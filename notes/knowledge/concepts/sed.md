# sed

## What it is
Like a find-and-replace robot that reads a document line-by-line and makes surgical edits without ever opening a word processor — `sed` (Stream EDitor) is a Unix command-line utility that applies transformation rules to text streams or files using pattern matching and substitution. It processes input line by line, applying specified commands, and outputs the result without modifying the original file unless explicitly told to.

## Why it matters
Attackers frequently use `sed` in post-exploitation scripts to scrub evidence — for example, removing specific IP addresses or usernames from log files with a single command like `sed -i '/192.168.1.105/d' /var/log/auth.log`. Defenders and forensic analysts must recognize that in-place log modification (`-i` flag) leaves no automatic backup, making tampered logs difficult to detect without file integrity monitoring tools like Tripwire or AIDE.

## Key facts
- The `-i` flag performs **in-place editing**, permanently altering the original file — a common attacker technique for log tampering and anti-forensics
- Basic substitution syntax: `sed 's/original/replacement/g'` — the `g` flag replaces **all** occurrences per line, not just the first
- `sed` can **delete lines** matching a pattern using the `d` command: `sed '/pattern/d'` — used to scrub specific entries from logs
- It is **non-interactive** and pipeable, making it ideal for use in shell scripts and one-liner payloads during living-off-the-land (LotL) attacks
- Regular expressions power `sed`'s pattern matching, meaning complex obfuscation and extraction tasks are achievable without additional tools

## Related concepts
[[Log Tampering]] [[Living off the Land (LotL)]] [[File Integrity Monitoring]] [[Bash Scripting]] [[Anti-Forensics]]