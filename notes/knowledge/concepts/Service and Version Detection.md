# Service and Version Detection

## What it is
Like reading the label on a locked medicine cabinet to know exactly what's inside before deciding how to break in, service and version detection probes open ports to identify *what software* is running and *which version*. It goes beyond simply knowing a port is open — it fingerprints the application layer by analyzing banner responses and protocol behavior to produce a precise inventory like "Apache 2.4.49" or "OpenSSH 7.4."

## Why it matters
In 2021, attackers exploited Apache 2.4.49's path traversal vulnerability (CVE-2021-41773) within days of its disclosure. Service and version detection lets defenders audit their own infrastructure to confirm whether vulnerable versions are exposed — and lets attackers confirm which targets are worth pursuing before writing a single exploit.

## Key facts
- **Nmap's `-sV` flag** performs service and version detection by sending crafted probes and comparing responses against its `nmap-service-probes` database
- **Banner grabbing** is the passive subset — simply reading the text a service announces on connection (e.g., SSH or FTP banners) without active probing
- Version detection directly feeds **vulnerability mapping**: a discovered version is cross-referenced against CVE databases like NVD to find known exploits
- **Intensity levels** (0–9 in Nmap) control the aggressiveness of probing; higher intensity finds more but generates more noise and takes longer
- Services can **misrepresent themselves** through banner modification (e.g., changing Apache's `Server:` header), making passive grabbing unreliable — active fingerprinting is harder to fake

## Related concepts
[[Port Scanning]] [[Banner Grabbing]] [[Vulnerability Scanning]] [[OS Fingerprinting]] [[CVE and NVD]]