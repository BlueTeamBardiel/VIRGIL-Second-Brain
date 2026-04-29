# macOS

## What it is
Think of macOS like a house built on a UNIX foundation — the walls look like polished Apple design, but the plumbing underneath is BSD pipes and POSIX wiring. Precisely, macOS is Apple's proprietary Unix-based operating system for Mac hardware, built on the Darwin kernel (XNU), featuring layered security controls including Gatekeeper, System Integrity Protection (SIP), and the Transparency, Consent, and Control (TCC) framework.

## Why it matters
In 2023, the LockBit ransomware group released a macOS variant specifically targeting Apple Silicon, demonstrating that the "Macs don't get viruses" myth is dangerously outdated. Attackers increasingly abuse macOS's LaunchAgents and LaunchDaemons — persistence mechanisms that survive reboots — to establish long-term footholds, as seen in the XCSSET malware that injected itself into Xcode projects to spread through developer supply chains.

## Key facts
- **System Integrity Protection (SIP)** prevents even root-level users from modifying protected system directories like `/System` and `/usr` — disabling it requires booting into Recovery Mode
- **Gatekeeper** enforces code signing and notarization; apps from outside the App Store must be notarized by Apple or users must explicitly override
- **TCC (Transparency, Consent, and Control)** controls app access to sensitive resources (camera, microphone, Full Disk Access) and is stored in SQLite databases at `~/Library/Application Support/com.apple.TCC/`
- **LaunchAgents** (`~/Library/LaunchAgents/`) run in user context at login; **LaunchDaemons** (`/Library/LaunchDaemons/`) run as root at boot — both are prime persistence locations
- macOS logs security events via **Unified Logging System** (`log show` command); endpoint detection tools query this for forensic investigation

## Related concepts
[[System Integrity Protection]] [[Gatekeeper]] [[Persistence Mechanisms]] [[Endpoint Detection and Response]] [[Supply Chain Attack]]