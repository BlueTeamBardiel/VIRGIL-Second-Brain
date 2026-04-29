# MITRE ATT&CK T1059.006

## What it is
Like a janitor using the building's own master key to unlock every room, attackers use Python — a language already trusted by the operating system — to execute malicious code without raising obvious alarms. T1059.006 describes adversary use of Python interpreters to run scripts, execute shellcode, or spawn processes as part of an attack chain.

## Why it matters
During the 2020 SolarWinds campaign, attackers leveraged Python scripts on compromised Linux systems to establish persistence and move laterally, exploiting the fact that Python was legitimately installed and its traffic blended with normal developer activity. Defenders who monitor only `.exe` execution on Windows often miss Python-based attacks entirely on multi-platform environments.

## Key facts
- Python's `subprocess`, `os.system()`, and `ctypes` modules are frequently abused to execute shell commands, load shellcode, or call native OS APIs directly from a script
- Attackers commonly use Python's built-in `base64` and `exec()` functions to decode and run obfuscated payloads in memory, evading file-based AV scanning
- On macOS and Linux, Python 2 was pre-installed by default until recent OS versions, making it a reliable living-off-the-land binary (LOLBin) equivalent
- Detection focus: monitor for `python.exe` or `python3` spawning unusual child processes, network connections, or writing files to sensitive directories
- This technique falls under the broader **Command and Scripting Interpreter** category (T1059), which is consistently one of the top techniques observed in real-world intrusions per MITRE ATT&CK telemetry

## Related concepts
[[T1059 Command and Scripting Interpreter]] [[Living Off the Land Binaries (LOLBins)]] [[T1027 Obfuscated Files or Information]] [[Process Injection]] [[T1059.007 JavaScript]]