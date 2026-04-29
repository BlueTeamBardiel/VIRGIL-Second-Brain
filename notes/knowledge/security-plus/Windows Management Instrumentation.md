# Windows Management Instrumentation

## What it is
Think of WMI as the nervous system of a Windows machine — every organ (process, service, hardware component) sends signals through it, and anyone with access to the nervous system can both *read* the body's state and *send commands* to it. Precisely: WMI is Microsoft's implementation of the WBEM standard, providing a unified interface for querying and managing Windows system components locally or remotely via DCOM/RPC on port 135.

## Why it matters
APT groups like APT29 heavily abuse WMI for lateral movement and persistence — specifically using `wmic /node:<target>` to execute processes remotely without dropping traditional executables, and installing **WMI event subscriptions** (permanent event consumers) that survive reboots and trigger malicious payloads invisibly. Defenders hunt for this by monitoring `WMIActivityLog`, `Microsoft-Windows-WMI-Activity/Operational` event logs, and watching for `scrcons.exe` or `mofcomp.exe` spawning unexpected child processes.

## Key facts
- **Three persistence components**: Event Filter (trigger condition) + Event Consumer (action) + Filter-to-Consumer Binding — all three must exist together for a persistent WMI subscription
- WMI executes through `svchost.exe` hosting the `winmgmt` service; legitimate WMI activity looks nearly identical to malicious use, making it a **Living off the Land (LotL)** technique
- Remote WMI requires **DCOM** over port 135 + dynamic high ports; blocking these limits lateral movement
- MITRE ATT&CK maps WMI to **T1047** (WMI execution) and **T1546.003** (WMI event subscription persistence)
- PowerShell cmdlets (`Get-WMIObject`, `Invoke-WMIMethod`) are modern alternatives; both generate the same underlying WMI traffic and should be equally scrutinized

## Related concepts
[[Living off the Land Binaries]] [[Lateral Movement]] [[DCOM Abuse]] [[Persistence Mechanisms]] [[Windows Event Logging]]