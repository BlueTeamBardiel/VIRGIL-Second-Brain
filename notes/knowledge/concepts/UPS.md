# UPS

## What it is
Like a hospital generator that kicks in the moment city power fails, a UPS (Uninterruptible Power Supply) is a battery-backed device that provides emergency power to connected systems instantly — with zero gap — when the primary power source fails. Unlike a generator, it bridges the milliseconds-to-minutes window before backup power or clean shutdown occurs.

## Why it matters
During a targeted attack on a financial institution, an adversary cut external power to a data center to trigger emergency shutdowns, hoping unclean power-offs would corrupt RAID arrays and disrupt recovery. A properly sized UPS gave the operations team 15 minutes to execute graceful shutdowns and preserve data integrity — turning a potential catastrophic outage into a controlled event.

## Key facts
- UPS systems protect against four power threats: **surges, sags, outages, and line noise** — not just complete power loss
- Classified by topology: **Standby (basic)**, **Line-Interactive (most common)**, and **Online Double-Conversion (highest protection)** — Double-Conversion is preferred for critical systems
- A UPS is a **physical/environmental control** under the CIA triad, primarily protecting **Availability**
- UPS devices appear in **BCP/DR planning** as part of site resiliency; their runtime capacity must be documented in recovery plans
- UPS units themselves are attack surfaces — **network-managed UPS devices** have had critical CVEs (e.g., APC/Schneider TLStorm, 2022) allowing remote code execution and forced shutdowns

## Related concepts
[[Business Continuity Planning]] [[Redundancy]] [[Physical Security Controls]] [[Disaster Recovery]] [[Availability]]