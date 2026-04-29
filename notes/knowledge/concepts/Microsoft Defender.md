# Microsoft Defender

## What it is
Think of it as a live-in security guard who already knows your building's blueprints — no installation required. Microsoft Defender is a suite of integrated security tools built into Windows, providing antivirus, endpoint detection and response (EDR), firewall management, and threat intelligence natively within the OS without requiring third-party installation.

## Why it matters
In 2021, during the widespread exploitation of the ProxyLogon Exchange vulnerability, organizations with Microsoft Defender for Endpoint deployed were able to detect lateral movement and malicious web shells automatically through behavioral analysis — hours before many third-party AV vendors pushed signatures. This demonstrates why built-in EDR capability matters: it catches *behavior*, not just known file hashes.

## Key facts
- **Defender Antivirus** uses both signature-based detection and heuristic/behavioral analysis; it's the default AV on Windows 10/11 and Windows Server 2016+
- **Defender for Endpoint (MDE)** is the enterprise EDR tier — it provides attack surface reduction (ASR) rules, device isolation, and integration with Microsoft Sentinel (SIEM)
- **Tamper Protection** prevents malicious processes or users from disabling Defender settings via registry edits or PowerShell — a critical hardening control
- **Cloud-delivered protection** sends suspicious samples to Microsoft's cloud for rapid analysis, reducing the window between zero-day discovery and detection
- On Security+/CySA+ exams, Defender maps to concepts of **endpoint protection platforms (EPP)**, **EDR**, and the **NIST Detect/Respond** functions

## Related concepts
[[Endpoint Detection and Response]] [[Attack Surface Reduction]] [[Antivirus Signatures]] [[Security Information and Event Management]] [[Behavioral Analysis]]