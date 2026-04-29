# Apple Remote Desktop

## What it is
Think of it as a master skeleton key that lets an IT admin walk into any Mac on the network simultaneously, move the mouse, open files, and watch the screen — all without touching the physical machine. Apple Remote Desktop (ARD) is a macOS application that provides centralized remote management, screen sharing, software deployment, and system reporting across Apple devices using the Apple Remote Desktop protocol (built on VNC).

## Why it matters
In 2017, researchers discovered that ARD's built-in VNC server could be exploited when screen sharing was enabled — an attacker on the same network could leverage weak or default VNC passwords to gain full graphical control of a macOS system without any authentication bypass needed. Defenders must audit which Macs have ARD or screen sharing enabled, enforce strong credentials, and restrict access via firewall rules to limit exposure to trusted subnets only.

## Key facts
- ARD uses **TCP port 3283** for remote management features and **TCP port 5900** for its underlying VNC (screen sharing) component — both must be considered in firewall policy.
- ARD can execute Unix shell commands simultaneously across hundreds of Macs, making it a powerful lateral movement tool if compromised.
- The `kickstart` command-line utility bundled with ARD can **enable or disable remote management** programmatically — a known living-off-the-land technique on macOS.
- ARD activity is logged in `/var/log/system.log` and via Apple Unified Logging (`log show`) — critical for forensic analysis on macOS endpoints.
- Enabling ARD grants the remote admin **observe, control, and report** privileges — misconfigurations can silently allow non-admin users full control access.

## Related concepts
[[VNC (Virtual Network Computing)]] [[Remote Desktop Protocol (RDP)]] [[Lateral Movement]] [[macOS Security]] [[Privileged Access Management]]