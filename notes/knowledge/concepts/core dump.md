# core dump

## What it is
Like a paramedic photographing every detail of a crash scene the moment an ambulance arrives, a core dump is a snapshot of a process's memory — registers, stack, heap, and all — captured the instant a program crashes. Technically, it's a file written by the OS containing the complete memory state of a process at time of termination, typically triggered by a fatal signal like SIGSEGV.

## Why it matters
Attackers actively hunt for core dump files left on misconfigured servers because they can contain plaintext credentials, cryptographic keys, or session tokens that were live in memory at crash time. In 2014, the Heartbleed vulnerability essentially forced OpenSSL to "leak" memory contents on demand — a controlled version of what an attacker finds in an unguarded core dump. Defenders must ensure core dumps are either disabled in production or stored with strict permissions and scrubbed before analysis.

## Key facts
- Core dumps are typically stored as `/core`, `core.<PID>`, or redirected via `/proc/sys/kernel/core_pattern` on Linux systems
- Sensitive processes (like password managers or HTTPS servers) should disable core dumps using `ulimit -c 0` or `RLIMIT_CORE = 0` in code
- Windows equivalent is a **minidump** or **full memory dump**, used heavily in post-incident forensics
- Core dumps can be analyzed with `gdb`, `volatility`, or `strings` to extract credentials, keys, or exploit artifacts
- Under GDPR/HIPAA, unprotected core dumps containing PII or PHI can constitute a **data breach requiring notification**

## Related concepts
[[memory forensics]] [[buffer overflow]] [[process injection]] [[privilege escalation]] [[heap spraying]]