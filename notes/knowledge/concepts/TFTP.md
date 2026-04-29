# TFTP

## What it is
Think of TFTP as file transfer with amnesia — it hands you the file but remembers nothing about who you are or whether you're authorized. Trivial File Transfer Protocol (TFTP) is a stripped-down UDP-based file transfer protocol (port 69) that operates with zero authentication, no encryption, and no directory listing — just simple read/write operations.

## Why it matters
Network devices like routers, switches, and IP phones commonly use TFTP to pull firmware images and configuration files at boot time — a process called PXE booting. An attacker positioned on the same network segment can intercept these unencrypted TFTP transfers to steal configuration files containing credentials, or serve a malicious firmware image to a device that blindly trusts whatever arrives on UDP/69.

## Key facts
- Runs over **UDP port 69** — connectionless, making it lightweight but unreliable and easily spoofed
- **No authentication whatsoever** — any client that knows the filename can request it; security relies entirely on network-layer controls
- Used heavily in **PXE (Preboot Execution Environment)** for diskless workstations and network booting scenarios
- TFTP is a common vector for **configuration exfiltration** — Cisco IOS devices historically stored `startup-config` files retrievable via TFTP if not firewalled
- Should be **blocked at the perimeter** and restricted to isolated management VLANs; its presence on production networks is a significant misconfiguration finding

## Related concepts
[[UDP]] [[PXE Boot]] [[FTP]] [[Network Segmentation]] [[Cleartext Protocols]]