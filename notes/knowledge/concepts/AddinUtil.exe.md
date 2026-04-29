# AddinUtil.exe

## What it is
Like a loading dock worker who accepts packages from any vendor without checking credentials, AddinUtil.exe is a legitimate Microsoft .NET utility designed to install and manage add-ins for .NET applications. It is a signed Windows binary located in the .NET Framework directory that can process add-in configuration files and load external assemblies.

## Why it matters
Attackers abuse AddinUtil.exe as a Living-off-the-Land Binary (LOLBin) to proxy the execution of malicious .NET assemblies, bypassing application whitelisting controls that trust signed Microsoft binaries. Because it's a trusted, signed executable, endpoint security tools that rely on reputation-based allowlisting may permit its execution even when it's loading attacker-controlled code, effectively hiding malicious activity inside legitimate process telemetry.

## Key facts
- **LOLBin classification**: AddinUtil.exe can execute arbitrary .NET code by pointing it at attacker-crafted add-in pipeline directories, making it a defense evasion tool.
- **Location**: Typically found at `C:\Windows\Microsoft.NET\Framework\<version>\AddinUtil.exe` or the 64-bit equivalent path.
- **Bypass mechanism**: Abuses the `-AddInRoot` parameter to redirect the utility to a malicious directory containing a crafted pipeline structure with embedded DLLs.
- **Detection focus**: SOC analysts should alert on AddinUtil.exe executing from unusual parent processes (e.g., Office applications, PowerShell) or with non-standard `-AddInRoot` paths pointing outside expected .NET directories.
- **Signed binary trust**: Its Microsoft digital signature means hash-based blocking is ineffective — behavioral detection and command-line argument monitoring are required countermeasures.

## Related concepts
[[Living-off-the-Land Binaries (LOLBins)]] [[Application Whitelisting Bypass]] [[.NET Assembly Loading]] [[Defense Evasion (MITRE ATT&CK T1218)]] [[Process Argument Monitoring]]