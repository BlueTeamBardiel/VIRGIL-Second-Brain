# Windows Defender

## What it is
Think of it as a built-in immune system that ships with every Windows installation — already running before you even think to install anything else. Windows Defender (now marketed as **Microsoft Defender Antivirus**) is Microsoft's native endpoint protection platform that provides real-time antimalware scanning, behavioral analysis, and cloud-based threat intelligence integrated directly into Windows 10/11 and Windows Server environments.

## Why it matters
In the 2021 ransomware wave targeting healthcare networks, attackers specifically used the `MpCmdRun.exe` utility — a legitimate Windows Defender binary — to download Cobalt Strike payloads, a technique called **Living off the Land (LotL)**. This demonstrates that defenders must monitor Defender's own processes, not just trust them; even the guard can be weaponized.

## Key facts
- Windows Defender uses **AMSI (Antimalware Scan Interface)** to inspect scripts (PowerShell, VBScript, JScript) at runtime, catching fileless malware that never touches disk
- Managed via **Group Policy, Intune, or Microsoft Defender for Endpoint** in enterprise environments — understanding this is critical for CySA+ configuration scenarios
- **Tamper Protection** prevents unauthorized changes to Defender settings, even by local admins — attackers must disable it via specific API calls or boot into safe mode
- Cloud-delivered protection uses **Microsoft Active Protection Service (MAPS)** to submit suspicious samples and receive near-real-time signature updates
- Defender logs are stored in **Event Viewer under Applications and Services Logs → Microsoft → Windows → Windows Defender**, key for incident response and SIEM integration

## Related concepts
[[Endpoint Detection and Response (EDR)]] [[AMSI (Antimalware Scan Interface)]] [[Living off the Land Attacks]] [[Microsoft Defender for Endpoint]] [[Security Information and Event Management (SIEM)]]