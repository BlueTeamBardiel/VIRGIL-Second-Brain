# allowlist

## What it is
Like a VIP club with a velvet rope — only names already on the list get in, everyone else is turned away without discussion. An allowlist (formerly called a whitelist) is a security control that explicitly permits only pre-approved entities — applications, IP addresses, email senders, or domains — while denying everything else by default. This "default-deny" posture inverts traditional blacklisting logic.

## Why it matters
In 2021, attackers distributed malicious macros through phishing documents; organizations using application allowlisting blocked the payload from executing entirely because the unsigned script was never on the approved list — no signature update needed, no detection race. This is why NIST and CISA consistently recommend application allowlisting as a top control against ransomware and fileless malware, where traditional AV fails.

## Key facts
- **Default-deny principle**: anything not explicitly permitted is blocked — opposite of a denylist/blacklist which blocks known-bad only
- **Application allowlisting** controls which executables, scripts, and libraries can run; Windows AppLocker and WDAC (Windows Defender Application Control) are the primary enterprise implementations
- **IP/network allowlisting** restricts inbound or outbound traffic to known-good addresses — commonly used to protect admin interfaces and APIs
- **Maintenance overhead** is the key tradeoff: every legitimate new application or address must be manually approved, increasing administrative burden
- **Exam tip**: allowlisting is classified as a **preventive control** and maps to the principle of **least functionality** in NIST SP 800-53 and CIS Controls

## Related concepts
[[denylist]] [[application control]] [[least privilege]] [[zero trust]] [[default-deny]]