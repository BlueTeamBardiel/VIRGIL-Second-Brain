# LAN Turtle

## What it is
Think of it as a Trojan horse disguised as a USB Ethernet adapter — it looks like harmless network hardware but contains a full Linux system running covert tools. The LAN Turtle is a commercial pentest implant by Hak5 that sits between a target machine and the network, providing persistent remote access, network reconnaissance, and man-in-the-middle capabilities through a hidden management interface.

## Why it matters
An attacker with brief physical access to an office — a cleaning crew member, a social engineer posing as IT — plugs a LAN Turtle into an exposed USB port on a workstation or switch. The device silently establishes an encrypted reverse SSH tunnel to an attacker-controlled server, granting persistent remote shell access even through NAT and firewalls, long after the attacker has left the building. Defenders use this scenario to justify USB port lockdown policies and physical security controls.

## Key facts
- Physically resembles a USB-to-Ethernet adapter (USB-A male → RJ45 female), making it visually indistinguishable from legitimate hardware
- Runs OpenWRT Linux internally, supporting modular payloads called "modules" (e.g., Autossh, Responder, Metasploit)
- Uses reverse SSH tunneling to call out to attacker infrastructure, bypassing inbound firewall rules
- Can perform credential harvesting via the built-in **Responder** module, capturing NTLM hashes on the local network segment
- Classified as a **hardware implant** / **supply chain threat** — relevant to physical security and insider threat discussions on CySA+

## Related concepts
[[Rubber Ducky]] [[Responder (Tool)]] [[Man-in-the-Middle Attack]] [[Reverse Shell]] [[Physical Security Controls]]