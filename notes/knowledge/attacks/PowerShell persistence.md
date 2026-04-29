# PowerShell persistence

## What it is
Like a sleeper agent who hides a spare key under the doormat before leaving, PowerShell persistence is the technique of embedding malicious PowerShell code into locations the OS automatically re-executes after reboot. Specifically, attackers store scripts or commands in registry run keys, scheduled tasks, WMI subscriptions, or startup folders so their payload survives system restarts without re-exploitation.

## Why it matters
In the 2020 SolarWinds attack, threat actors used PowerShell-based persistence via scheduled tasks to maintain long-term access across reboots while blending into legitimate administrative activity. Defenders hunting for this behavior rely on PowerShell Script Block Logging (Event ID 4104) and Module Logging to surface obfuscated commands that endpoint tools might otherwise miss.

## Key facts
- **Common persistence locations**: `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`, scheduled tasks (`schtasks`), WMI event subscriptions, and `$PROFILE` (user profile script auto-loaded at every PowerShell session)
- **AMSI (Antimalware Scan Interface)** intercepts PowerShell commands at runtime; attackers frequently attempt to bypass it using reflection or memory patching before planting persistence
- **Constrained Language Mode** restricts PowerShell capabilities and can prevent many persistence techniques; configured via AppLocker or WDAC policies
- **Event ID 4698** (scheduled task creation) and **4104** (script block logging) are the primary log sources for detecting PowerShell-based persistence in a SIEM
- **Living-off-the-land (LotL)** principle applies here — PowerShell is a signed, trusted binary, making its abuse difficult to detect with simple allowlist controls alone

## Related concepts
[[Registry Run Keys]] [[WMI Event Subscriptions]] [[Scheduled Tasks]] [[AMSI Bypass]] [[Living off the Land Attacks]]