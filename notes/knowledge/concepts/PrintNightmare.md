# PrintNightmare

## What it is
Imagine the office janitor has a master key that lets them install anything in the building — that's exactly what Windows Print Spooler did. PrintNightmare (CVE-2021-1675 / CVE-2021-34527) is a critical vulnerability in the Windows Print Spooler service that allows attackers to execute arbitrary code with SYSTEM-level privileges by abusing how Windows loads printer drivers.

## Why it matters
In July 2021, threat actors including ransomware groups actively exploited PrintNightmare against unpatched domain controllers, escalating from low-privileged user accounts to full domain administrator control within minutes. Defenders responded by disabling the Print Spooler service on critical servers — a painful but necessary trade-off since it broke legitimate printing functionality.

## Key facts
- **CVE IDs**: CVE-2021-1675 (local privilege escalation) and CVE-2021-34527 (remote code execution) — two distinct but related flaws in the same service
- **Root cause**: The `AddPrinterDriver` RPC call failed to properly verify whether the caller had SeLoadDriverPrivilege, allowing unprivileged users to load malicious DLLs
- **Attack impact**: Achieves SYSTEM privileges locally or SYSTEM/Domain Admin remotely — the highest Windows privilege tier
- **Affected scope**: All versions of Windows from XP through Server 2019 were initially vulnerable
- **Primary mitigations**: Disable Print Spooler on non-printing servers (especially DCs), apply Microsoft's July 2021 patch, restrict Point and Print policies via Group Policy (RestrictDriverInstallationToAdministrators = 1)

## Related concepts
[[Privilege Escalation]] [[Remote Code Execution]] [[Windows Print Spooler]] [[CVE]] [[Lateral Movement]]