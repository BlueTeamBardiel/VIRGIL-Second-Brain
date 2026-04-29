# ICS

## What it is
Think of an ICS like the nervous system of a factory — it senses, decides, and acts on physical machinery the way your brain controls your hand. Formally, an Industrial Control System (ICS) is a broad category of control systems used to monitor and automate industrial processes such as power generation, water treatment, oil pipelines, and manufacturing. It encompasses technologies like SCADA, DCS, and PLCs that bridge the digital and physical worlds.

## Why it matters
In 2021, attackers gained remote access to the Oldsmar, Florida water treatment plant's ICS and attempted to raise sodium hydroxide levels to 111 times the safe limit — a direct threat to public health stopped only by an alert operator. This attack demonstrated that ICS vulnerabilities aren't theoretical; unpatched legacy systems exposed to the internet can have life-safety consequences that far exceed typical data breaches.

## Key facts
- ICS environments prioritize **availability over confidentiality** — the CIA triad is inverted; downtime can mean physical disaster
- Most ICS devices run **legacy operating systems** (Windows XP, older embedded firmware) that cannot be patched without vendor approval or process shutdown
- **Air-gapping** (physically isolating ICS networks from corporate IT and internet) is a primary defense strategy, though Stuxnet proved air gaps can be bridged via USB
- The **Purdue Reference Model** (also called the ICS security model) organizes ICS into five levels, guiding network segmentation strategy — commonly tested on Security+
- ICS attacks can cause **kinetic damage**: Stuxnet physically destroyed Iranian uranium centrifuges by manipulating PLC logic while reporting normal readings

## Related concepts
[[SCADA]] [[PLC]] [[Operational Technology]] [[Network Segmentation]] [[Stuxnet]]