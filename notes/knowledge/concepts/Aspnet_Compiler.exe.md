# Aspnet_Compiler.exe

## What it is
Like a chef pre-cooking meals before the restaurant opens so customers aren't waiting, `aspnet_compiler.exe` pre-compiles ASP.NET web applications before deployment rather than compiling them on first user request. It is a legitimate Microsoft .NET Framework utility located in `C:\Windows\Microsoft.NET\Framework\[version]\aspnet_compiler.exe` that converts ASP.NET source files into deployable compiled assemblies.

## Why it matters
Attackers abuse `aspnet_compiler.exe` as a Living-off-the-Land Binary (LOLBin) to compile and execute malicious code while evading endpoint detection tools that whitelist trusted Microsoft binaries. A threat actor with initial access to a Windows server could invoke it to compile a web shell or malicious .NET payload, making the execution appear as routine web application maintenance in process logs — a technique observed in post-exploitation frameworks targeting IIS environments.

## Key facts
- **LOLBin classification**: Listed in the LOLBAS project; can be used to compile arbitrary .NET code disguised as legitimate ASP.NET compilation activity.
- **Default locations**: `C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_compiler.exe` and the 64-bit `Framework64` equivalent.
- **Execution signature**: Spawning `aspnet_compiler.exe` from unusual parent processes (e.g., `cmd.exe`, `powershell.exe`, or `wscript.exe`) is a high-fidelity detection signal for SOC analysts.
- **MITRE ATT&CK mapping**: Aligns with T1127 (Trusted Developer Utilities Proxy Execution) under the Defense Evasion tactic.
- **Output artifact**: Produces `.dll` files in a specified target directory — analysts should inspect unexpected output directories for unsigned or anomalous assemblies post-incident.

## Related concepts
[[Living-off-the-Land Binaries (LOLBins)]] [[MITRE ATT&CK T1127]] [[Web Shells]] [[Defense Evasion]] [[Process Injection]]