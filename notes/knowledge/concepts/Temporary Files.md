# Temporary Files

## What it is
Like a sticky note left on your desk that you forget to shred — visible to anyone who walks by — temporary files are short-lived files created by applications to store data mid-process, but which often persist far longer than intended. Operating systems and applications generate them during installation, updates, crashes, and normal operation, storing them in predictable locations like `/tmp` on Linux or `C:\Windows\Temp` on Windows.

## Why it matters
In 2015, attackers exploited predictable temporary file naming in several Linux applications through a **symlink attack**: because `/tmp/appname_tmp` was created with a guessable name and weak permissions, an attacker could pre-create a symlink pointing to `/etc/passwd`, causing the application to overwrite a critical system file when it wrote its "temporary" data. Defenders counter this by enforcing sticky bits on `/tmp` (`chmod +t`), using `mkstemp()` instead of `tmpnam()`, and regularly auditing temp directories for sensitive residual data.

## Key facts
- **Predictable naming is the root cause**: Functions like `tmpnam()` generate guessable filenames, enabling race conditions (TOCTOU — Time-of-Check to Time-of-Use attacks)
- **Sensitive data leakage**: Temp files may contain credentials, session tokens, or PII left behind after application crashes or improper cleanup
- **Default locations are world-readable**: `/tmp` on Unix systems is often readable by all users unless the sticky bit (`+t`) is properly set
- **Windows prefetch and temp artifacts** in `%TEMP%` and `%TMP%` are goldmines for forensic investigators and attackers performing local reconnaissance
- **Secure coding fix**: Use `mkstemp()` (Linux) or `GetTempFileName()` with proper ACLs (Windows) to create temp files with unique, unpredictable names and restricted permissions

## Related concepts
[[TOCTOU Race Condition]] [[File Permission Security]] [[Privilege Escalation]] [[Sensitive Data Exposure]] [[Forensic Artifacts]]