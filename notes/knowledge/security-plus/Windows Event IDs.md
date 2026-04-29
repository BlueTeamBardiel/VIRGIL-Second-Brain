# Windows Event IDs

## What it is
Think of Windows Event IDs as the receipt codes on a cash register tape — each numbered code tells you exactly what transaction happened, when, and who initiated it. Windows Event IDs are unique numeric identifiers assigned to specific system, security, and application events logged by the Windows Event Log service, enabling administrators and analysts to systematically query and correlate activity across endpoints.

## Why it matters
During a credential-stuffing attack, an analyst hunting for brute-force attempts queries the Security Event Log for a spike in Event ID 4625 (failed logon) followed by a single 4624 (successful logon) — the classic "many fails, one win" pattern that signals account compromise. Without knowing these specific IDs, hunting that attack in SIEM tools like Splunk or Microsoft Sentinel becomes guesswork instead of precision surgery.

## Key facts
- **4624** – Successful logon; records account name, logon type, and source IP — baseline for authentication auditing
- **4625** – Failed logon; high volume from a single source = brute force; distributed low-volume = password spray
- **4688** – New process created; critical for detecting malware execution and LOLBins (Living-Off-the-Land Binaries) like `powershell.exe` spawned by `winword.exe`
- **4720 / 4732** – User account created / added to security-enabled local group; both are key indicators of persistence tactics
- **7045** – New service installed; frequently triggered by malware establishing persistence via service creation (T1543.003 in MITRE ATT&CK)
- Event logs live in three primary channels: **Security**, **System**, and **Application**; Security channel requires audit policy to be enabled to populate

## Related concepts
[[Windows Security Auditing]] [[SIEM]] [[Threat Hunting]] [[MITRE ATT&CK]] [[Log Analysis]]