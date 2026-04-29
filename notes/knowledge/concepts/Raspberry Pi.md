# Raspberry Pi

## What it is
Think of it as a full desktop computer shrunk down to the size of a credit card and sold for $35 — powerful enough to run Linux, small enough to hide behind a monitor. Precisely, it is a single-board computer (SBC) developed by the Raspberry Pi Foundation, featuring a CPU, RAM, GPIO pins, USB, HDMI, and network interfaces on a single PCB. It runs standard operating systems like Raspberry Pi OS (Debian-based) and is widely used in both education and offensive/defensive security tooling.

## Why it matters
Red teamers routinely deploy Raspberry Pis as **implants** — physically planting one behind a target's desk, connected to the network via Ethernet, to establish a persistent reverse shell out through the firewall. This technique, sometimes called a "drop box," bypasses perimeter defenses entirely because the device appears as a trusted internal endpoint. Defenders counter this through **802.1X port-based authentication** and physical security audits to detect unauthorized hardware.

## Key facts
- Runs full Linux distributions, making it capable of hosting tools like Metasploit, Nmap, and Wireshark out of the box
- Commonly used as a **rogue access point** or **packet sniffer** when paired with a wireless adapter in monitor mode
- **Kali Linux ARM** has an official Raspberry Pi image, making it a cheap, portable pentesting platform
- GPIO pins allow hardware-level attacks such as UART serial console access on embedded targets
- Default credentials (user: `pi`, password: `raspberry`) on unmodified installs are a known security risk — a frequent exam trap for "insecure defaults"

## Related concepts
[[Rogue Access Point]] [[Physical Security]] [[802.1X Port Authentication]] [[Kali Linux]] [[Implant (Red Team)]]