# SANS Incident Response Process

## What it is
Like a firefighter's drill — preparation before the blaze, contain the fire before it spreads, extinguish it, then investigate the cause and rebuild — the SANS Incident Response Process is a structured six-phase methodology for detecting, containing, and recovering from security incidents. It provides organizations a repeatable playbook to minimize damage and restore operations systematically.

## Why it matters
During the 2017 NotPetya attack, organizations without a rehearsed IR process took weeks longer to recover than those with defined containment and eradication procedures. A team following SANS methodology could isolate infected segments (Containment) before wiping and reimaging systems (Eradication), rather than scrambling without direction while ransomware continued spreading laterally.

## Key facts
- The six phases are: **Preparation, Identification, Containment, Eradication, Recovery, and Lessons Learned** (mnemonic: **PICERL**)
- **Preparation** is the most critical phase — includes building IR plans, training teams, and deploying detection tooling *before* an incident occurs
- **Containment** has two sub-types: *short-term* (isolate immediately to stop bleeding) and *long-term* (stable environment for investigation)
- **Lessons Learned** must occur within two weeks of incident closure and produces a formal after-action report — this feeds directly back into Preparation
- SANS differs from NIST's four-phase model (Preparation → Detection & Analysis → Containment/Eradication/Recovery → Post-Incident Activity) by splitting steps more granularly — both are tested on CySA+

## Related concepts
[[NIST Incident Response Lifecycle]] [[Chain of Custody]] [[Indicators of Compromise]] [[Tabletop Exercises]]