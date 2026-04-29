# Mitre ATT&CK T1500

## What it is
Like a spy learning the local language before crossing the border, an attacker compiles malicious code *directly on the victim's machine* to blend in and avoid detection. T1500 (Compile After Delivery) describes the technique where adversaries deliver source code or scripts to a target system and use native compilers (like GCC, MSBuild, or csc.exe) already present on the host to build the final executable payload locally.

## Why it matters
During the Carbanak campaigns, attackers used legitimate Windows build tools to compile payloads on compromised hosts, circumventing perimeter defenses that scan for known malicious binaries. Because the delivered artifact is source code — not a recognized executable — traditional signature-based AV and email filters often miss it entirely, making detection dependent on behavioral monitoring of compiler activity.

## Key facts
- T1500 is classified under the **Defense Evasion** tactic in the ATT&CK framework, not initial access
- Attackers leverage **Living Off the Land** compilers: `csc.exe` (C#), `msbuild.exe`, `vbc.exe`, and `jsc.exe` on Windows; `gcc`/`g++` on Linux
- The source code payload itself is often benign-looking until compiled — evading static file analysis
- Detection relies on **process monitoring**: flagging unusual parent-child relationships like `winword.exe` spawning `csc.exe`
- MSBuild specifically can execute inline C# tasks from a `.csproj` XML file, enabling **fileless-style** execution even without writing a traditional `.exe`

## Related concepts
[[Living Off the Land Binaries (LOLBins)]] [[Defense Evasion]] [[MSBuild Abuse]] [[Process Monitoring]] [[Trusted Developer Utilities]]