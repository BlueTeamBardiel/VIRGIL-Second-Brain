# HP System Optimizer

## What it is
Like a janitor with master keys who turns out to be working for a rival company, HP System Optimizer is a pre-installed software utility on HP devices designed to tune performance — but which has been found to contain privilege escalation vulnerabilities that attackers can weaponize. It is a bloatware/OEM tool that ships with HP consumer and enterprise hardware, intended to manage system resources, updates, and performance settings, but has been repeatedly flagged for insecure implementations that allow local privilege escalation.

## Why it matters
In 2021, security researchers discovered that HP System Optimizer contained a DLL hijacking vulnerability (CVE-2021-3437) allowing a low-privileged local user to drop a malicious DLL into a directory the service searched, causing it to execute attacker-controlled code with SYSTEM-level privileges. This is a classic supply-chain/OEM attack surface: the vulnerability ships pre-installed on millions of devices, meaning enterprise defenders must inventory and patch third-party OEM tools just as rigorously as OS components.

## Key facts
- **CVE-2021-3437** is the key vulnerability identifier — a local privilege escalation via DLL hijacking in HP System Optimizer.
- The attack requires **local access only**, making it relevant in post-exploitation lateral movement and insider threat scenarios.
- **DLL hijacking** occurs when a service searches an uncontrolled directory for a library before a legitimate one — a writable path equals code execution.
- Classified under **CWE-427** (Uncontrolled Search Path Element), this is a recurring pattern in OEM/bloatware software.
- Mitigation involves **removing or updating** the software, restricting write permissions on affected directories, and applying HP's security advisory patches.

## Related concepts
[[DLL Hijacking]] [[Privilege Escalation]] [[Supply Chain Security]] [[Bloatware Attack Surface]] [[CWE-427]]