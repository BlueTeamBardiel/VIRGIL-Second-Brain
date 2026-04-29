# Turla

## What it is
Imagine a ghost that hijacks someone else's getaway car rather than stealing its own — that's Turla in a nutshell. Turla is a Russian state-sponsored advanced persistent threat (APT) group, also known as Snake or Uroburos, believed to operate under the FSB (Federal Security Service). They are renowned for using other threat actors' already-compromised infrastructure as a launchpad, making attribution extraordinarily difficult.

## Why it matters
In 2019, the UK's NCSC and NSA publicly revealed that Turla had hijacked the command-and-control infrastructure of Iranian APT group OilRig, essentially piggybacking on a rival nation's espionage operation to target Middle Eastern governments. This "fourth-party collection" technique means defenders can't simply block a known adversary's IP ranges — the real attacker may be hiding inside another attacker's tooling.

## Key facts
- Active since at least 2004; one of the longest-running APT operations on record
- Signature malware includes **Snake/Uroburos** (kernel-level rootkit), **Carbon**, **Kazuar**, and **ComRAT** — all custom-built, highly modular implants
- Known for **satellite-based C2 communication**: hijacking satellite internet uplinks to receive commands, making traffic nearly impossible to geo-locate
- Primary targets include government ministries, military organizations, diplomatic embassies, and defense contractors — classic espionage objectives
- Employs **living-off-the-land (LotL)** techniques alongside custom malware, using PowerShell and WMI to blend into normal system activity and evade endpoint detection

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Command and Control (C2)]] [[Living Off the Land (LotL)]] [[Attribution]] [[Rootkit]]