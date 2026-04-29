# Sandboxing and Application Isolation

## What it is
Like a quarantine room in a hospital where a patient can be examined without infecting the ward, a sandbox runs untrusted code in a walled-off environment where it can execute but cannot touch the real system. Technically, sandboxing enforces strict boundaries around a process using OS-level controls (namespaces, cgroups, syscall filtering) so that file system access, network calls, and memory are all virtualized or restricted. Application isolation extends this principle to prevent any single compromised app from pivoting laterally to others.

## Why it matters
In 2017, the Equation Group's EternalBlue exploit escaped network-layer defenses entirely — but organizations running vulnerable SMB services inside properly isolated network segments contained the blast radius of WannaCry significantly. Modern browsers use per-tab sandboxing precisely because malicious JavaScript once could escalate to full OS compromise; Chrome's renderer process runs with near-zero privileges so a successful script exploit still can't write to disk or steal credentials without a separate sandbox escape vulnerability.

## Key facts
- **Security+/CySA+ exam note:** Sandboxing is classified as a *preventive* control that enforces *least privilege* at the process level.
- Chrome, Firefox, and Adobe Reader all implement multi-process sandboxing; a renderer compromise requires a second *sandbox escape* to reach the OS.
- Mobile OSes enforce mandatory application isolation: iOS apps cannot read another app's data directory by design (DAC + MAC enforcement).
- Malware analysis environments (e.g., Cuckoo Sandbox) use sandboxing to detonate suspicious files safely and observe behavioral indicators without risking host systems.
- Containers (Docker) provide *OS-level* isolation but share the host kernel — they are NOT equivalent to full VM-based sandboxes for hostile code execution.

## Related concepts
[[Principle of Least Privilege]] [[Mandatory Access Control]] [[Virtual Machines and Hypervisors]] [[Malware Analysis Techniques]] [[Defense in Depth]]