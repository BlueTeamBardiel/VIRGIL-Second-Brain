# Timing and Performance

## What it is
Like a safecracker who listens for the faint click of tumblers falling into place, timing attacks exploit *how long* an operation takes rather than what it returns. Timing and performance in security refers to the measurable time differences in system operations that can leak sensitive information, or conversely, the practice of monitoring performance baselines to detect anomalies indicating an attack.

## Why it matters
In 2018, the Meltdown and Spectre vulnerabilities weaponized CPU cache timing: attackers measured nanosecond differences in memory access times to read kernel memory from unprivileged user space. Defenders also leverage the concept inversely — EDR and SIEM tools detect ransomware by flagging abnormal I/O performance spikes caused by mass file encryption operations, catching attacks in progress before completion.

## Key facts
- **Timing side-channel attacks** exploit execution time variance in cryptographic operations (e.g., non-constant-time string comparison leaks password length bit by bit)
- **Constant-time algorithms** are the primary mitigation — operations complete in the same time regardless of input values, eliminating the timing signal
- **Cache timing attacks** (e.g., Flush+Reload) infer secret data by measuring whether a CPU cache hit or miss occurs — cache hits are ~100x faster than misses
- **Performance baselines** are a CySA+ core concept: anomalous CPU, memory, or network utilization compared to baseline indicates potential malware, DDoS, or data exfiltration
- **Race conditions** are a related timing vulnerability where the window between a security check and resource use (TOCTOU — Time-of-Check/Time-of-Use) allows privilege escalation

## Related concepts
[[Side-Channel Attacks]] [[Race Conditions]] [[Baseline Configuration]] [[Cache Poisoning]] [[Cryptographic Vulnerabilities]]