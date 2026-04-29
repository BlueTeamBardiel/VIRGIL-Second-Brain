# PXE

## What it is
Like a restaurant that delivers a full meal to your table instead of making you cook at home, PXE (Preboot Execution Environment) lets a computer boot a complete operating system delivered over the network before its local disk is ever touched. Precisely, it's a client-server protocol standard that uses DHCP to locate a boot server and TFTP to download a bootable image, enabling diskless or remote OS deployment at startup.

## Why it matters
An attacker on a local network segment can stand up a rogue DHCP/PXE server — a technique called PXE hijacking — and respond to boot requests faster than the legitimate server, pushing a malicious OS image that harvests credentials or installs persistent malware before the victim OS even loads. This is particularly devastating in data centers during automated bare-metal provisioning cycles, where hundreds of servers may be simultaneously requesting PXE boot images.

## Key facts
- PXE relies on **DHCP options 66 (TFTP server name) and 67 (bootfile name)** to direct clients to the correct boot image
- **TFTP (UDP port 69)** is inherently unauthenticated — anyone who can respond first wins the race
- **Rogue PXE attacks** are a recognized supply-chain and insider threat vector in enterprise environments
- Defenses include **DHCP snooping**, **802.1X port authentication**, and signing boot images with **Secure Boot / UEFI keys**
- PXE is heavily used in **Windows Deployment Services (WDS)** and tools like **Cobalt Strike**, which weaponizes it for lateral movement via its built-in DHCP/TFTP server module

## Related concepts
[[DHCP Snooping]] [[TFTP]] [[Rogue DHCP Attack]] [[Network Boot Security]] [[Secure Boot]]