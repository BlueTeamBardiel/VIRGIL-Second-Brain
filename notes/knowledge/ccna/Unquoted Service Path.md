# Unquoted Service Path

## What it is
Like a postal worker who, given the ambiguous address "123 Oak Park Drive Suite 5," checks every partial match — knocking on "123 Oak" first, then "123 Oak Park," then the full address — Windows resolves unquoted service paths by testing each space-separated segment as a possible executable. When a Windows service's binary path contains spaces but lacks quotation marks, the OS will attempt to execute partial path segments, allowing an attacker to plant a malicious binary at an earlier resolution point.

## Why it matters
An attacker with write access to `C:\Program Files\Vulnerable App\` can drop a malicious `Vulnerable.exe` there. When the service restarts, Windows tries to execute `C:\Program\` first, then `C:\Program Files\Vulnerable.exe` — running the attacker's payload instead of the legitimate service, often under SYSTEM privileges. This is a classic local privilege escalation vector found in CTFs, OSCP labs, and real enterprise environments running legacy software.

## Key facts
- The vulnerability only triggers when the path contains **spaces** AND is **unquoted** in the service's `ImagePath` registry value (`HKLM\SYSTEM\CurrentControlSet\Services\`)
- Exploitation requires **write permission** to one of the intermediate directories — not just any directory in the path
- The planted binary must match the **partial path name** Windows constructs (e.g., `Program.exe` for `C:\Program Files\...`)
- Detection: run `wmic service get name,pathname,startmode | findstr /i /v "C:\Windows\\" | findstr /i /v """` to surface unquoted paths
- Remediation: wrap the service `ImagePath` value in double quotes in the registry or via `sc config <service> binpath= "\"C:\Full\Quoted\Path.exe\""`

## Related concepts
[[Privilege Escalation]] [[Windows Registry]] [[Service Misconfigurations]] [[DLL Hijacking]]