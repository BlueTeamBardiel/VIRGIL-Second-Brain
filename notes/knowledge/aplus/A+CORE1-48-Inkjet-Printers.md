# Inkjet Printers

## What it is

You bought a $60 inkjet for college. Six months later you needed ink. The cartridges cost $80. You stared at the printer, stared at the cartridges, and learned the business model.

In plain English: an inkjet sprays microscopic droplets of liquid ink onto paper through hundreds of tiny nozzles in a moving print head. The printer is cheap because the ink is the product — same model as Gillette razors.

Technically, an inkjet uses either **thermal** (heat a tiny resistor, ink vaporizes, droplet ejects — Canon, HP) or **piezoelectric** (a crystal flexes when voltage hits it, mechanically forcing the droplet — Epson) nozzles. CMYK ink reservoirs feed the print head, which rides a carriage belt across the page while the feed rollers advance the paper. A separate **duplexing assembly** flips pages for two-sided printing. Multifunction units (MFDs) bolt on a **flatbed scanner** with optional **automatic document feeder (ADF)** on top.

## Why it matters

A+ objective 3.7 wants you to deploy and configure multifunction devices. In the real world, the help desk ticket queue is 30% printer problems forever — they're mechanical, they jam, they run out of consumables, and users blame them first. Knowing how an inkjet actually works separates "did you turn it off and on?" from "your print head is clogged because nobody's used color in six weeks, run the cleaning cycle twice." CompTIA tests the deployment side — drivers, network setup, security, sharing — because that's the work.

## In your build, in the enterprise

**Beat 1 — the tech that matters.** Inkjets are characterized by **DPI** (dots per inch, resolution), **PPM** (pages per minute, throughput), and **duty cycle** (pages per month the hardware is rated for). Home units sit at 1200–4800 DPI, 10–15 PPM, ~1000-page duty cycle. Connectivity is USB, Ethernet (RJ45), or Wi-Fi. The print head either lives in the cartridge (HP, Canon — replace the head every time you replace ink, expensive but reliable) or in the printer body (Epson, Brother — cheaper ink, but a clogged head means a service call). **EcoTank/MegaTank** refillable-reservoir models flipped the razor-blades model on its head: $400 up front, then $20 of ink lasts two years.

**Beat 2 — the home printer reality.**

**You buy the printer.** Cheap, glossy box, "wireless printing!" splashed on the front. You print the resume, the boarding pass, a few photos. *The honeymoon lasts about a month.*

**The cartridges drain.** Half-full warnings start at 30% remaining. The printer refuses to print black if cyan is empty — even pure-black documents — because it uses color to "maintain" the head. *This is by design, not a bug.*

**You don't print for three weeks.** Next time you try, the head is clogged. You run cleaning cycle one. Then two. Then three. Each cycle eats 5% of every cartridge. *The printer that sits idle dies faster than the one used daily.*

**The driver update breaks scanning.** Windows Update pushed a new driver, the scan-to-folder feature stopped working, and now the printer shows up twice in the device list. You uninstall both, reinstall from the vendor site, and pray. *Welcome to your future career.*

**Beat 3 — the enterprise version.** Same machine archetype, completely different deployment. The enterprise multifunction device (MFD) is a 50-PPM beast with a 100-sheet ADF, hardware duplexer, multiple paper trays with **tray settings** managed in firmware (Tray 1 = letterhead, Tray 2 = plain, Tray 3 = legal), and a touchscreen. It joins the domain. It's deployed via a **print server** — one driver package, pushed by Group Policy to every workstation, so when the firmware updates or the model gets swapped, you don't visit 200 desks. **Network scan services** push scanned documents directly to **SMB** shares, **email** (the printer authenticates to an SMTP relay), or **cloud services** (SharePoint, Google Drive). The printer speaks **PCL** (Printer Control Language — HP's page description language) or **PostScript**, and the driver on the workstation translates the print job into one of those languages before sending it.

**Beat 4 — the point.** Same fundamental question — "how does this document get from a user's screen onto paper?" — answered three ways depending on scale. Home: USB cable, vendor driver, hope. Small office: Wi-Fi, shared printer on one workstation, mediocre. Enterprise: print server, GPO-deployed driver, authenticated release. *Get the deployment model straight before you touch a single setting. The rest follows from there.*

## Key facts

### Deployment workflow (CompTIA's order — memorize)

1. **Unbox properly.** Remove ALL shipping tape and orange/blue plastic restraints from the print head carriage and ink bays. Inkjets ship with the carriage locked — power it on while locked and you'll strip the belt.
2. **Install ink, load paper, run alignment.** The first power-on prints an alignment page; the printer reads it back with the scanner to calibrate head position.
3. **Connect.** USB for single-user. Ethernet/Wi-Fi for shared. Configure a **static IP or DHCP reservation** — never let a network printer's IP float.
4. **Install drivers.** Vendor driver from the manufacturer site, or universal print driver (HP UPD, etc.) for enterprise fleets. In a domain, install on the **print server** first, then deploy.
5. **Configure features.** Duplex, orientation defaults, tray mappings, scan destinations.
6. **Test.** Print test page, scan to email, scan to SMB, duplex job. Verify each path.
7. **Secure.** Change default admin password. Enable user authentication. Disable unused protocols.

### Connectivity

| Method | Use case | Notes |
|---|---|---|
| **USB** | Single workstation, home | Plug-and-play, no network exposure |
| **Ethernet** | Office, shared printer | Most reliable, supports Jumbo frames for big scans |
| **Wireless (Wi-Fi)** | Home, small office | WPA2/WPA3, hates concrete walls and microwaves |
| **Wi-Fi Direct** | Phone-to-printer, no router | Peer-to-peer, useful when network is down |
| **Bluetooth** | Mobile, ad-hoc | Slow, range-limited, rarely used in offices |

### Scan paths (network scan services)

- **Scan to email** — printer is configured with SMTP server, port, and credentials. Often uses a service account. Watch the message size limit — a 50-page color scan blows past most attachment caps.
- **Scan to SMB** — printer writes directly to a Windows file share (`\\server\scans\username`). Requires service account with write permission. SMB1 is dead — make sure the printer supports SMB2/3.
- **Scan to cloud** — SharePoint, Google Drive, OneDrive. OAuth-token-based on modern firmware.
- **Scan to USB** — flash drive in the front port. Always allow this until security tells you to disable it.

### Configuration settings to know

- **Duplex** — two-sided printing. Set as default on enterprise fleets; saves 30% on paper instantly.
- **Orientation** — portrait vs landscape, set per-tray for things like check stock.
- **Tray settings** — managed in firmware. Map paper size, type, and color to each tray.
- **PCL vs PostScript** — PCL is faster and good for office documents; PostScript renders graphics more accurately and is preferred for design/print work.

### Security (this section is the exam)

- **User authentication** — user types a PIN, swipes a badge, or enters AD credentials at the touchscreen before the device unlocks.
- **Badging** — RFID/NFC badge readers attached to the MFD. Tap your work badge, your held jobs appear, you pick one and it prints.
- **Secured prints (pull printing / follow-me)** — job sits on the print server until the user authenticates at any MFD in the building. Solves the "confidential document sitting in the tray for two hours" problem.
- **Audit logs** — who printed, scanned, or copied what, when, from which device. Required in healthcare (HIPAA), legal, and finance. Pulled centrally from the print server or the MFD's syslog feed.
- **Wireless security** — WPA3 if supported, WPA2-Enterprise with RADIUS for corporate. Never leave the manufacturer's open Wi-Fi setup mode on after deployment.
- **Firmware** — patch it. Printers have full TCP/IP stacks and have been used as pivot points into networks. They are computers.
- **Disable unused protocols** — Telnet, FTP, SNMPv1, SMB1, raw port 9100 if you don't need it.

### ADF vs flatbed

- **Flatbed scanner** — lift the lid, place document face-down, scan. For books, IDs, fragile originals.
- **Automatic Document Feeder (ADF)** — stack of pages on top, printer feeds them through one at a time. Single-pass duplex ADFs scan both sides in one pass with two scan bars; reverse-feed ADFs flip the page and re-feed (slower, more jams).

### CompTIA exam traps

> **CompTIA exam trap:** Confusing **printer share** (Windows feature — one workstation hosts the printer for others) with a **print server** (dedicated server hosting drivers and queues for an entire fleet). The share is the SMB-style `\\computer\printer` path; the print server is the management layer. Both can be tested in the same question.

> **CompTIA exam trap:** **PCL is the page description language**, not the protocol. The protocol is usually **IPP** (Internet Printing Protocol) or raw TCP/9100. CompTIA loves making you pick PCL out of a list of protocols where it doesn't belong.

> **CompTIA exam trap:** **Secured prints** vs **scan to SMB** — both involve authentication, both involve the network, but secured prints hold the job until the user releases it at the device. Scan-to-SMB writes a scanned file to a network share. Different directions, different features.

## Helpdesk reality

- "It says offline." → Check power, check network cable, check IP hasn't drifted. Restart the print spooler service on the workstation. Restart the print server's spooler if it's a queue problem.
- "It's printing blank pages." → Clogged head. Run cleaning cycle from the printer's menu. If three cycles don't fix it, the cartridge is dry or the head is dead.
- "Streaks on every page." → Run head alignment and cleaning. If it's a laser-style line, the issue is mechanical (roller), not ink.
- "Can't scan to my email anymore." → Service account password expired, or the SMTP relay's IP whitelist doesn't include the new printer's address. Check both.
- "I sent a confidential document and someone else picked it up." → That's why secured prints exist. Roll it out fleet-wide, hand the conversation to your manager.

Never promise a printer "is fixed" until you've watched it complete a duplex job and a scan-to-destination. Printers lie.

## Related concepts

[[A+CORE1-49-Laser-Printers]] · [[A+CORE1-50-Thermal-Printers]] · [[A+CORE1-51-Impact-Printers]] · [[A+CORE1-52-3D-Printers]] · [[A+CORE1-53-Print-Server-Configuration]] · [[A+CORE1-44-Wireless-Networking-Protocols]] · [[A+CORE2-Secured-Prints-and-Audit-Logs]]

*Source: VIRGIL knowledge base — 2026-05-11*