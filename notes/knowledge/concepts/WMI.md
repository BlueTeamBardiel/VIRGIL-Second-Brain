# WMI

## What it is
Think of WMI as the nervous system of a Windows machine — it lets administrators query and control virtually every organ (process, service, hardware, network setting) from one central interface. Windows Management Instrumentation is a built-in Windows subsystem that provides a standardized API for querying system information and executing management tasks locally or remotely over the network.

## Why it matters
APT groups like APT29 (Cozy Bear) weaponized WMI for fileless lateral movement — using `wmic.exe` to remotely spawn processes on target hosts and storing persistent backdoors as WMI event subscriptions that survive reboots without writing a single file to disk. Defenders hunting for this look for suspicious `WmiPrvSE.exe` child processes and audit WMI subscription repositories using `Get-WMIObject -Namespace root\subscription`.

## Key facts
- **WMI runs as a service** (`winmgmt`) and communicates over DCOM/RPC (port 135 + dynamic high ports), making it a common firewall bypass vector
- **Three subscription components** enable persistence: Event Filter (trigger), Event Consumer (action), and Filter-to-Consumer Binding — all stored in the WMI repository (`%SystemRoot%\System32\wbem\Repository`)
- **WMIC is deprecated** in Windows 11+ but PowerShell's `Get-WmiObject` and `Invoke-WmiMethod` are functional equivalents still heavily abused
- **LOLBin status**: WMI abuse is "living off the land" — no malware dropped, making EDR and AV detection significantly harder
- **MITRE ATT&CK mapping**: T1047 (WMI execution) and T1546.003 (WMI Event Subscription persistence) are both tracked techniques

## Related concepts
[[Living Off the Land (LOLBins)]] [[Lateral Movement]] [[Fileless Malware]] [[DCOM]] [[Persistence Mechanisms]]