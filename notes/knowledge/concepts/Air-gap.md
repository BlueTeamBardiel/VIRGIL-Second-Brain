# Air-gap

## What it is
Like a drawbridge with no rope on the other side — a system physically isolated from all external networks has no pathway for remote attackers to cross. An air-gap is a security measure where a computer or network is kept completely physically isolated from unsecured networks, including the internet, by ensuring there are no wired or wireless connections of any kind.

## Why it matters
Stuxnet (discovered 2010) famously defeated an air-gapped Iranian nuclear facility at Natanz by traveling via infected USB drives carried by insiders — the malware then destroyed uranium enrichment centrifuges without ever needing internet access. This demonstrated that air-gaps are a physical security control, not a magic barrier: the human element remains the attack surface.

## Key facts
- Air-gapped systems are still vulnerable to **sneakernet attacks** — data transferred via physical media (USB, DVD, removable drives) by authorized personnel
- Researchers have demonstrated **covert channel attacks** that exfiltrate data across air-gaps using heat emissions (BitWhisper), acoustic signals, electromagnetic radiation, and even LED blinking patterns
- Air-gapping is a form of **network segmentation** taken to its physical extreme — it satisfies the isolation requirement of defense-in-depth
- Common in **classified government systems (SCIFs)**, industrial control systems (SCADA/ICS), and payment card processing environments
- Even air-gapped systems require strict **media control policies** (e.g., scanning all removable media before use) to be effective — the gap alone is insufficient

## Related concepts
[[Network Segmentation]] [[Defense in Depth]] [[SCADA/ICS Security]] [[Covert Channels]] [[Physical Security]]