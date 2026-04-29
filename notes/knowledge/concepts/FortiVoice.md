# FortiVoice

## What it is
Think of it as a security-hardened telephone switchboard operator built into Fortinet's ecosystem — it handles call routing, voicemail, and conferencing while sitting inside a monitored network perimeter. FortiVoice is Fortinet's unified communications (UC) platform, providing enterprise VoIP PBX functionality tightly integrated with the FortiGate firewall and FortiOS security fabric. It runs as both hardware appliances and virtual machines, managing voice infrastructure alongside network security controls.

## Why it matters
In May 2025, Fortinet disclosed that threat actors actively exploited a zero-day vulnerability in FortiVoice (CVE-2025-32756, a stack-based buffer overflow) to achieve remote code execution and deploy credential-harvesting malware. Attackers enabled system call logging on the devices to capture admin credentials, demonstrating that voice infrastructure — often overlooked in patch cycles — is a high-value pivot point into enterprise networks. This breach pattern highlights how unified communications appliances can serve as quiet entry doors when security teams focus patching efforts primarily on firewalls and endpoints.

## Key facts
- FortiVoice runs on FortiOS, meaning vulnerabilities in the underlying OS can cascade across multiple Fortinet products simultaneously
- CVE-2025-32756 carried a CVSS score of 9.6 (Critical), involving a stack-based buffer overflow in the HTTP daemon allowing unauthenticated RCE
- Fortinet's PSIRT confirmed the vulnerability was exploited in the wild before a patch was available — a true zero-day scenario
- FortiVoice integrates with FortiManager and FortiAnalyzer, making it part of Fortinet's Security Fabric — compromise can mean lateral visibility across the entire fabric
- Mitigation before patching included disabling the HTTP/HTTPS administrative interface and monitoring for unexpected system call log activation

## Related concepts
[[VoIP Security]] [[Zero-Day Vulnerability]] [[Buffer Overflow]] [[Fortinet Security Fabric]] [[CVE Scoring (CVSS)]]