# reflective loading

## What it is
Imagine a magician who memorizes an entire act and performs it live without ever setting down a prop case — nothing touches the floor. Reflective loading works the same way: a malicious DLL (or PE file) is loaded entirely into memory by a custom loader embedded within the payload itself, bypassing the Windows API functions (like `LoadLibrary`) that would normally log the activity and leave artifacts on disk.

## Why it matters
The Metasploit Framework's `ReflectiveDLLInjection` technique pioneered this approach, allowing attackers to inject payloads like Meterpreter directly into a remote process's memory space without ever writing to disk. This defeats traditional antivirus solutions that scan the filesystem, making detection reliant on memory forensics and behavioral monitoring rather than signature-based tools.

## Key facts
- Reflective loading bypasses standard Windows loader APIs (`LoadLibrary`, `CreateProcess`), so no module entry appears in the Process Environment Block (PEB) module list — hiding it from basic process inspection tools.
- The payload contains its own mini-loader that manually resolves imports, maps PE sections, and applies relocations entirely in memory.
- Because no file touches disk, file-hash and file-path based detections fail completely; defenders must use tools like Volatility or live EDR memory scanning.
- Common detection strategy: look for executable memory regions (`RWX` permissions) that don't map back to a file on disk — a strong indicator of reflective injection.
- This technique is classified under MITRE ATT&CK as **T1620 – Reflective Code Loading**.

## Related concepts
[[DLL injection]] [[process hollowing]] [[living off the land]] [[MITRE ATT&CK]] [[fileless malware]]