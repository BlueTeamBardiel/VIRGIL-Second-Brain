# System Binary Proxy Execution

## What it is
Like a criminal using a licensed taxi driver to transport stolen goods — the cargo is illegal, but the vehicle is perfectly legitimate. System Binary Proxy Execution is a technique where attackers abuse trusted, signed OS binaries (like `mshta.exe`, `rundll32.exe`, or `certutil.exe`) to execute malicious payloads, effectively laundering their code through a trusted process.

## Why it matters
During the SolarWinds attack, threat actors used `rundll32.exe` to execute malicious DLLs, bypassing application whitelisting controls that would have blocked unknown executables. Defenders who only monitor for unsigned or unknown processes will miss this entirely — detection requires behavioral analysis of *what* the trusted binary is doing, not just *that* it's running.

## Key facts
- **MITRE ATT&CK T1218** covers Signed Binary Proxy Execution; sub-techniques include `mshta`, `rundll32`, `regsvr32`, `certutil`, `msiexec`, and others
- `certutil.exe` is a certificate management tool that can also download files from the internet (`certutil -urlcache -split -f`), making it a popular LOLBin for staging payloads
- `regsvr32.exe` can execute remote COM scriptlets via HTTP without writing to disk — known as the "Squiblydoo" technique
- These tools are called **LOLBins** (Living Off the Land Binaries) — legitimate binaries repurposed for malicious activity
- Detection strategy focuses on **parent-child process anomalies** (e.g., `Word.exe` spawning `mshta.exe`) and **command-line argument auditing** via Sysmon Event ID 1

## Related concepts
[[Living Off the Land (LOLBins)]] [[Application Whitelisting Bypass]] [[Defense Evasion]] [[Process Injection]] [[Signed Binary Execution]]