# Mitre ATT&CK T1203

## What it is
Like a hitman hiding inside a birthday cake delivered to your office, this technique exploits vulnerabilities in client-side software to execute malicious code the moment a user opens a booby-trapped file or webpage. T1203 (Exploitation for Client Execution) describes adversaries leveraging unpatched flaws in applications like browsers, Office suites, or PDF readers to gain code execution on a target system without any direct server compromise.

## Why it matters
In 2021, threat actors distributed malicious RTF documents exploiting CVE-2017-11882 (Microsoft Equation Editor) — a four-year-old vulnerability — in phishing campaigns targeting government organizations. Users simply opened what appeared to be a legitimate document, and shellcode executed silently in the background, establishing a beachhead for follow-on activity. Patching client applications aggressively and deploying exploit mitigation technologies (ASLR, DEP, sandboxing) directly counters this technique.

## Key facts
- **Trigger mechanism**: Exploitation occurs when a user interacts with malicious content — opening a file, visiting a URL, or previewing an attachment; no user credentials required
- **Common targets**: Web browsers (Chrome, IE), Microsoft Office, Adobe Acrobat/Reader, and media players are historically high-value exploitation surfaces
- **Mitigation stack**: Application sandboxing, EMET/Windows Exploit Guard, attack surface reduction (ASR) rules, and strict patching cadence are primary defenses
- **Sub-technique distinction**: T1203 is a parent technique under the **Execution** tactic; it differs from T1190 (Exploit Public-Facing Application), which targets servers rather than end-user clients
- **Detection signals**: Process trees showing Office or browser spawning unexpected child processes (e.g., `winword.exe` → `cmd.exe`) are strong indicators of exploitation

## Related concepts
[[T1190 Exploit Public-Facing Application]] [[Spearphishing Attachment T1566.001]] [[Exploit Mitigation DEP ASLR]] [[Execution Tactic ATT&CK]] [[CVE Patch Management]]