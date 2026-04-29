# GUI

## What it is
Like a car's dashboard hiding the engine complexity behind familiar gauges and buttons, a GUI (Graphical User Interface) presents a visual layer of controls — windows, icons, menus — that lets users interact with software without issuing raw commands. It abstracts underlying system functions into clickable, human-readable elements rather than typed instructions.

## Why it matters
Attackers frequently exploit GUI-based remote access tools (RATs) to maintain persistence on compromised systems — tools like njRAT or DarkComet provide the attacker with a full graphical interface to the victim's machine, making it trivially easy to browse files, capture keystrokes, and pivot laterally. Defenders hunting for these threats look for unexpected remote desktop protocols (RDP) sessions or VNC connections that indicate an attacker is operating a GUI session on an owned host.

## Key facts
- **RDP (port 3389)** is the most commonly abused GUI remote access protocol; brute-force attacks against exposed RDP are a leading initial access vector
- GUI-based tools lower attacker skill requirements — point-and-click C2 frameworks like Cobalt Strike's Beacon use GUI consoles to manage dozens of compromised hosts simultaneously
- **Screenscraping attacks** target GUI rendering pipelines to exfiltrate data displayed on screen without accessing underlying files or databases
- Many hardening guides (CIS Benchmarks) recommend removing GUI components from servers — reducing attack surface by eliminating unnecessary packages like X Window System on Linux
- GUI log artifacts (Windows Event ID **4624** for logon, **4778/4779** for RDP session connect/disconnect) are critical forensic indicators during incident response

## Related concepts
[[Remote Desktop Protocol]] [[Remote Access Trojan]] [[Attack Surface Reduction]]