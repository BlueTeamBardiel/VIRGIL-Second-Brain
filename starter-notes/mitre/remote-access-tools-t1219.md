# Remote Access Tools (T1219)

Adversaries abuse legitimate remote access software to establish interactive command and control channels, using tools like [[TeamViewer]], [[AnyDesk]], and [[RDP]] for persistence and lateral movement post-compromise.

## Overview

**ATT&CK ID:** T1219  
**Tactic:** [[Command and Control]]  
**Platforms:** Linux, Windows, macOS  
**Last Modified:** 24 October 2025

Remote access tools create sessions between hosts via graphical interfaces, CLI, protocol tunnels, or hardware-level access (e.g., [[KVM]] over IP). Desktop support and remote management software allow users to control systems remotely, inheriting user/software permissions. While legitimate for troubleshooting and system administration, adversaries abuse these tools as alternate C2 channels, reverse connections, or malware components.

## Sub-techniques

- **T1219.001** — [[IDE Tunneling]]
- **T1219.002** — [[Remote Desktop Software]]
- **T1219.003** — [[Remote Access Hardware]]

## Abuse Patterns

- Post-compromise installation for redundant access
- Interactive remote desktop sessions
- Malware component for reverse/back-connections
- Persistence via installer routines (Windows Services)
- Integration in other software (e.g., [[Google Chrome]] Remote Desktop)
- Abused EDR/defensive tool remote features

## Adversary Examples

- **[[Akira]]** — Uses [[AnyDesk]], [[PuTTY]]
- **[[BlackByte]]** — Deploys [[AnyDesk]]
- **[[Carbanak]]** — [[VNC]], [[Ammyy Admin]], [[Team Viewer]]
- **[[Cobalt Group]]** — [[Ammyy Admin]], [[TeamViewer]]
- **[[DarkVishnya]]** — [[DameWare Mini Remote Control]]
- **[[FIN7]]** — [[Atera]]
- **[[GOLD SOUTHFIELD]]** — [[ConnectWise Control]]
- **[[Hildegard]]** — [[tmate]]
- **[[INC Ransom]]** — [[AnyDesk]], [[PuTTY]]
- **[[InvisibleFerret]]** — [[AnyDesk]]

## Tags

#attack #t1219 #command-and-control #lateral-movement #persistence #remote-access

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1219/_
