# System Binary Proxy Execution

Adversaries bypass process and signature-based defenses by proxying malicious execution through signed, trusted binaries—often Microsoft-signed files native to Windows, Linux, or macOS. This technique exploits the inherent trust placed in legitimate system tools.

## Overview

**Tactic:** Defense Evasion
**Platforms:** Linux, Windows, macOS
**ID:** T1218
**Last Modified:** 24 October 2025

Microsoft-signed binaries and other trusted system tools can be abused to execute arbitrary code while evading security controls that trust their digital signatures. Linux adversaries similarly abuse trusted binaries like `split`.

## Sub-Techniques (14)

- [[T1218.001]] — Compiled HTML File
- [[T1218.002]] — Control Panel
- [[T1218.003]] — CMSTP
- [[T1218.004]] — InstallUtil
- [[T1218.005]] — Mshta
- [[T1218.007]] — Msiexec
- [[T1218.008]] — Odbcconf
- [[T1218.009]] — Regsvcs/Regasm
- [[T1218.010]] — Regsvr32
- [[T1218.011]] — Rundll32
- [[T1218.012]] — Verclsid
- [[T1218.013]] — Mavinject
- [[T1218.014]] — MMC
- [[T1218.015]] — Electron Applications

## Procedure Examples

| Group | Description |
|-------|-------------|
| [[Lazarus Group]] | Abused Windows Update Client (`wuauclt.exe`) via LNK files to execute malicious DLLs for persistence. |
| [[Volt Typhoon]] | Leveraged native "LOLBins" (Living Off The Land binaries) to maintain and expand access to victim networks. |

## Mitigations

- **M1042 — Disable or Remove Feature or Program:** Remove unnecessary native binaries from the environment.
- **M1038 — Execution Prevention:** Use application control to block execution of vulnerable binaries not required by the system.
- **M1050 — Exploit Protection:** Deploy Microsoft EMET Attack Surface Reduction (ASR) to block trusted binary bypass methods.
- **M1037 — Filter Network Traffic:** Configure network appliances and endpoint software for protocol-based filtering.
- **M1026 — Privileged Account Management:** Restrict vulnerable binary execution to privileged accounts only.
- **M1021 — Restrict Web-Based Content:** Block risky downloads, scripts, and browser extensions.

## Detection

**Detection Strategy:** DET0081 — Detection of Proxy Execution via Trusted Signed Binaries Across Platforms (AN0226)

## Tags

#attack-mitre #defense-evasion #living-off-the-land #lolbins #binary-proxy #windows #linux #macos

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1218/_
