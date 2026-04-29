# COM

## What it is
Think of COM (Component Object Model) like a universal power outlet standard — any appliance (program) built to the spec can plug in and draw power (functionality) from any other compliant device, regardless of brand. COM is a Microsoft binary interface standard that allows software components to communicate with each other in a language-agnostic, process-independent way, enabling reusable objects across applications.

## Why it matters
Attackers abuse COM objects for **COM hijacking**, a persistence and privilege escalation technique. When Windows searches for a COM object, it checks `HKCU\Software\Classes\CLSID` *before* the system-wide `HKLM` key — so an attacker without admin rights can plant a malicious DLL in a user-controlled registry location, causing legitimate processes like Task Scheduler to silently load attacker code every time they run.

## Key facts
- COM objects are identified by globally unique identifiers called **CLSIDs** (Class Identifiers), stored in the Windows Registry
- The COM search order vulnerability (user hive before machine hive) makes hijacking possible **without elevated privileges**
- **DCOM** (Distributed COM) extends COM over a network, historically exploited by worms like MS03-026 (the RPC/DCOM vulnerability that spawned Blaster)
- COM hijacking is catalogued under **MITRE ATT&CK T1546.015** as an event-triggered execution technique
- Detection relies on monitoring registry writes to `HKCU\Software\Classes\CLSID\` and unexpected DLL loads by trusted system binaries

## Related concepts
[[DLL Hijacking]] [[Windows Registry]] [[Persistence Techniques]] [[Privilege Escalation]] [[MITRE ATT&CK]]