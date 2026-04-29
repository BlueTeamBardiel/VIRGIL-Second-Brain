# Raspberry Pi Headless Setup

## What it is
Like sending a remote employee to work without giving them a monitor or keyboard — they still do their job, you just manage them entirely over the network. A headless Raspberry Pi setup configures the device to boot and accept remote connections (typically SSH) without ever requiring a physical display, keyboard, or mouse. Configuration is done by pre-staging files on the SD card before first boot.

## Why it matters
Attackers use headless Pi devices as drop boxes — physically plugging a pre-configured Pi into a target network's Ethernet port and leaving it hidden behind a server rack. The device auto-connects via SSH over a reverse tunnel (e.g., to an attacker's VPS), giving persistent remote access to an internal network segment that bypasses perimeter firewalls entirely.

## Key facts
- Enable SSH on Raspberry Pi OS by placing an empty file named `ssh` (no extension) in the `/boot` partition before first boot — this is the official headless trigger mechanism
- Wi-Fi credentials are pre-configured via a `wpa_supplicant.conf` file placed in `/boot`, allowing wireless headless deployment with zero physical interaction after insertion
- Default credentials (`pi` / `raspberry`) on unmodified images are a well-known vulnerability; changed in newer Raspberry Pi OS builds (Bullseye+) which force user creation on first boot
- Headless drop boxes often use **autossh** or **ngrok** to maintain persistent reverse SSH tunnels that survive NAT and reconnect after drops
- Physical security controls (port security via 802.1X, MAC filtering, USB/Ethernet port locks) are the primary defenses against hardware drop box attacks

## Related concepts
[[SSH Tunneling]] [[Reverse Shell]] [[Physical Security Controls]]