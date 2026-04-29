# EVE-NG

## What it is
Like a Hollywood set where you can build an entire city without using real bricks, EVE-NG (Emulated Virtual Environment Next Generation) lets you construct full network topologies — routers, firewalls, switches, endpoints — entirely in software. It is a web-based network emulation platform that runs real vendor operating system images (Cisco IOS, Palo Alto, pfSense) inside a virtualized environment, enabling hands-on lab work without physical hardware.

## Why it matters
Security teams use EVE-NG to safely rehearse attack and defense scenarios in isolated environments before touching production systems. For example, a blue team can spin up a realistic enterprise network with Active Directory, a Cisco ASA firewall, and a Kali Linux attacker node to practice detecting lateral movement and tuning SIEM rules — all without risk of disrupting live infrastructure. Penetration testers also use it to validate exploits against specific firmware versions before engagements.

## Key facts
- EVE-NG runs as a bare-metal install or OVA virtual appliance on VMware/VirtualBox, requiring nested virtualization (VT-x/AMD-V) to be enabled in the hypervisor
- Unlike Packet Tracer (simulated), EVE-NG runs *actual* vendor images, meaning exploits, misconfigurations, and protocol behavior are authentic
- The Community Edition is free; Professional Edition adds multiuser support, useful for team-based security training or classroom environments
- EVE-NG supports integration with Wireshark for live packet capture directly on virtual links — critical for traffic analysis labs
- Network segmentation and VLAN configuration can be tested end-to-end, making it directly relevant to practicing Defense-in-Depth architectures covered in CySA+

## Related concepts
[[Network Segmentation]] [[Virtualization Security]] [[Penetration Testing Lab]] [[Wireshark]] [[Defense-in-Depth]]