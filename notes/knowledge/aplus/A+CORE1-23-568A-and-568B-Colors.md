# 568A and 568B Colors

## What it is

You bought a 1000-foot box of Cat6, a bag of RJ45 plugs, and a crimper because pre-made patch cables at the right length cost more than the whole spool. You strip the jacket, fan out eight tiny wires, and now you need to put them in the right order. That order has a name. It's either T568A or T568B, and getting it wrong is how you end up with a cable that either doesn't link, links at 100 Mbps instead of gigabit, or works for ten minutes and then doesn't.

In plain English: T568A and T568B are the two standardized pin-out orders for terminating an 8-wire twisted-pair Ethernet cable into an RJ45 connector. They tell you which colored wire goes into which of the eight pins.

Technically: both standards are defined by ANSI/TIA-568. They specify the wiring sequence for the four twisted pairs (orange, green, blue, brown) inside Cat5e/Cat6/Cat6a/Cat7/Cat8 cable when terminated to 8P8C modular connectors and keystone jacks. The two standards are functionally identical for performance — they only differ in which pair sits on which pins. What matters is that **both ends of a cable use the same standard**.

## Why it matters

A+ Objective 220-1201 3.2 lists T568A and T568B explicitly. You will be asked which color goes where, and you will be asked what happens when the two ends don't match. You will also touch real cable on the job — punching down keystones, re-terminating the patch cable some user yanked out of the wall, building custom-length runs in a server rack. This isn't theory. This is muscle memory you build by doing it twenty times.

The deeper reason: the entire physical layer of every wired network in every office on Earth depends on someone, at some point, getting these eight wires in the right order. Get sloppy with the twists, untwist more than half an inch at the connector, mix A and B on the same cable — the link comes up degraded or not at all, and the user complains that "the internet is slow."

## In your build, in the enterprise

**Beat 1 — Technical depth.** The cable has four twisted pairs, each pair color-coded: blue/white-blue, orange/white-orange, green/white-green, brown/white-brown. The twists are the entire reason twisted-pair works — they cancel electromagnetic interference between pairs (crosstalk) by alternating the polarity along the cable's length. Untwist more than 0.5 inches at the connector and you've broken the noise rejection at gigabit and above. RJ45 pins are numbered 1–8 with the clip facing down and the contacts facing you, pin 1 on the left.

**T568A order:** white-green, green, white-orange, blue, white-blue, orange, white-brown, brown.
**T568B order:** white-orange, orange, white-green, blue, white-blue, green, white-brown, brown.

The only difference: pairs 2 and 3 (orange and green) are swapped. Pins 4, 5, 7, 8 are identical. Pins 1, 2, 3, 6 swap colors between the two standards.

**Beat 2 — Feynman example via your build.**

**The first cable:** You crimp a patch cable for your desk. You picked T568B because that's what the YouTube video used. You do both ends 568B. Plug it in — link light, gigabit, done. *Same standard both ends = straight-through cable = works.*

**The second cable:** You're running a drop from your room to the basement switch. You terminate the wall jack with T568A because the keystone has the A diagram printed on it and you followed it. You crimp the patch cable end with T568B because you forgot which one you used last time. Plug it in — no link, or 10 Mbps if you're unlucky. *Different standards on each end = crossover cable = no good for modern auto-MDIX devices when you didn't mean to make one.*

**The third cable:** You re-terminate the wall jack to T568B to match. Now both ends are B. Link comes back at gigabit. *The standard you pick doesn't matter. Consistency does.*

**The kicker:** Six months later you get gigabit on the desk but the link drops every time the AC kicks on. You re-terminate and discover you untwisted the pairs about an inch back from the plug. The crosstalk margin was zero, and any interference pushed it over. *Keep the twists right up to the connector. Untwist no more than half an inch.*

**Beat 3 — Bridge from your build to the enterprise.** Same question — which standard, both ends — scales up. In your house, one person picks one standard and sticks to it. In a 200-drop office build, the cable contractor picks a standard before they punch down a single jack, documents it, and every keystone, every patch panel, every patch cable in the building uses that standard. Most US enterprise installs use **T568B** by default. **T568A is the standard called out by US federal/government installs and most residential code.** Both work identically. What matters is the building picks one and the documentation says which.

**Beat 4 — The point.** Same fundamental question — "are both ends terminated the same way?" — with different right answers depending on what the site standardized on. Get this question into your bones. When you walk into a site and start troubleshooting cabling, the first thing you check after continuity is whether someone mixed standards on a re-termination. It happens constantly.

## Key facts

### The two standards, side by side

| Pin | T568A | T568B | Pair |
|---|---|---|---|
| 1 | White-Green | White-Orange | Pair 3 (A) / Pair 2 (B) |
| 2 | Green | Orange | Pair 3 (A) / Pair 2 (B) |
| 3 | White-Orange | White-Green | Pair 2 (A) / Pair 3 (B) |
| 4 | Blue | Blue | Pair 1 |
| 5 | White-Blue | White-Blue | Pair 1 |
| 6 | Orange | Green | Pair 2 (A) / Pair 3 (B) |
| 7 | White-Brown | White-Brown | Pair 4 |
| 8 | Brown | Brown | Pair 4 |

Pins 4, 5, 7, 8 are identical between the two. Pins 1, 2, 3, 6 swap. The blue pair always sits in the middle (pins 4–5). The brown pair always sits at the end (pins 7–8).

### Memorization shortcuts

- **T568B** starts with **O**range (white-orange, orange). Think "B for Big networks" — it's the one most US enterprises use.
- **T568A** starts with **G**reen (white-green, green). Think "A for America's government buildings" — federal spec calls for A.
- Both standards: **Blue and Brown stay put**. Only Green and Orange swap.

### Straight-through vs crossover

- **Straight-through cable** — both ends use the same standard (both A or both B). This is what you want 99% of the time. PC to switch, switch to router, AP to switch — all straight-through.
- **Crossover cable** — one end T568A, other end T568B. Historically used to connect two like devices directly: PC-to-PC, switch-to-switch, router-to-router. **Modern devices with Auto-MDIX (every gigabit device made in the last 15 years) detect and correct the wiring automatically**, so crossover cables are largely obsolete. CompTIA still tests them.

### Termination tools and process

- **Crimper** — for putting RJ45 plugs on patch cables.
- **Punchdown tool (110 blade)** — for seating wires into keystone jacks and patch panels. The blade pushes the wire into the IDC (insulation displacement contact) slot and trims the excess in one motion.
- **Cable tester** — verifies pin-to-pin continuity end to end. Tells you if pin 1 on one end actually reaches pin 1 on the other end and that no pairs are split or shorted.
- **Process for a patch cable:** strip jacket ~1 inch, untwist pairs, arrange in chosen order, trim flush, slide into RJ45 plug all the way to the front, verify all 8 wires are seated against the front of the plug, crimp.

### CompTIA exam traps

> **CompTIA exam trap:** "Which standard performs better, A or B?" — Neither. They're electrically identical. Both support gigabit and 10-gigabit at the same cable category. The only correct answer is "they perform the same; what matters is consistency at both ends."

> **CompTIA exam trap:** "Cable doesn't link at all" vs "Cable links but only at 100 Mbps." — No link usually means split pair, broken wire, or massively miswired plug. Linking at 100 instead of gigabit usually means **only pairs 2 and 3 are wired correctly** (pins 1, 2, 3, 6) and pairs 1 and 4 (pins 4, 5, 7, 8) are broken or miswired. 100BASE-T only uses pairs 2 and 3. Gigabit needs all four pairs.

> **CompTIA exam trap:** Crossover cable definition. They will give you a pin-out and ask "what kind of cable is this?" If one end is A and the other is B, it's a crossover. If both ends match, it's straight-through. Don't overthink it.

> **CompTIA exam trap:** "Which pair is in the middle on both standards?" — Blue (pins 4 and 5). The blue pair is the gimme answer. Brown is always pins 7 and 8. Memorize the constants and the variables become easier.

## In your build, at the office

**At home:** You probably have a mix of factory patch cables that are 568B, a wall plate someone terminated to A because the keystone diagram defaulted to A, and a homemade cable from that one time you needed a 25-footer. Half your "slow Wi-Fi" complaints are actually a flaky homemade cable. Re-terminate, test, document.

**In an enterprise environment, this changes:** every drop is documented in the cable plant database. Every patch panel port is labeled and mapped to a wall jack. The site standardized on one of A or B before construction started, and the cable contractor's certification report (Fluke or equivalent) is on file proving every run passes Cat6/6a spec. When you re-terminate, you re-terminate to the documented standard. You don't get to pick. If you mix standards on a re-termination, you've created a defect that will get caught the next time someone runs a cable certifier — and the ticket will come back to you.

## Helpdesk reality

- User: "My internet is slow." You check — they're at 100 Mbps on a gigabit switch port. The cable was re-terminated by someone who only got pins 1, 2, 3, 6 right. *Re-terminate to the site standard, test with a cable tester, verify gigabit link.*
- User: "I plugged a new cable in and now it doesn't work." Check both ends. If the cable is homemade or recently re-terminated, suspect mixed standards before suspecting the switch port.
- User: "Can you make me a longer cable?" Yes. Use the site standard at both ends. Test before handing it over. Never give a user an untested cable.
- Never promise a cable run will work until you've put a tester on it. "Looks right" is not "works right."
- Document every re-termination in the ticket. Note which jack, which panel port, which standard. The next tech inherits your work.

## Related concepts

[[Twisted Pair Cable Categories]] · [[RJ45 and RJ11 Connectors]] · [[Punchdown Blocks and Patch Panels]] · [[Plenum vs Riser vs Direct Burial Cable]] · [[Cable Testers and Crimpers]] · [[Auto-MDIX]] · [[Network Cable Troubleshooting]]

*Source: VIRGIL knowledge base — 2026-05-10*