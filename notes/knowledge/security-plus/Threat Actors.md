# Threat Actors

## What it is

In Final Fantasy VI, you face Ultros the purple octopus (a nuisance), Kefka (a nation-state-grade lunatic with a god-killing weapon), and the Imperial Army (a structured organization with budget, hierarchy, and logistics). Same heroes, vastly different threats — different motivations, different capabilities, different damage ceilings. That's exactly what **threat actors** are — the people or groups who attack systems, classified by who they are, why they attack, and how much firepower they can bring.

A **threat actor** is any entity — internal or external — responsible for an event that has impact on the security of an organization's information systems.

## Why it matters

Defenders allocate resources based on the threat. You don't deploy nation-state-grade detection to stop a curious teenager, and you don't rely on a firewall to stop an insider with admin credentials. Misclassify the actor, misallocate the defense, lose the asset. SY0-701 Objective 2.1 explicitly requires you to identify actor types, **attributes** (internal/external, resources/funding, sophistication/capability), and **motivations** (data exfiltration, espionage, service disruption, blackmail, financial gain, philosophical/political beliefs, ethical, revenge, disruption/chaos, war). The classic CompTIA trap: confusing a **hacktivist** (ideology) with an **organized crime** group (money), or assuming **insider threat** means malicious — it often means negligent.

## Key facts

### The actor taxonomy (memorize cold)

| Actor | Resources | Sophistication | Primary Motivation | Internal/External |
|---|---|---|---|---|
| [[Nation-state]] / [[APT]] | Massive | Very High | Espionage, war, disruption | External |
| [[Organized Crime]] | High | High | Financial gain | External |
| [[Hacktivist]] | Low–Medium | Variable | Philosophical/political | External |
| [[Insider Threat]] | Varies | Low–High | Revenge, financial, accidental | **Internal** |
| [[Script Kiddie]] / Unskilled Attacker | Very Low | Very Low | Chaos, ego | External |
| [[Shadow IT]] | Medium | Low–Medium | Convenience (not malicious) | **Internal** |

### Threat actor attributes (Objective 2.1 verbatim)

- **Internal vs. External** — insiders bypass perimeter controls by definition.
- **Resources/Funding** — determines persistence; a [[nation-state]] can wait years.
- **Level of sophistication/capability** — determines what tools they bring (custom [[zero-day]] exploits vs. downloaded scripts).

### Motivations (also verbatim from the objective)

**Data exfiltration · Espionage · Service disruption · Blackmail · Financial gain · Philosophical/political beliefs · Ethical · Revenge · Disruption/chaos · War**

The "ethical" motivation is the [[authorized hacker]] / [[bug bounty]] researcher — yes, CompTIA counts them as a threat actor type because they are still acting against a system.

### Actor-specific notes

- **[[Nation-state]] / [[Advanced Persistent Threat]]**: long dwell times, [[zero-day]] exploits, [[supply chain attack]] vectors. Examples: Stuxnet, SolarWinds. Goal is rarely "smash and grab" — it's persistence.
- **[[Organized Crime]]**: runs [[ransomware]]-as-a-service, banking trojans, [[business email compromise]]. Profit-driven, increasingly professionalized with help desks and SLAs (yes, really).
- **[[Hacktivist]]**: Anonymous, LulzSec lineage. Tools: [[DDoS]], website defacement, doxxing. Sophistication varies wildly.
- **[[Insider Threat]]**: split into **malicious** (disgruntled employee exfiltrating data) and **unintentional** (clicking the phishing link). The negligent insider causes more breaches than the malicious one.
- **[[Shadow IT]]**: employees spinning up unsanctioned SaaS, personal Dropbox for company files. Not malicious, but creates [[unmanaged asset]]s outside the security program.
- **Unskilled attacker** ([[script kiddie]]): downloads [[Metasploit]] modules, runs them, claims hacker status. Low capability, but volume makes them noisy.

### Threat vectors (how they get in — pairs with actors on the exam)

[[Message-based]] (email, SMS, IM) · [[Image-based]] · [[File-based]] · [[Voice call]] · [[Removable device]] · [[Vulnerable software]] (client-based vs. agentless) · [[Unsupported systems]] · [[Unsecure networks]] (wireless, wired, Bluetooth) · [[Open service ports]] · [[Default credentials]] · [[Supply chain]] (MSPs, vendors, hardware providers).

### CompTIA exam traps

1. "Insider threat" ≠ always malicious. Negligence counts.
2. "Hacktivist" motivation is **never** financial — if it's about money, it's [[organized crime]].
3. **APT** is a *behavior pattern* (persistent, advanced), almost always tied to nation-states, but the term describes the methodology, not the funding source.
4. **Shadow IT** is an internal threat *actor*, not an attack — the threat is the [[unmanaged attack surface]] it creates.

## Related concepts

[[Advanced Persistent Threat]] · [[Threat Intelligence]] · [[Insider Threat]] · [[Supply Chain Attack]] · [[Social Engineering]] · [[Zero-day]] · [[Threat Modeling]] · [[MITRE ATT&CK]]

---
*Source: VIRGIL knowledge base — 2026-05-08*