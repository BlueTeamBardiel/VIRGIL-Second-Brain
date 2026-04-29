# Sandbox Evasion

## What it is
Like a criminal who behaves perfectly during a parole hearing but resumes crime the moment supervision ends, malware detects it's being analyzed in an isolated environment and simply does nothing suspicious until it escapes to a real system. Sandbox evasion is a class of techniques malware uses to identify when it is executing inside an automated analysis environment and suppress malicious behavior to avoid detection.

## Why it matters
The Emotet banking trojan famously used sandbox evasion to frustrate security researchers — it would check for human-like mouse movement and sleep for extended periods before executing, causing automated sandboxes to time out and report "no malicious activity." This allowed Emotet to bypass enterprise email gateways that relied on dynamic analysis, enabling successful delivery to thousands of corporate targets.

## Key facts
- **Time-based evasion**: Malware calls `Sleep()` for intervals longer than the sandbox's analysis window (typically 2-5 minutes), then executes after the timer expires.
- **Environment fingerprinting**: Malware checks for sandbox artifacts — low RAM (<2GB), single CPU core, missing user files in `%APPDATA%`, or registry keys associated with VMware/VirtualBox.
- **User interaction checks**: Some samples only execute if mouse cursor movement is detected, a specific number of running processes exists, or the system uptime exceeds a threshold.
- **CPUID instruction abuse**: Malware can execute the `CPUID` instruction to detect hypervisor presence via the hypervisor bit in register ECX.
- **Countermeasure**: Security teams use "bare-metal" sandboxes (real hardware, not VMs), inject fake user activity, and extend analysis windows to defeat time-based evasion.

## Related concepts
[[Dynamic Malware Analysis]] [[Indicators of Compromise]] [[Anti-Debugging Techniques]] [[Virtualization-Based Security]] [[Behavioral Analysis]]