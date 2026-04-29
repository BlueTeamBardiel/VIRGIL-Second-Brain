# Industrial Control Systems

## What it is
Think of a factory floor where a thermostat doesn't just control your bedroom temperature — it controls a blast furnace running at 3,000°F, and the wrong setting kills people. Industrial Control Systems (ICS) are networked hardware and software systems that monitor and control physical processes in critical infrastructure like power grids, water treatment plants, and manufacturing facilities. They include subsets like SCADA (Supervisory Control and Data Acquisition), DCS (Distributed Control Systems), and PLCs (Programmable Logic Controllers).

## Why it matters
In 2021, an attacker accessed the Oldsmar, Florida water treatment plant via remote desktop and briefly raised sodium hydroxide levels to 111 times the safe limit — a direct ICS manipulation that could have poisoned thousands. This incident demonstrated that ICS environments, often designed for reliability over security and running decades-old software, are high-value targets with life-safety consequences. Defenders must prioritize network segmentation between IT and OT (Operational Technology) networks to limit lateral movement.

## Key facts
- **Purdue Model** (ISA-99) defines ICS architecture in zones: Level 0 (physical devices) through Level 4 (enterprise IT), with the DMZ separating IT from OT
- **Stuxnet** (2010) was the first known ICS cyberweapon, targeting Siemens PLCs to destroy Iranian uranium centrifuges by manipulating rotor speeds
- ICS protocols like **Modbus**, **DNP3**, and **BACnet** were designed without authentication or encryption — they assume physical security
- **Air gaps** are commonly cited as ICS defenses but are frequently bridged by USB drives, vendor laptops, or misconfigured firewalls
- NIST SP 800-82 is the primary guidance document for ICS/OT security, distinct from general enterprise security frameworks

## Related concepts
[[SCADA Systems]] [[Operational Technology Security]] [[Network Segmentation]] [[Purdue Model]] [[Critical Infrastructure Protection]]