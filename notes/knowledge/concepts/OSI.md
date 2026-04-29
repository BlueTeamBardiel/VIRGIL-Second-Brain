# OSI

## What it is
Like a postal system where your letter passes through sorting facilities, trucks, and local carriers — each layer handles its job without caring how the others work — the OSI model is a 7-layer conceptual framework that standardizes how network communication is broken down, transmitted, and reassembled. Each layer has a defined role: from physical bit transmission up through application-level data presentation.

## Why it matters
When analyzing a DDoS attack, understanding OSI layers tells you *exactly* what's being targeted: a SYN flood hammers Layer 4 (Transport), while an HTTP flood targets Layer 7 (Application) — and the defense tools differ completely. A Layer 4 attack can be mitigated by stateful firewalls, but a Layer 7 attack requires a WAF that can inspect HTTP semantics. Misdiagnosing the layer means deploying the wrong countermeasure.

## Key facts
- **Layer 7 (Application):** HTTP, DNS, SMTP — where most web attacks occur
- **Layer 4 (Transport):** TCP/UDP — SYN floods, port scanning, and firewalls operate here
- **Layer 3 (Network):** IP addressing and routing — IP spoofing and ACLs live at this layer
- **Layer 2 (Data Link):** MAC addresses — ARP poisoning and MAC flooding attacks target this layer
- **Layer 1 (Physical):** Actual bits on wire/radio — physical tapping or jamming attacks occur here
- Security tools map to layers: IDS/IPS typically inspect Layers 3–7; switches operate at Layer 2; routers at Layer 3

## Related concepts
[[TCP/IP Model]] [[Firewall]] [[WAF]] [[ARP Poisoning]] [[DDoS]]