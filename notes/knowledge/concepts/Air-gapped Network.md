# Air-gapped Network

## What it is
Like a medieval castle with its drawbridge permanently raised and moat filled — no physical path in or out — an air-gapped network is a system completely isolated from all external networks, including the internet and other internal networks. The "air gap" means there is literally no wired or wireless connection bridging the secure system to anything outside it.

## Why it matters
In 2010, the Stuxnet worm famously defeated an air gap at Iran's Natanz nuclear facility by spreading via infected USB drives carried by unsuspecting personnel. This demonstrated that air gaps are a strong but not absolute control — human behavior and removable media remain the primary attack vectors, making physical access controls and media policies critical companion defenses.

## Key facts
- Air-gapped systems represent the **highest tier of network isolation** and are used for critical infrastructure, nuclear systems, classified government networks, and industrial SCADA environments
- The primary attack vector against air gaps is **removable media** (USB drives, optical discs), making strict media control policies essential
- **Acoustic, electromagnetic, and thermal covert channels** (e.g., "AirHopper," "Fansmitter") are research-proven techniques for exfiltrating data without physical media — relevant to advanced threat modeling
- Air gaps are a form of **physical segmentation**, distinct from logical segmentation (VLANs, firewalls), which can still be bypassed through software
- For Security+/CySA+: air-gapped networks appear in questions about **defense-in-depth**, **data classification**, and mitigating **APT (Advanced Persistent Threat)** intrusions

## Related concepts
[[Network Segmentation]] [[Defense in Depth]] [[Advanced Persistent Threat]] [[Removable Media Controls]] [[SCADA Security]]