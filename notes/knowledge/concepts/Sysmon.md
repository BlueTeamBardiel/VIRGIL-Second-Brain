# Sysmon

## What it is
Think of Sysmon as a nosy neighbor with a perfect memory — it watches every process that starts, every network connection made, and every file created on a Windows machine, writing it all down in a journal no one can easily tamper with. Formally, System Monitor (Sysmon) is a free Windows system service from Microsoft Sysinternals that logs detailed telemetry to the Windows Event Log, far exceeding what native Windows auditing captures. It persists across reboots and operates as a kernel-level driver.

## Why it matters
During the SolarWinds breach, attackers used living-off-the-land techniques — spawning legitimate processes like `cmd.exe` from unusual parent processes — that standard antivirus missed entirely. Organizations with Sysmon deployed (Event ID 1: Process Creation with parent-child relationships logged) could detect that `SolarWinds.BusinessLayerHost.exe` was spawning suspicious child processes, giving defenders a forensic trail to follow during incident response.

## Key facts
- **Event ID 1** logs process creation including full command-line arguments and parent process — gold for detecting LOLBins abuse
- **Event ID 3** captures network connections with destination IP/port, enabling C2 beacon detection
- **Event ID 11** logs file creation events, useful for catching dropped malware or ransomware staging
- Sysmon uses an **XML configuration file** to define rules; community configs like SwiftOnSecurity's are widely used to reduce noise
- Logs write to `Microsoft-Windows-Sysmon/Operational` in Windows Event Log and integrate directly with **SIEM tools** like Splunk or Elastic

## Related concepts
[[Windows Event Logging]] [[SIEM]] [[Endpoint Detection and Response]] [[Living off the Land Attacks]] [[Threat Hunting]]