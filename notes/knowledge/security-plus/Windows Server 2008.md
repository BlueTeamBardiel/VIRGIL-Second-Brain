# Windows Server 2008

## What it is
Like a aging apartment building whose master keys still work but the locks haven't been changed in years — Windows Server 2008 is a Microsoft server operating system released in 2008 that reached end-of-life (EOL) in January 2020, meaning it no longer receives security patches or vendor support.

## Why it matters
Organizations still running Windows Server 2008 became prime targets after EOL, since every newly discovered vulnerability remains permanently unpatched. The EternalBlue exploit (MS17-010), originally weaponized by WannaCry ransomware in 2017, devastated unpatched Server 2008 environments and continues to threaten any surviving instances today — making legacy OS identification a critical step in vulnerability management programs.

## Key facts
- Reached **End of Life on January 14, 2020** — no free security updates after this date (Extended Security Updates available for Azure-hosted instances only)
- Runs **Server Message Block (SMB) v1** by default, the exact protocol vector exploited by EternalBlue/WannaCry and NotPetya
- Supports a maximum of **32 processor sockets** and introduced **Hyper-V** virtualization natively for the first time
- On the **CVE scoring system**, any critical vulnerability discovered post-EOL will never receive a CVSS-patched remediation from Microsoft, making compensating controls mandatory
- CySA+ and Security+ exam contexts: Server 2008 is a textbook example of **unsupported systems risk** and triggers findings in vulnerability scans (Nessus/Tenable flags EOL OS as critical severity)

## Related concepts
[[End-of-Life Software]] [[EternalBlue (MS17-010)]] [[SMBv1 Protocol]] [[Vulnerability Management]] [[Legacy System Risk]]