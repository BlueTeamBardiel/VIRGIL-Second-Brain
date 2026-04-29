# Virtualization Detection

## What it is
Like a prisoner tapping the walls of their cell to find hollow spots, malware "taps" its environment to detect if it's running inside a virtual machine rather than real hardware. Virtualization detection is a set of techniques used by software — often malicious — to determine whether it is executing inside a hypervisor, sandbox, or emulated environment, so it can alter or suppress its behavior to evade analysis.

## Why it matters
Ransomware families like Conti and Maze actively check for VM artifacts before detonating their payloads — if a sandbox is detected, the malware simply exits cleanly, producing no observable malicious behavior and defeating automated analysis. Analysts must configure "bare-metal" analysis environments or deliberately falsify VM artifacts to trick malware into revealing its true behavior.

## Key facts
- **Registry artifacts**: VMware leaves detectable keys such as `HKLM\SOFTWARE\VMware, Inc.\VMware Tools`; malware queries these to confirm virtualization.
- **CPUID instruction**: Hypervisors set bit 31 of the ECX register when the `CPUID` leaf 1 is called — a one-instruction VM check available to any user-mode process.
- **Timing attacks**: Instructions like `RDTSC` execute significantly faster on bare metal than in a VM; large timing deltas betray emulation overhead.
- **MAC address prefixes**: VMware NICs use `00:0C:29`, VirtualBox uses `08:00:27` — trivially detectable without elevated privileges.
- **Process/file artifacts**: Presence of `vmtoolsd.exe`, `vboxservice.exe`, or `vmsrvc.exe` in the process list is a reliable VM indicator checked by many malware families.

## Related concepts
[[Sandbox Evasion]] [[Anti-Analysis Techniques]] [[Dynamic Malware Analysis]]