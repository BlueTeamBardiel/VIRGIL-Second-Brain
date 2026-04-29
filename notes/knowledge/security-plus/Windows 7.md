# Windows 7

## What it is
Like a beloved old car that still runs but no longer gets safety recalls or manufacturer support — it moves, but every new vulnerability is a permanent open wound. Windows 7 is a Microsoft desktop operating system released in October 2009 that reached End of Life (EOL) on January 14, 2020, meaning Microsoft ceased providing security patches, bug fixes, or technical support.

## Why it matters
In 2017, the WannaCry ransomware campaign devastated hospitals, banks, and infrastructure globally — with Windows 7 machines among the hardest-hit systems because many organizations had never patched MS17-010 (EternalBlue). Even after EOL, hospitals running Windows 7 on medical imaging devices continued operating unpatched systems, creating persistent footholds for attackers. This scenario appears repeatedly in CySA+ exam questions about risk management and legacy system exposure.

## Key facts
- **EOL date: January 14, 2020** — after this date, no free security patches are issued; Extended Security Updates (ESUs) were available only to enterprise customers paying premium fees through 2023
- **Market share threat**: As of several years post-EOL, Windows 7 still represented a significant percentage of global endpoints, making it a high-value target profile
- **EternalBlue (MS17-010)** exploits SMBv1, which Windows 7 runs by default — patching SMBv1 or disabling the protocol is the key compensating control
- **Compensating controls** for legacy EOL systems include: network segmentation/isolation, application whitelisting, host-based firewalls, and enhanced monitoring (SIEM alerting)
- **Security+ relevance**: Windows 7 is a textbook example of a **vulnerability introduced by EOL/legacy software** — categorized under system/application vulnerabilities in the exam objectives

## Related concepts
[[End of Life (EOL) Software]] [[EternalBlue MS17-010]] [[SMBv1 Protocol]] [[Compensating Controls]] [[WannaCry Ransomware]]