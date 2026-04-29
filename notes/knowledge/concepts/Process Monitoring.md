# process monitoring

## What it is
Like a night-shift security guard checking every employee badge and logging who enters which room at what time, process monitoring continuously tracks what programs are running on a system, what resources they consume, and what actions they take. It is the real-time or logged observation of running processes — including parent-child relationships, memory usage, network connections spawned, and file system interactions — to detect anomalous or malicious behavior.

## Why it matters
During a living-off-the-land attack, an adversary abuses legitimate Windows binaries like `powershell.exe` or `wmic.exe` to avoid dropping malware. Process monitoring catches this by flagging unusual parent-child relationships — such as `Word.exe` spawning `cmd.exe` — which is a canonical indicator of a macro-based phishing payload executing. Without process monitoring, this activity is effectively invisible to signature-based antivirus.

## Key facts
- **Process hollowing** is detected through process monitoring by identifying discrepancies between a process's image path on disk and its actual memory contents (e.g., `svchost.exe` running from `C:\Temp`).
- Tools like **Sysmon** (Event ID 1 for process creation) and **EDR platforms** log process creation with full command-line arguments, enabling forensic reconstruction of attack chains.
- The **MITRE ATT&CK technique T1057** (Process Discovery) describes how attackers enumerate running processes to identify security tools to kill or targets to inject into.
- Baseline comparison is critical — alerting on processes that deviate from an approved software list (application whitelisting) reduces noise significantly.
- **CySA+ exam tip:** Process monitoring is a core function of behavioral analysis and is categorized under continuous security monitoring within the NIST Cybersecurity Framework (Detect function).

## Related concepts
[[endpoint detection and response]] [[Sysmon]] [[MITRE ATT&CK]] [[process injection]] [[behavioral analysis]]