# Power Over Ethernet (PoE) Issues

## What it is

In **Madden**, the team's energy meter quietly governs everything. You can call any play in the playbook, but if your linemen are gassed in the fourth quarter, the play doesn't execute — the right tackle misses his block, the QB eats a sack, and the broadcast cuts to a coach yelling on the sideline. The play call didn't fail. The power supply to the players did. That's exactly what a PoE failure looks like — the data is fine, the switch is fine, the access point is just sitting there dark because the watts ran out somewhere between the play call and the snap.

**Power over Ethernet (PoE)** delivers DC power and data over the same twisted-pair copper cable to powered devices (PDs) like access points, IP phones, cameras, and door controllers. The switch (or midspan injector) is the **power sourcing equipment (PSE)**. The PSE negotiates with the PD, decides how many watts to allocate, and tracks total draw against the switch's **power budget**. When any link in that chain — cable, negotiation, budget, distance — fails, the device goes dark while the data side stays perfectly healthy. That asymmetry is what makes PoE troubleshooting its own discipline.

## Why it matters

PoE is the quiet backbone of modern access-layer networks. Every ceiling AP, every conference room camera, every desk phone, every badge reader on a door — most of them are PoE. When PoE breaks, users say *"the Wi-Fi is down"* or *"the phone is dead,"* and the helpdesk wastes an hour chasing the wrong layer. The exam (Objective 5.2) tests whether you recognize **power budget exceeded**, **incorrect PoE standard**, and **cable issues that block power but not always data** as distinct failure modes. In the field, this is also where careers diverge — the tech who checks switch power budget first is the tech who closes tickets before lunch.

## Key facts

### The PoE standards — know the wattage ladder cold

| Standard | IEEE | PSE output | PD receives | Common name |
|---|---|---|---|---|
| PoE | 802.3af | 15.4W | 12.95W | Type 1 |
| PoE+ | 802.3at | 30W | 25.5W | Type 2 |
| PoE++ | 802.3bt | 60W | 51W | Type 3 |
| PoE++ | 802.3bt | 100W | 71.3W | Type 4 |

PSE output is what leaves the switch port. PD receives is what reaches the device after cable loss. The gap is real — assume ~3–4W lost on a 100m Cat5e run and budget accordingly.

### Power budget exceeded — the silent killer

Every PoE switch has a **total power budget** (e.g., a 48-port switch might offer 740W). That's the ceiling for the whole switch, not per port. Plug 30 access points pulling 25W each into a 740W switch and you get 24 powered APs and 6 ports that negotiate, fail, and drop. The switch logs **"power budget exceeded"** or **"insufficient power"** and disables PoE on the latest ports to come up.

> **CompTIA exam trap:** Power budget exceeded does **not** mean the switch is broken or the cable is bad. It means the sum of allocated wattage across active PoE ports exceeded the PSE's available watts. The fix is more power supply capacity, a second PoE switch, or downgrading some PDs to lower-power equivalents. The exam loves to dangle "replace the cable" as a distractor here. Don't bite.

### Incorrect PoE standard — the negotiation mismatch

A Wi-Fi 6 AP that needs 802.3at (30W) plugged into an 802.3af-only switch (15.4W) will either fail to boot, boot in low-power mode (radios disabled, 2.4 GHz only, one spatial stream), or boot-loop. The link light might be green. The data plane might briefly come up. Then the AP browns out, drops, and reboots.

*The tell: a device that boots, runs for 30 seconds, dies, and tries again. That's not a software bug. That's a watt deficit.*

### Cable issues that specifically break PoE

PoE rides on the same copper pairs as data, but it's more sensitive to cable quality than data is.

- **[[Category 5/6/7/8|Cat5e]] minimum** — Cat5 (without the "e") was never rated for gigabit or PoE. If you find Cat5 in a ceiling and an AP won't power, replace the run.
- **Cat6/6a strongly preferred for 802.3bt** — higher wattage means more heat in the bundle. Cat6a's thicker conductors dissipate heat better and tolerate the current.
- **[[Distance limits|100-meter limit]]** — same as data. Past 100m, voltage drop kills the negotiation. A run that pings fine at L3 can still fail to power a PD because the PD's voltage threshold is stricter than the NIC's signal threshold.
- **[[Improper termination]]** — a punchdown where one pair is split or untwisted past the jacket adds resistance and crosstalk. Data may survive; PoE may not.
- **[[Crosstalk]] and [[interference]]** — bundled PoE runs in a hot ceiling can heat each other up, raising resistance, lowering delivered watts. TIA spec caps bundle sizes for this reason.
- **[[Shielded twisted pair (STP)]]** — required in high-EMI environments (factory floors, near elevator motors). The shield must be properly bonded at one end or it becomes an antenna.

### Interface counters that point at PoE-adjacent cable problems

When PoE is borderline, the data side often shows symptoms too. Check `show interface` for:

- **[[CRC|CRC errors]] increasing** — frames arriving with bad checksums. Signals signal degradation, bad cable, or EMI.
- **[[Runts]]** — frames shorter than 64 bytes. Collisions or a truncating cable fault.
- **[[Giants]]** — frames over 1518 bytes (without jumbo frames enabled). Usually a duplex or MTU mismatch, but a flaky cable can fragment frames weirdly.
- **Input errors / drops** — the port is receiving garbage or buffer-overflowing.

*If CRC errors are climbing on a PoE port and the AP keeps rebooting, the cable is the answer. Both problems. Same cable.*

### Port status states — read the switch, not the device

| State | What it means | Action |
|---|---|---|
| **Up / Up** | Link and protocol both good | If PD still dead, check power budget |
| **Down / Down** | No link | Cable, transceiver, or far-end off |
| **[[Administratively down]]** | Someone shut the port with `shutdown` | `no shutdown` |
| **[[Error disabled]]** (err-disabled) | Switch killed the port for a violation (port security, BPDU guard, PoE fault) | Find the trigger, then `shutdown / no shutdown` |
| **Suspended** | EtherChannel member can't join the bundle | Mismatched config on the channel group |

PoE-triggered err-disable is common when a PD draws more current than negotiated — the switch protects itself by cutting power and shutting the port.

### Single mode vs. multimode — when PoE is not the answer

PoE only runs over copper. If the AP is at the end of a fiber run, power is coming from a local injector or a converter — not the switch. **[[Single-mode fiber]]** (yellow jacket, 9μm core, long-haul, lasers) and **[[multimode fiber]]** (orange or aqua jacket, 50/62.5μm core, short-haul, LEDs/VCSELs) carry data but not watts. Pair them with the right [[Transceivers|SFP/SFP+ transceiver]] for the wavelength — a single-mode transceiver in a multimode patch (or vice versa) gets you a dark link and a confused junior tech.

> **CompTIA exam trap:** **[[TX/RX transposed]]** — fiber needs the transmit fiber on one end to land on the receive port on the other. Swap the LC duplex connector if the link is down and both transceivers report "no signal." On copper, auto-MDI-X fixes this automatically on any switch made after 2005. On fiber, you flip the connector.

### Signal degradation, attenuation, and signal strength

**[[Attenuation]]** is signal loss over distance — the signal gets quieter the further it travels. Copper attenuates from heat and resistance; fiber attenuates from absorption and scattering in the glass. **[[Signal strength]]** drops below the receiver's sensitivity threshold and the link goes down or starts dropping frames. For PoE, attenuation translates directly to lost watts at the PD. A device negotiating 30W at the switch might see 24W after 95m of marginal Cat5e — under threshold for an 802.3at AP.

## Troubleshooting PoE — the CompTIA 7-step, applied

1. **Identify the problem** — Which device is dark? When did it stop working? Has anything changed in the rack or the ceiling?
2. **Establish a theory** — Most likely: power budget, wrong standard, bad cable, dead PD, in that order.
3. **Test the theory** — `show power inline` on the switch. Look at allocated vs. available watts. Check the port's negotiated class. Swap the PD with a known-good one. Swap the patch cable. If you have a PoE tester (Fluke or equivalent), use it.
4. **Plan of action** — Move the PD to a different PoE port, add a PoE injector, replace the cable, or escalate to facilities for a switch with more budget.
5. **Implement** — One change at a time. Don't replace the cable and the PD and move the port simultaneously. You'll never know which fix worked.
6. **Verify** — Device boots, stays up through a 10-minute soak, passes traffic. Check `show power inline` again for stable allocation.
7. **Document** — Update the wiring map, log the port, note the PoE class. The next tech needs to know this AP is on the edge of the budget.

## Helpdesk reality

- *"The Wi-Fi is down in the south conference room"* — 70% of the time, it's a single PoE AP that browned out. Check the switch port status before you blame the SSID, the controller, or the user.
- *"My phone is dead and the screen is blank"* — not a phone problem. Walk to the IDF and look at the switch port for that jack. Link light off = cable or PoE. Link light on, no power LED on the phone = power budget or wrong standard.
- **Never promise a same-day fix on power budget issues** — adding switch capacity is a procurement conversation, not a ticket.
- **First three checks, in order:** (1) is the cable seated at both ends, (2) does the switch port show up/up with PoE allocated, (3) does a known-good PD power up on the same port. If all three pass and the original PD still won't boot, the PD is dead.
- **Escalate to the network team** when power budget is exceeded across the whole switch — they need to plan a hardware refresh or a PoE injector strategy. That's not a desktop-support fix.

## Related concepts

[[Category 5/6/7/8]] · [[Transceivers]] · [[Single-mode fiber]] · [[Multimode fiber]] · [[CRC]] · [[Runts]] · [[Giants]] · [[Crosstalk]] · [[Attenuation]] · [[Error disabled]] · [[Administratively down]] · [[Improper termination]] · [[TX/RX transposed]] · [[Shielded twisted pair (STP)]] · [[Cable testers]] · [[Port security]]

*Source: VIRGIL knowledge base — 2026-05-11*