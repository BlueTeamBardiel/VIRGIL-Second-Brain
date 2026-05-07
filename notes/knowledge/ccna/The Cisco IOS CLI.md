# The Cisco IOS CLI

## What it is

The Cisco IOS CLI is the command console you drop into when you SSH into a router — closer to the developer console in Cyberpunk 2077 than to a polished menu. No mouse, no icons, just a blinking prompt waiting for typed instructions. The shell sitting behind that prompt acts as a translator: you type human-readable words like `show ip route`, and it converts them into actions the device hardware actually performs.

A GUI would be the equivalent of navigating Netflix with a remote — pretty pictures, intuitive, slow. The CLI is the keyboard shortcut power-user mode: ugly, fast, and precise. For a beginner the GUI wins. For anyone who has typed `conf t` ten thousand times, the CLI wins by an enormous margin, which is why CCNA candidates are tested on actual hands-on configuration rather than multiple choice trivia about where a checkbox lives.

## Why it matters

Every Cisco router and switch in production, from a tiny branch office box to a core data center beast, speaks this same language. Learn the CLI once and you can walk up to almost any Cisco device and start working — the muscle memory transfers like rebinding the same keys across every FPS you play.

It also matters because the CLI exposes the real state of the device. There's no abstraction layer hiding things from you. When something breaks at 3 AM, the CLI is what you have. The GUI may not even be reachable if the network itself is the problem, which is the entire reason console access exists.

## Key facts

### Connecting to the device

- **Console connection**: A physical cable plugged directly into the device's console port. Local only, typically under 10 feet. This is the netrunner jacking in directly with a cable in Cyberpunk — no network required, works even when the device is misconfigured into oblivion.
- **Out-of-band**: The console port doesn't ride the network infrastructure. If you've accidentally shut down every interface, the console still works. It's the emergency hatch.
- **One console session at a time**: Single-player only. No co-op on the console port.
- **Network connections**: Telnet (plaintext, basically sending your password on a postcard) or SSH (encrypted, the only acceptable choice in 2024).
- **Rollover cable**: Pin 1↔8, 2↔7, 3↔6, 4↔5 — pins are mirrored end-to-end. Distinct from straight-through (Ethernet) and crossover cables. Using the wrong cable here is like trying to fit a PS5 controller cable into an Xbox — physically maybe, functionally no.
- **USB Mini-B** on modern devices, **RJ45** on legacy gear for the console port.
- **Terminal emulator**: Software like PuTTY or Tera Term that pretends to be the chunky physical terminal of the 1970s.
- **Serial settings**: 9600 bps, 8 data bits, 1 stop bit, no parity, no flow control. Memorize these like a fighting game combo — wrong settings means garbage characters on screen.

### Command modes (the prompt tells you where you are)

The prompt is your minimap. Glance at it and you know what you can do.

- **User EXEC** → `Router>` — Default mode on login. Look-but-don't-touch tier. Like spectator mode.
- **Privileged EXEC** → `Router#` — Full read access, can reboot, can save. Reached by typing `enable`.
- **Global Configuration** → `Router(config)#` — You can now change device-wide settings. Reached with `configure terminal` (or `conf t`).
- **Interface Configuration** → `Router(config-if)#` — Editing one specific interface. Reached with `interface GigabitEthernet0/1`.
- **Line Configuration** → `Router(config-line)#` — Editing console or VTY lines.

### Moving between modes

- `enable` — User EXEC → Privileged EXEC.
- `configure terminal` — Privileged EXEC → Global Config.
- `interface <name>` — Global Config → Interface Config.
- `exit` — Up one level, like backing out of one nested menu.
- `end` or `Ctrl+Z` — Hard escape straight back to Privileged EXEC from anywhere in config. The "B button held down" of the CLI.

### Passwords

- `enable password <pw>` — Sets the privileged-mode password but stores it in plaintext. Anyone with `show running-config` access reads it instantly.
- `enable secret <pw>` — MD5-hashed. Use this. The plaintext one is the equivalent of writing your Discord password on a sticky note.
- `line console 0` — Configures the physical console port.
- `line vty 0 4` — Configures virtual terminal lines 0 through 4 (the SSH/Telnet sessions).
- `login` — Tells the line to actually prompt for the password you set. Without it, the password sits there doing nothing.

### Configurations: running vs startup

This is the single most painful gotcha for new admins.

- **Running-config**: Lives in RAM. The active configuration right now. Every change you type lands here first.
- **Startup-config**: Lives in NVRAM. The configuration loaded at boot.
- Reboot without saving and your running-config evaporates like an unsaved Elden Ring run before a boss fight. The device reloads startup-config and pretends your last hour of work never happened.
- `copy running-config startup-config` — The save button. Burns RAM state into NVRAM.
- `show running-config` — What's active.
- `show startup-config` — What will load on next boot.
- `erase startup-config` — Wipes the saved config. Combined with `reload`, you get a factory-fresh device.

### Useful show and operational commands

- `show version` — Device model, IOS version, uptime, serial number. The character sheet.
- `show interfaces` — Status of every interface, error counters, the works.
- `show ip route` — The routing table. Where this device thinks traffic should go.
- `reload` — Reboots the device.
- `shutdown` (in interface mode) — Disables the interface. The interface goes dark.
- `no shutdown` — Enables it again. The `no` prefix universally means "undo this" — `no ip address`, `no shutdown`, `no enable secret`. It's the universal toggle-off.

### Quality-of-life shortcuts

- **Tab** — Autocompletes commands. Type `conf` + Tab → `configure`.
- **Up/Down arrows** — Scroll through command history. Saves your fingers.
- **?** — Context-sensitive help. Type `show ?` and the CLI lists every valid next word. The in-game tutorial that's actually useful.

### Boot process in one line

Bootloader pulls the IOS image from Flash memory → IOS loads startup-config from NVRAM → device is live with that configuration in RAM as the new running-config.

## Related concepts

[[SSH vs Telnet]]
[[Console port and out-of-band management]]
[[Rollover, straight-through, and crossover cables]]
[[Cisco IOS boot process]]
[[NVRAM, RAM, and Flash memory roles]]
[[VTY lines and remote access security]]
[[Password encryption on Cisco devices]]
[[Basic switch configuration]]
[[Basic router configuration]]