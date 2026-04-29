# Worms

## What it is
Like a biological tapeworm that reproduces inside a host and spreads to new hosts on contact, a computer worm is self-replicating malware that propagates across networks **without requiring human interaction or a host file**. Unlike viruses, worms carry their own execution engine and exploit vulnerabilities autonomously to move from system to system.

## Why it matters
In 2017, WannaCry exploited the EternalBlue vulnerability (MS17-010) in Windows SMB to spread across 200,000+ machines in 150 countries in under 72 hours — with zero user clicks required. Organizations that hadn't patched their systems or segmented their networks had no meaningful chokepoint to stop propagation, making network segmentation and aggressive patch management the primary defenses.

## Key facts
- Worms consume bandwidth and CPU as a **side effect of propagation**, often causing denial-of-service even before their payload executes
- The Morris Worm (1988) was the first recognized internet worm, crashing ~6,000 systems (~10% of the internet at the time)
- Worms spread via **network shares, email, removable media, and unpatched service vulnerabilities** (e.g., SMB, RDP)
- A worm's payload is separate from its propagation mechanism — it may carry ransomware, a backdoor, or nothing at all
- Key defense controls include **network segmentation, host-based firewalls, intrusion detection systems (IDS), and rapid vulnerability patching**

## Related concepts
[[Viruses]] [[Trojan Horses]] [[EternalBlue Exploit]] [[Ransomware]] [[Network Segmentation]]