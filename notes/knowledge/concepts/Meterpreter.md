# Meterpreter

## What it is
Think of it as a master key that doesn't just open a lock — it becomes the lock, living entirely in memory and leaving no footprints on the floor. Meterpreter is an advanced, dynamically extensible payload used within the Metasploit Framework that runs entirely in RAM on the victim's machine, communicating with the attacker over an encrypted channel without writing files to disk.

## Why it matters
During a red team engagement, an attacker exploits a vulnerability to land a Meterpreter shell on a Windows workstation. Because it runs in-memory and never touches the filesystem, signature-based antivirus tools frequently miss it entirely — the attacker can then pivot to internal network segments, dump credential hashes with `hashdump`, and escalate privileges before defenders even detect the intrusion.

## Key facts
- **Fileless execution**: Meterpreter runs entirely in the memory space of a compromised process (e.g., `explorer.exe`), making disk-based forensic recovery extremely difficult.
- **Encrypted communications**: Traffic between attacker and victim is encrypted over TLS/SSL, evading basic network-level signature detection.
- **Extensible via modules**: Attackers can dynamically load additional modules post-exploitation (keyloggers, webcam capture, privilege escalation scripts) without launching new executables.
- **Common transports**: Supports `reverse_tcp`, `reverse_https`, and `bind_tcp` connection types — `reverse_https` is hardest to detect because it blends with normal web traffic.
- **Detection approaches**: Defenders hunt for it using memory forensics tools (Volatility), anomalous process injection indicators, and behavioral EDR rules watching for unusual `svchost.exe` or `explorer.exe` network connections.

## Related concepts
[[Metasploit Framework]] [[Post-Exploitation]] [[Process Injection]] [[Fileless Malware]] [[Lateral Movement]]