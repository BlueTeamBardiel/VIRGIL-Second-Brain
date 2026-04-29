# DameWare Mini Remote Control

## What it is
Like a master key that lets a locksmith open any door in a building from a single control panel, DameWare Mini Remote Control (MRC) is a commercial Windows remote desktop administration tool by SolarWinds that allows IT administrators to remotely view, control, and troubleshoot endpoints across a network without requiring the end user to initiate the session.

## Why it matters
In 2019, a critical vulnerability (CVE-2019-3980) was discovered in the DameWare Mini Remote Control client that allowed unauthenticated remote code execution — attackers could send a specially crafted packet to the DameWare listening service (default port 6129) and execute arbitrary code with SYSTEM-level privileges. This made any unpatched DameWare deployment a direct pivot point for lateral movement and full domain compromise.

## Key facts
- Default listening port is **TCP 6129**; network defenders should flag unexpected traffic on this port as a potential indicator of compromise or unauthorized remote access
- Requires the **DameWare Mini Remote Control Service** to be installed on target hosts, which runs as a Windows service and can be deployed remotely by administrators
- CVE-2019-3980 earned a **CVSS score of 9.8 (Critical)** — unauthenticated RCE via a heap overflow in the client agent service
- Legitimate use by IT teams makes it a **living-off-the-land (LotL)** style attack vector; threat actors abuse pre-installed instances to blend with normal admin traffic and evade detection
- Commonly flagged in **threat hunting** scenarios: unexpected DameWare service installation or port 6129 activity on non-admin workstations warrants immediate investigation

## Related concepts
[[Remote Desktop Protocol (RDP)]] [[Living off the Land (LotL)]] [[Lateral Movement]] [[CVE and CVSS Scoring]] [[Privilege Escalation]]