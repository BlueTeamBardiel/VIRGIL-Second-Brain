# Impact Printers

## What it is

That receipt the warehouse guy hands you when he signs for a pallet — the multi-part carbon-copy form where the top sheet is white, the second is yellow, the third is pink, and all three have the same data because the print head physically *struck* through them. That's an impact printer. The technology is forty years old and it's still in your shipping department because nothing else can do that job.

In plain English: a printer that creates an image by physically hammering pins against an inked ribbon, which transfers ink onto paper. Mechanical. Loud. Slow. Indestructible.

Technical definition: an impact printer uses a print head containing a vertical column of small metal pins (typically 9 or 24) driven by electromagnets. The head moves horizontally across the page. As it moves, the printer controller fires individual pins through an inked ribbon and against the paper, building each character from a matrix of dots. Because the strike is physical, the impression passes through multiple sheets of carbon or carbonless multi-part paper in a single pass.

## Why it matters

Impact printers are tested on **Objective 220-1201 3.7** as part of the broader printer-types question set. CompTIA wants you to know they still exist, where they're deployed, what consumables they use, and why nothing else can replace them in those niches.

In the field, you will service impact printers at warehouses, auto repair shops, banks (passbook printers), tax offices, doctors' offices doing prescription pads, and any environment running multi-part forms or continuous-feed tractor paper. The user base is older, the equipment is older, and the ticket usually says "the printer is making a funny noise" or "the print is too light." You will replace ribbons, clear paper jams from tractor feeds, and explain — gently — why we cannot replace the unit with a nice laser printer.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Impact printers are dot-matrix devices. The two common pin counts are 9-pin (draft quality, fast, loud) and 24-pin (near letter quality, slower, still loud). Print speed is measured in characters per second (cps), typically 300–1000 cps in draft mode. They use a fabric ribbon cartridge — a continuous inked loop that advances as the head moves. Paper feed is either friction (single sheets) or tractor feed (the pin-and-sprocket mechanism that grabs the perforated edges of continuous-form paper). Multi-part forms are the killer feature: 2-part, 3-part, sometimes 4-part NCR (no carbon required) paper where the impact transfers through every layer in one pass. Connectivity is usually parallel (LPT) or serial (RS-232) on legacy units, USB on newer ones, and Ethernet on the small handful of modern industrial models. They speak Epson ESC/P or IBM Proprinter command languages — not PCL, not PostScript.

**Beat 2 — Feynman example via the homelab and the LAN-party era.**

**The receipt printer you don't think about:** Every time you check into a hotel and the front desk hands you a folio, every time the warehouse signs for a delivery, every time the auto shop prints your work order in triplicate — that's likely an impact printer in 2026. *The niche didn't die; it just stopped being interesting.*

**Why it's still here:** You cannot make a laser printer write through carbon paper. The toner sits on the surface. The impact has to be mechanical. *No physics, no replacement.*

**The sound:** If you've ever heard an old printer that sounded like a chainsaw making a fax noise, that was a dot-matrix. The pins fire at audible frequencies. Modern offices put them in sound-dampening cabinets. *The noise isn't a malfunction. That's just how it works.*

**The ribbon:** Like a typewriter ribbon, but a continuous loop. When prints get faint, you replace the ribbon — not toner, not ink. A ribbon costs $5 and lasts months. *Cheapest consumable in printing.*

**Beat 3 — Bridge from home to enterprise.** Same fundamental question — *what is this device for?* — produces different answers across contexts:

- **Home:** You will never own one. If you do, it's because you inherited a Commodore 64 setup or you run a hobbyist ham radio station that logs to continuous-form paper.
- **Small business (auto shop, dental office):** One impact printer in the back, used exclusively for multi-part work orders or insurance forms. Connected via USB to a single workstation. Driver installed locally. The owner has had it for twelve years and refuses to discuss replacement.
- **Warehouse / logistics:** Multiple impact printers networked via print server, printing pick tickets, packing slips, and bill-of-lading forms on continuous-feed paper. Ethernet connected, queued through a central print server, monitored by IT.
- **Enterprise back office (banks, government):** Passbook printers (the kind that prints into a savings account booklet), check printers, and high-volume multi-part form printers. Often the only device in the entire building running a parallel-port-to-USB adapter chain.

**Beat 4 — The point.** Same question — *what is this for?* — different right answers. The reader who walks into their first IT job assuming "impact printer = obsolete, replace it" will look like an idiot to the warehouse manager who needs three-part bills of lading printed in one pass. *Get the question into your bones: what is this for, and what does it do that nothing else does?* You'll ask it for the rest of your career.

## Key facts

### How impact printing works

| Component | Function |
|---|---|
| **Print head** | Contains 9 or 24 electromagnetically driven pins arranged vertically |
| **Ribbon** | Continuous inked fabric loop between pins and paper |
| **Platen** | Hard rubber roller behind the paper; pins strike against it |
| **Tractor feed** | Sprocket mechanism that pulls continuous-form paper by the perforated edges |
| **Friction feed** | Roller mechanism for single-sheet paper, like a regular printer |
| **Carriage** | Motor-driven assembly that moves the print head horizontally |

### The replaceable consumables

- **Ribbon cartridge** — the only routine consumable. Replace when print fades. Cheap, lasts months.
- **Print head** — replaceable but rare; only fails if pins are bent or burned out.
- **Platen** — replaced after years of use when it gets grooved.

### CompTIA exam traps

> **CompTIA exam trap:** Impact printers use a **ribbon**, not toner, not ink cartridges, not drums. If the question asks "what consumable does an impact printer use," the answer is ribbon. Always.

> **CompTIA exam trap:** Impact printers are the only printer type that can print **multi-part forms** in a single pass. If a scenario describes carbon copies, NCR paper, or triplicate forms, the answer is impact. Inkjet and laser cannot do this.

> **CompTIA exam trap:** **Tractor feed** vs **friction feed** — tractor feed uses the perforated edge strips on continuous-form paper. Friction feed is for single sheets. Know both terms.

> **CompTIA exam trap:** Impact printers do not use **PCL** (Printer Control Language) or **PostScript**. They use ESC/P or IBM Proprinter emulation. PCL is laser/inkjet territory.

### Configuration and connectivity

When deploying an impact printer in a shared environment, the same configuration concerns apply as with any other printer, just with older constraints:

- **Drivers:** Install the manufacturer's driver. Generic text-only drivers work for plain text but break for any formatting. On a **print server**, install the driver once on the server and let clients pull it down via point-and-print.
- **Print server:** The right move for any multi-user impact printer. Centralizes the driver, the queue, and the spooler. Users print to `\\printserver\warehouse-impact` instead of to a USB cable.
- **Ethernet:** Modern impact printers (Epson FX series, Okidata Microline) ship with Ethernet. Older ones get bolted onto a print server via USB or parallel-to-Ethernet adapter.
- **Wireless:** Rare on impact printers. If wireless is required, it's almost always via an external print server appliance, not built in.
- **Tray settings (firmware):** Configure paper width, paper type (continuous vs single sheet), and form length in the printer's firmware menu. Wrong tray settings cause the printer to tear paper or misalign on multi-part forms.
- **Orientation and duplex:** Impact printers print one side only. There is no duplex. Orientation is usually portrait; landscape is possible on wide-carriage models for spreadsheets.

### Security considerations

Yes, even impact printers need security thinking when shared:

- **User authentication / badging:** Modern networked impact printers in regulated environments (banks, healthcare) support badge readers and PIN-based release printing for sensitive forms like prescriptions or check stock.
- **Secured prints:** Hold-and-release queuing — the job sits on the server until the user authenticates at the device. Prevents the warehouse manager's confidential pick list from sitting in the output tray.
- **Audit logs:** Print servers log every job — who printed what, when, how many pages. Required for compliance environments (HIPAA prescription pads, financial check printing).
- **Printer share permissions:** Use NTFS-style share permissions on the print queue. Not every user needs access to the check printer.
- **Firmware updates:** Yes, impact printers get firmware updates. Rare, but they happen — usually to fix paper-handling bugs or add network protocol support. Check the manufacturer's site annually.

### What impact printers do NOT have

For exam purposes, know the negatives:
- No **ADF** (automatic document feeder) — these are printers only, not multifunction devices
- No **flatbed scanner** — same reason
- No **network scan services** — nothing to scan
- No **SMB scan-to-folder, email scan, or cloud scan** — these are MFP features
- No **PCL or PostScript** support — wrong command language family
- No **duplex** — single-sided only
- No **color** — monochrome only (a few exotic models used multi-color ribbons, but these are museum pieces)

These negatives matter because CompTIA will put an impact printer in a scenario and ask which feature is unavailable. The answer is usually "anything involving scanning, color, or duplex."

## Helpdesk reality

- **"The printer is too light / faded."** Ribbon is worn out. Replace it. Five dollars, two minutes. Do not order a new printer.
- **"The printer is making a horrible grinding noise."** Either the ribbon is jammed, the print head carriage is hitting an obstruction, or the tractor feed is misaligned. Power off, open the cover, inspect physically. Never force the carriage by hand.
- **"It's printing crooked / the holes don't line up."** Tractor feed is misaligned. Re-seat the continuous-form paper so the perforations sit on the sprocket pins evenly on both sides.
- **"Can we replace this with a laser printer?"** Ask what they print. If the answer includes the words "carbon," "triplicate," "multi-part," or "NCR" — the answer is no. Explain why once. Document the conversation in the ticket so the next tech doesn't have it again.
- **Never promise** that you can get a modern wireless print-from-phone workflow onto a 20-year-old dot-matrix. You can sometimes get USB-to-Ethernet adapters and print server appliances to bridge the gap, but the user experience will never match a modern MFP. Set expectations honestly.

## Related concepts

[[Laser Printers]] · [[Inkjet Printers]] · [[Thermal Printers]] · [[3D Printers]] · [[Print Servers and Print Queues]] · [[Printer Drivers and PCL vs PostScript]] · [[Multifunction Devices and ADF]] · [[Secured Print and Badge Release]] · [[Printer Connectivity USB Ethernet Wireless]]

*Source: VIRGIL knowledge base — 2026-05-10*