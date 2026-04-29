# MITRE ATT&CK technique T1055

## What it is
Like a puppeteer slipping their hand inside a legitimate marionette to make it dance, Process Injection is when an attacker inserts malicious code into a running, trusted process. This forces legitimate software — like explorer.exe or svchost.exe — to execute the attacker's payload while appearing completely normal to security tools.

## Why it matters
During the 2020 SolarWinds supply chain attack, SUNBURST malware used process injection to execute within the Orion software process itself, inheriting its trusted network permissions and evading endpoint detection that whitelisted Orion activity. Defenders must look for anomalous memory allocations and cross-process API calls rather than relying solely on process names or signatures.

## Key facts
- **Sub-techniques include**: DLL Injection (T1055.001), Process Hollowing (T1055.012), Thread Execution Hijacking (T1055.003), and Portable Executable Injection — each using different Windows APIs
- **Common API calls** that signal injection: `VirtualAllocEx`, `WriteProcessMemory`, `CreateRemoteThread`, and `NtQueueApcThread` — these are high-confidence IOCs
- **Defense evasion + privilege escalation**: T1055 serves dual purposes — it hides malicious execution AND can inherit elevated privileges from the target process
- **Process Hollowing** specifically spawns a legitimate process in a suspended state, replaces its memory with malicious code, then resumes it — making it nearly invisible to casual inspection
- **Detection approach**: Behavioral monitoring via EDR tools (e.g., CrowdStrike, SentinelOne) flagging unusual parent-child process relationships and unexpected memory region permissions (RWX pages)

## Related concepts
[[Defense Evasion]] [[DLL Hijacking]] [[Process Hollowing]] [[Privilege Escalation]] [[EDR Detection]]