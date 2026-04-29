# DLL hijacking

## What it is
Imagine a restaurant where waiters grab ingredients from the nearest shelf without checking the label — if you put a poisoned jar in a closer spot, they'll use yours instead of the real one. DLL hijacking exploits the Windows DLL search order, where a malicious `.dll` file placed in a higher-priority directory gets loaded by a legitimate application instead of the intended library. The attacker's code runs with whatever privileges the host process has.

## Why it matters
In the 2020 SolarWinds supply chain attack, attackers used DLL sideloading (a close cousin) to inject malicious code into the legitimate Orion software update process, compromising thousands of organizations. Defenders counter this by enabling **SafeDllSearchMode**, restricting write permissions to application directories, and monitoring for unsigned DLLs loaded by trusted processes.

## Key facts
- Windows default DLL search order: application directory → System32 → System → Windows → current directory → PATH directories (SafeDllSearchMode moves current directory lower)
- **DLL sideloading** is a variant where a legitimate signed executable is placed alongside a malicious DLL with the expected name, abusing trusted process identity
- Attackers frequently target applications in `C:\Program Files` that load DLLs without full paths and run with elevated privileges
- Detection signature: a `.dll` in an unusual location (e.g., user-writable `%TEMP%` or desktop) loaded by a SYSTEM-privileged process
- Tools like **Process Monitor (Procmon)** reveal `NAME NOT FOUND` DLL lookup failures — these are the exact gaps attackers hunt for
- MITRE ATT&CK classifies this under **T1574.001** (Hijack Execution Flow: DLL Search Order Hijacking)

## Related concepts
[[privilege escalation]] [[DLL sideloading]] [[Windows search order]] [[process injection]] [[living off the land]]