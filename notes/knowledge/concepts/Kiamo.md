# Kiamo

## What it is
Like a master key that silently copies itself onto every USB drive plugged into an infected machine, Kiamo is a worm that propagates through removable media. Specifically, Kiamo is a malware family (also tracked as a variant related to the Conficker/Autorun worm ecosystem) that spreads via USB devices by dropping copies of itself and leveraging Windows AutoRun functionality to execute automatically when media is inserted.

## Why it matters
In air-gapped industrial or government environments — where internet-based delivery is blocked — Kiamo-style removable media worms remain a primary infection vector. An attacker pre-infects a USB drive, leaves it in a parking lot (a physical social engineering tactic), and when an employee plugs it in, the worm silently copies itself to the host system and all subsequent USB devices inserted, laterally spreading across a facility with no network connectivity required.

## Key facts
- Kiamo spreads by writing itself to the root of USB/removable drives and creating an **autorun.inf** file that triggers execution on insertion
- Microsoft disabled AutoRun for non-optical media by default beginning with **Windows 7 / KB971029** patch, directly countering this propagation method
- Kiamo-style worms often drop additional payloads (keyloggers, RATs) after initial infection, making them a **dropper + spreader** hybrid
- Detection relies on monitoring for **autorun.inf creation events** on removable drives and endpoint behavioral analysis
- Disabling AutoPlay/AutoRun via **Group Policy (GPO)** is the primary hardening countermeasure in enterprise environments

## Related concepts
[[Removable Media Attacks]] [[AutoRun Exploitation]] [[Worm Propagation]] [[Air-Gap Attack Vectors]] [[Dropper Malware]]