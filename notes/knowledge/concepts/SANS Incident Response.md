# SANS Incident Response

## What it is
Like a hospital trauma team that follows a precise protocol — airway, breathing, circulation — regardless of which patient rolls in, the SANS IR framework gives responders a structured sequence to follow when a breach occurs. It is a six-phase incident response methodology developed by SANS Institute: **Preparation, Identification, Containment, Eradication, Recovery, and Lessons Learned** (remembered as **PICERL**).

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations that had mature IR plans (aligned with frameworks like SANS) were able to rapidly identify the malicious Orion updates, isolate affected systems, and begin eradication within days — while unprepared organizations took weeks just to confirm the scope of compromise. The structured approach prevents responders from jumping straight to eradication before fully scoping the threat, which often causes attackers to re-establish footholds.

## Key facts
- **6 phases in order:** Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned
- **Containment has two sub-types:** short-term (isolate now, accept some damage) and long-term (fix root cause before full restoration)
- **Identification** is where indicators of compromise (IoCs) are confirmed — distinguishing a true positive from a false positive
- **Lessons Learned** (sometimes called Post-Incident Activity) must be documented within a formal report; it is not optional cleanup
- SANS IR closely parallels **NIST SP 800-61** but uses 6 phases vs. NIST's 4 (NIST combines Containment/Eradication/Recovery into one phase)

## Related concepts
[[NIST Incident Response]] [[Chain of Custody]] [[Indicators of Compromise]] [[Tabletop Exercise]]