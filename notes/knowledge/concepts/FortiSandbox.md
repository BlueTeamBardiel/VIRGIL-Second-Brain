# FortiSandbox

## What it is
Like a quarantine ward where a suspicious patient is observed for symptoms before being allowed into the hospital, FortiSandbox is an isolated execution environment that detonates suspicious files and URLs to observe their behavior before allowing them into the network. It is a Fortinet threat analysis appliance (available as hardware, virtual machine, or cloud service) that performs dynamic malware analysis by running unknown code in a controlled environment and classifying it as benign or malicious based on observed behaviors.

## Why it matters
During a spear-phishing campaign, an attacker sends a Word document with a macro that evades signature-based antivirus because no hash match exists yet. FortiSandbox opens the document in an isolated Windows VM, watches it attempt to spawn PowerShell, beacon out to a C2 server, and modify registry keys — flagging it as malicious and blocking delivery to the end user before any damage occurs.

## Key facts
- Integrates with the **Fortinet Security Fabric**, sharing threat intelligence with FortiGate, FortiMail, and FortiWeb in near real-time via automated verdict sharing
- Uses **dual-level inspection**: static analysis (file structure, strings, entropy) followed by dynamic analysis (behavioral execution in sandboxed VMs)
- Supports multiple OS environments simultaneously (Windows 7, Windows 10, Android) to catch OS-specific payloads
- Generates **detailed threat intelligence reports** including network IOCs, file changes, and process trees — directly usable for incident response
- Can detect **evasion techniques** such as sleep timers and VM-aware malware through extended observation periods and anti-evasion tooling

## Related concepts
[[Dynamic Malware Analysis]] [[Indicators of Compromise]] [[Fortinet Security Fabric]] [[Advanced Persistent Threat]] [[Detonation Chamber]]