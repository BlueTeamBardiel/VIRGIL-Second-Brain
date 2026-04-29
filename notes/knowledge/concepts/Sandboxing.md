# Sandboxing

## What it is
Like a quarantine ward where doctors study infectious patients through glass without risking the hospital, a sandbox isolates untrusted code in a restricted execution environment where it can run but cannot touch real system resources. Any file operations, network calls, or registry writes are intercepted, redirected, or denied. The goal is observation and containment — let the code *think* it's running freely while the real system stays untouched.

## Why it matters
When a phishing email delivers a suspicious PDF attachment, a sandbox-enabled email gateway executes that PDF automatically in an isolated VM and watches for behaviors like spawning cmd.exe, beaconing to an external IP, or dropping executables into temp folders. Sophisticated malware authors respond with sandbox evasion techniques — checking for user mouse movement, sleeping for minutes before executing, or detecting VM artifacts like missing registry keys — making behavioral sandbox analysis an ongoing arms race.

## Key facts
- Sandboxes enforce isolation through OS-level controls (containers, VMs, hypervisors, or browser renderer processes like Chrome's site isolation)
- **Cuckoo Sandbox** is a major open-source dynamic malware analysis sandbox used in SOC environments
- Browsers use sandboxing to isolate tabs/plugins — a compromised renderer cannot directly access the OS without a separate **sandbox escape** exploit
- Sandbox evasion is a red flag: malware that stalls, checks CPUID for virtualization, or counts running processes before activating is actively attempting to detect analysis environments
- On Security+/CySA+: sandboxing is classified as a **preventive and detective** control; it appears in questions about malware analysis, application whitelisting, and zero-day defense

## Related concepts
[[Dynamic Malware Analysis]] [[Virtual Machines]] [[Application Whitelisting]] [[Threat Intelligence]] [[Privilege Separation]]