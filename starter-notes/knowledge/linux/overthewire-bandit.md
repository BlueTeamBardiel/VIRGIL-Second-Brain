# OverTheWire Bandit

Bandit is a beginner-friendly [[wargame]] that teaches fundamental [[Linux]] command-line skills through progressive levels. Designed for absolute beginners, it provides the foundational knowledge needed to tackle more advanced security challenges.

## Overview

- **Purpose**: Teach basics of command-line usage and Linux fundamentals
- **Structure**: Progressive levels (Level 0 onwards)
- **Difficulty**: Beginner-friendly
- **Format**: Each level provides credentials and objectives to reach the next level

## Learning Approach

When stuck:
1. Consult [[man]] pages: `man <command>`
2. Use shell built-in help: `help <command>`
3. Search online (Google recommended)
4. Join OverTheWire chat for community support

## Getting Started

- Begin at Level 0 (linked from sidebar)
- Read instructions for each level before attempting
- Expect to encounter unfamiliar concepts—this is intentional learning
- Understand that reading documentation is part of the skill-building process

## Connection Issues

VMs experiencing "broken pipe error" over [[SSH]]:
- Add `IPQoS throughput` to `/etc/ssh/ssh_config`
- If unresolved, switch network adapter from NAT to Bridged mode

## Tags

#wargame #linux #beginners #ctf #overthewire #command-line

---
_Ingested: 2026-04-15 20:22 | Source: https://overthewire.org/wargames/bandit/_
