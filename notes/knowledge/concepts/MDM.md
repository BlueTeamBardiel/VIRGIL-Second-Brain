# MDM

## What it is
Think of MDM like a remote control for every smartphone and laptop in a company — IT can push settings, lock screens, or wipe devices without ever touching them physically. Mobile Device Management (MDM) is a centralized platform that enforces security policies, manages configurations, and controls enrolled endpoints across an organization's mobile fleet. It operates via an agent installed on each device that communicates with a management server.

## Why it matters
In 2020, attackers targeting remote workers frequently exploited personal devices that lacked MDM enrollment — these unmanaged endpoints had no forced encryption, no patch enforcement, and no remote wipe capability, making them ideal pivot points into corporate VPNs. Had MDM been deployed, security teams could have remotely wiped stolen laptops within minutes of a breach report and enforced full-disk encryption from day one.

## Key facts
- MDM can enforce **containerization** — separating corporate data from personal apps on BYOD devices, preventing data leakage between environments
- **Remote wipe** is a core MDM capability: selective wipe removes only corporate data; full wipe factory-resets the entire device
- MDM solutions use **Apple MDM Protocol**, **Android Enterprise**, or **Windows MDM/OMA-DM** protocols to communicate with enrolled devices
- Jailbroken or rooted devices can **bypass MDM controls** — a critical detection gap; compliance checks should flag these automatically
- MDM is distinct from **MAM (Mobile Application Management)**, which controls only specific apps rather than the entire device

## Related concepts
[[BYOD Policy]] [[Endpoint Detection and Response]] [[Mobile Application Management]] [[Zero Trust Architecture]] [[Data Loss Prevention]]