# BITS Jobs

## What it is
Like a postal worker who quietly delivers packages in the background without interrupting your workday, BITS (Background Intelligent Transfer Service) is a Windows component that transfers files using idle network bandwidth. It is a legitimate Windows service used by Windows Update and other system tools to download or upload files asynchronously without disrupting the user experience.

## Why it matters
Attackers abuse BITS jobs as a persistence mechanism — they can create a hidden BITS job that downloads malware from a remote server and re-executes it every time the system reboots, all while blending into normal Windows traffic. In the wild, malware families like Stuxnet and various APT toolkits have leveraged BITS jobs precisely because they survive reboots, bypass many endpoint controls, and generate network traffic that looks indistinguishable from legitimate Windows Update activity.

## Key facts
- BITS jobs persist across reboots and are stored in a queue managed by the BITS service (`qmgr.dat`), making them a stealthy persistence technique (MITRE ATT&CK T1197)
- Jobs can be created and managed via `bitsadmin.exe` (legacy) or PowerShell's `Start-BitsTransfer` cmdlet
- BITS transfers use HTTP/HTTPS, making them difficult to distinguish from normal web traffic without deep inspection
- Defenders can enumerate active BITS jobs using `bitsadmin /list /allusers /verbose` or `Get-BitsTransfer -AllUsers` in PowerShell
- BITS jobs can execute arbitrary commands upon job completion via notification callbacks, enabling code execution, not just file delivery

## Related concepts
[[Living off the Land (LotL)]] [[Persistence Mechanisms]] [[Windows Scheduled Tasks]] [[LOLBins]] [[T1197 BITS Jobs]]