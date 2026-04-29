# Air-gapping

## What it is
Like a surgeon removing a patient from life support and wheeling them into a sealed operating room with no outside connections, air-gapping physically isolates a computer or network by removing all wired and wireless links to untrusted networks. Precisely defined: an air-gapped system has zero network interfaces connected to external systems, making it reachable only through physical media or direct console access.

## Why it matters
Stuxnet, the malware targeting Iranian nuclear centrifuges at Natanz, demonstrated that air gaps are not impenetrable — infected USB drives bridged the gap and delivered a payload that physically destroyed industrial equipment. This real-world attack established that air-gapped systems still require strict removable media controls, supply chain verification, and insider threat programs to remain secure.

## Key facts
- Air-gapping is a physical security control, not a logical one — it fails the moment a USB drive, SD card, or compromised vendor laptop crosses the boundary
- Classified government networks (e.g., NSA's SIPRNET vs. NIPRNET) use air-gapping combined with mandatory access controls as a defense-in-depth layer
- Researchers have demonstrated covert exfiltration from air-gapped machines using acoustic signals (fanspeed modulation), electromagnetic emissions, and even heat fluctuations — demonstrating that "no network" ≠ "no data leakage"
- Air-gapped environments require out-of-band patch management, typically via cryptographically signed, manually verified removable media
- SCADA and ICS environments commonly air-gap operational technology (OT) networks from corporate IT networks to prevent lateral movement affecting physical processes

## Related concepts
[[Physical Security Controls]] [[SCADA/ICS Security]] [[Removable Media Controls]] [[Defense in Depth]] [[Insider Threat]]