# Hardware Tools

## What it is

In **Bloodborne**, when you fight Father Gascoigne in the graveyard, you don't just swing the Saw Cleaver and hope. You have a kit. Pistol for the parry, Molotov for the beast phase, Blood Vial when you're bleeding out, Quicksilver Bullets for the shot you actually need to land. Each tool does one job. Bring the wrong tool — say, only the Hunter Axe and no firearm — and you eat the transformation and die in the fog.

That's exactly what hardware networking tools are — a hunter's kit for the physical layer. Each one diagnoses one specific failure mode. Bring the wrong tool to a cabling problem and you'll be guessing for hours.

**Hardware tools** are the physical instruments a network technician uses to test, trace, certify, and troubleshoot the cabling and active equipment that make up Layer 1 and Layer 2. They exist because software tools — [[ping]], [[traceroute]], [[Nmap]] — can only tell you that something is broken. Hardware tools tell you **where it is broken in the physical world**.

N10-009 Objective 5.5 splits diagnostic tools into software and hardware. The hardware side is what this note covers: cable testers, toners, taps, visual fault locators, Wi-Fi analyzers, and speed testers.

## Why it matters

Layer 1 problems are the most common network failures and the most embarrassing ones to misdiagnose. A user reports "the internet is down." You spend forty minutes reading router logs and checking BGP routes. Then a junior tech walks over with a cable tester and finds a punchdown with one pair miswired in the wall jack. Forty minutes versus four.

On the exam, CompTIA tests whether you can match the symptom to the right tool. *"Intermittent connectivity on a single drop"* — cable tester. *"Find which port a cable terminates on in a 48-port patch panel"* — toner probe. *"Fiber link is down with no obvious cause"* — visual fault locator. Get the match wrong and you waste exam points the same way you'd waste billable hours in the field.

Every tech who works on physical infrastructure carries some version of this kit. *The cable doesn't care about your CCNP. The cable cares whether pair 3 is split.*

## Key facts

### The hardware diagnostic kit

| Tool | What it does | When you reach for it |
|------|-------------|----------------------|
| **Cable tester** | Verifies pinout, continuity, shorts, opens on copper | New runs, suspected miswire, intermittent link |
| **Cable certifier** | Tests cable to TIA/EIA specs — crosstalk, attenuation, NEXT | Certifying new install for warranty |
| **Toner and probe** | Tone generator clips one end; probe finds the matching end by induction | Identifying unlabeled drops in a wiring closet |
| **Visual fault locator (VFL)** | Red laser injects visible light into fiber; breaks and bad splices glow | Fiber troubleshooting at short range |
| **OTDR** | Measures fiber loss and locates breaks by reflected pulse timing | Long-haul fiber, certifying fiber runs |
| **Wi-Fi analyzer** | Scans RF, shows SSIDs, channels, signal strength, interference | Site survey, channel planning, rogue AP hunt |
| **Spectrum analyzer** | Shows non-Wi-Fi RF interference (microwaves, Bluetooth) | Wi-Fi works on paper but performs badly |
| **Network tap** | Passive inline device that copies traffic to a monitor port | Forensics or IDS capture without using SPAN |
| **Loopback plug** | Loops TX to RX on a port to test if the port itself is alive | Confirming a switch port or NIC is functional |
| **Speed tester** | Measures throughput between two points | Validating ISP SLA, before/after change verification |
| **Punchdown tool** | Seats wires into 110 or 66 blocks on panels and jacks | Terminating new runs |
| **Crimper** | Attaches RJ-45 (or RJ-11) connectors to bulk cable | Building patch cables |

### Cable testers vs cable certifiers — the trap

A **cable tester** tells you the wires are connected to the right pins. A **cable certifier** tells you the cable will actually run at Cat6a speeds without dropping frames. A basic tester is $30; a certifier is $5,000+.

*A cable can pass continuity and still fail at gigabit because of crosstalk. The tester doesn't know. The certifier does.*

### Toner and probe — the most-used tool nobody respects

Walk into any wiring closet that hasn't been documented in five years and you'll find 80 unlabeled cables disappearing into the ceiling. The **tone generator** clips to one end and injects an audio signal. The **inductive probe** waves over bundles until it screams over the matching one. That's how you find which drop in the IDF maps to which jack at the desk.

It's the most boring tool in the bag and the one that saves the most time.

### Visual fault locator — the fiber tech's first move

A VFL is a red laser pen that injects 650nm visible light into a fiber. Sharp bend in the cable? It glows through the jacket at the bend. Broken splice in a patch panel? The light dies there.

VFLs only work for short runs (a few kilometers at most). For real long-haul fiber, you need an **OTDR**, which sends a light pulse and measures reflections to map the entire run with distance-to-fault precision.

### Network taps vs SPAN ports

A **network tap** is a hardware device inserted in-line that mirrors all traffic to a monitor port. Taps are passive and lossless — they see every packet, including errors and malformed frames.

A **SPAN port** (Switched Port Analyzer) is a software feature on a switch that copies traffic from one port to another. SPAN drops packets under load and doesn't see Layer 1 errors. Taps don't.

*Forensics requires a tap. Casual troubleshooting can live with a SPAN.*

### Wi-Fi analyzer

A Wi-Fi analyzer sweeps the 2.4, 5, and 6 GHz bands and shows:

- Every visible SSID and its BSSID
- Channel each AP is using
- Signal strength (RSSI in dBm — closer to zero is stronger)
- Channel overlap and interference

You use it for **site surveys** before a wireless install, **rogue AP detection**, and **channel planning** so your APs aren't all stepping on each other. (Reminder: 2.4 GHz has only three non-overlapping channels — **1, 6, and 11**. Anything else overlaps.)

### Software tools that pair with the hardware kit

The exam will mix hardware and software in the same question. See [[Software Tools]] for full coverage. Short version:

- **[[ping]]** — is the host alive at L3?
- **[[traceroute]] / tracert** — what's the path and where does it die?
- **[[nslookup]] / [[dig]]** — does DNS resolve?
- **[[netstat]]** — what connections does this host have open?
- **[[arp]]** — what MAC corresponds to this IP on my segment?
- **[[ipconfig]] / ifconfig / ip** — what's my IP, mask, gateway, DNS?
- **[[tcpdump]] / Wireshark** — packet-level capture
- **[[Nmap]]** — what hosts and ports are reachable?

Switch CLI commands under "basic networking device commands": `show interface`, `show mac-address-table`, `show route`, `show arp`, `show vlan`, `show config`, `show power`. [[LLDP]] lets neighboring devices announce themselves so you can map physical topology from the CLI without crawling under desks.

### CompTIA exam traps

> **CompTIA exam trap:** A **cable tester** does not certify a cable. If the question mentions performance category (Cat6a, gigabit, throughput specs), the answer is **certifier**. If it just says "verify continuity" or "find a miswire," it's tester.

> **CompTIA exam trap:** **Tone generator** and **toner probe** are sometimes split into two answer choices. The generator injects the tone; the probe finds it. Sometimes called "fox and hound." If you see "trace a cable through a wall," that's toner — not a cable tester.

> **CompTIA exam trap:** A **network tap** is hardware; a **SPAN/mirror port** is software. If the question emphasizes capturing every packet including errors, or capturing without putting load on the switch CPU, the answer is **tap**. If it just says "monitor traffic from port 5," SPAN is fine.

> **CompTIA exam trap:** **VFL** (visible red laser) is for short fiber troubleshooting. **OTDR** (pulse and reflection) is for long-haul fiber and produces a distance-to-fault map. Don't mix them.

> **CompTIA exam trap:** A **loopback plug** tests a single port, not a cable. If the scenario is "verify NIC is functional," loopback. If it's "verify the run from patch panel to wall jack," cable tester.

## Helpdesk reality

- User says: *"My internet is slow."* Run a **speed test** from the user's machine first, then from a wired machine on the same switch. If the wired machine is fine and the user is on Wi-Fi, pull out the **Wi-Fi analyzer** and check signal strength and channel congestion before blaming the ISP.
- User says: *"My computer can't connect."* Check the link light on the NIC. No link light? **Cable tester** on the patch cable. Still nothing? **Loopback plug** on the switch port. The cable is the suspect until proven innocent.
- Never promise: *"I'll find that cable in five minutes."* The toner will find it. How long depends on whether someone bundled 200 cables with one zip tie in 2014. Plan for an hour, deliver in twenty minutes, look like a hero.
- Escalation: if cable, switch port, NIC, and patch panel all test clean and the user still has no connectivity, it's a Layer 3 problem. Hand it to the network team with your test results attached. *"I have proven L1 and L2 are good"* is the most valuable sentence a Tier 1 can write in a ticket.
- Document the run. If you toned a cable today, label both ends before you leave. The next tech is you in six months, and you will not remember.

## Related concepts

[[Software Tools]] · [[Cable Types]] · [[Fiber Optic Cabling]] · [[Wireless Site Survey]] · [[LLDP]] · [[Network Troubleshooting Methodology]] · [[ping]] · [[traceroute]] · [[tcpdump]] · [[Nmap]] · [[SPAN Port]] · [[Patch Panel]]

*Source: VIRGIL knowledge base — 2026-05-11*