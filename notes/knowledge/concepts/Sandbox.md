# sandbox

## What it is
Like a child's sandbox where they can dig and build without tearing up the yard, a sandbox is an isolated execution environment that runs untrusted code in a contained space with no access to the real system. It enforces strict boundaries — restricted file system access, no network by default, limited system calls — so malicious behavior cannot escape into production resources.

## Why it matters
When a phishing email delivers a suspicious PDF attachment, an enterprise security team can detonate it inside a sandbox (such as Cuckoo or Any.run) and observe its full behavior — registry modifications, DNS lookups, dropped executables — without risking the corporate network. This behavioral detonation reveals zero-day malware that signature-based antivirus would miss entirely.

## Key facts
- **Sandbox evasion** is a real attacker technique: malware detects sandbox environments by checking for mouse movement, uptime, CPU core count (<2 CPUs = sandbox), or virtual machine artifacts, then stays dormant to appear benign
- Browsers like Chrome use sandboxing to isolate renderer processes from the OS — a browser exploit alone is insufficient; attackers also need a **sandbox escape** to compromise the host
- Sandboxing is a core component of **next-gen endpoint protection** and is explicitly testable on Security+/CySA+ under application whitelisting and malware analysis controls
- **Dynamic analysis** (sandbox execution) complements **static analysis** (disassembly without running) — both together provide deeper malware understanding than either alone
- Cloud sandboxes (e.g., FireEye AX, Joe Sandbox) are used in SOC workflows as part of automated SOAR playbooks for email attachment triage

## Related concepts
[[malware analysis]] [[virtual machine]] [[application whitelisting]] [[dynamic analysis]] [[threat intelligence]]