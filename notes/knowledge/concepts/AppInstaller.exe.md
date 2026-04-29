# AppInstaller.exe

## What it is
Think of it like a valet who accepts a package slip from anywhere — a website, an email link, a network share — and installs what's inside without asking many questions. AppInstaller.exe is a legitimate Windows binary (introduced in Windows 10) that handles `.appinstaller` and `.msix`/`.appx` package files, allowing applications to be installed via URL-based schemes (`ms-appinstaller://`).

## Why it matters
Threat actors abused the `ms-appinstaller` URI scheme to deliver malware directly from attacker-controlled web servers — bypassing Mark of the Web (MotW) protections because the payload never fully touched disk as a downloaded file. Microsoft temporarily disabled the protocol handler in February 2023 after observing groups like Storm-0569 using it to distribute ransomware loaders disguised as legitimate software (e.g., fake Adobe or Zoom installers). Defenders should monitor for unusual AppInstaller.exe process spawns, especially those creating child processes.

## Key facts
- **LOLBIN status**: AppInstaller.exe is a Living Off the Land Binary — signed by Microsoft, making it inherently trusted by many security tools
- **MotW bypass**: Packages installed via the `ms-appinstaller` handler can circumvent Zone Identifier tagging, defeating standard download warnings
- **CVE-2021-43890**: A spoofing vulnerability in AppX installer allowed malicious packages to appear as legitimate signed apps
- **Microsoft's mitigation**: The `ms-appinstaller` protocol was disabled by default in December 2022/early 2023 via Group Policy (`EnableMSAppInstallerProtocol`)
- **Detection pivot**: Child processes spawned from AppInstaller.exe (e.g., PowerShell, cmd.exe) are strong indicators of compromise and worth alerting on in SIEM rules

## Related concepts
[[Mark of the Web (MotW)]] [[Living Off the Land Binaries (LOLBins)]] [[MSIX Malware Delivery]] [[AppX Spoofing]] [[Supply Chain Attack]]