# MITRE ATT&CK technique T1073

## What it is
Like a counterfeit wine bottle with a legitimate label slapped over it, DLL Side-Loading tricks a trusted application into loading a malicious DLL by placing it where the app expects to find a legitimate one. Specifically, adversaries exploit how Windows applications search for and load Dynamic Link Libraries, planting a rogue DLL alongside a legitimate, signed executable so the trusted process unwittingly executes malicious code.

## Why it matters
The HijackLoader malware family and APT groups like APT41 have weaponized this technique extensively — dropping a malicious DLL next to a signed antivirus or enterprise software binary, causing security tools to effectively run the attacker's payload with elevated trust. Because the executing parent process is legitimate and signed, endpoint defenses and application whitelisting solutions often fail to flag the activity.

## Key facts
- T1073 is now deprecated in ATT&CK and folded under **T1574.002 (Hijack Execution Flow: DLL Side-Loading)** in newer framework versions
- The attack requires the adversary to know the **specific DLL name** the target application searches for at runtime
- Windows DLL search order (defined by `LoadLibrary`) determines vulnerability — applications loading DLLs from their **own directory first** are prime targets
- Unlike DLL Injection, Side-Loading does **not** require injecting into a running process — the legitimate executable loads the malicious DLL at startup
- Detection focuses on **process-DLL pairing anomalies**: a legitimate signed binary loading a DLL with an unexpected hash or path is a high-fidelity indicator

## Related concepts
[[DLL Hijacking]] [[T1574 Hijack Execution Flow]] [[Application Whitelisting Bypass]] [[Process Hollowing]] [[Living off the Land Binaries]]