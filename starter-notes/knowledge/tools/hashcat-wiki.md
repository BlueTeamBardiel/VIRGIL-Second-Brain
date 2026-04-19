# Hashcat Wiki

Hashcat is the world's fastest and most advanced password recovery utility, offering multiple attack modes and a comprehensive suite of related tools for advanced password cracking.

## Overview

**Hashcat** is a GPU-accelerated password cracking framework that supports numerous hash types and attack methodologies. The project includes several companion utilities for password candidate generation and analysis.

## Hashcat Suite

- [[hashcat]] - Core password recovery utility
- [[hashcat-utils]] - Small utilities for advanced password cracking
- [[maskprocessor]] - High-performance word generator with per-position charset configuration
- [[statsprocessor]] - Word generator based on Markov chains
- [[princeprocessor]] - Standalone password candidate generator using PRINCE algorithm
- [[kwprocessor]] - Advanced keyboard-walk generator

## Core Attack Modes

- **Dictionary Attack** (mode 0, -a 0) - Trying words from a list; also called "straight" mode
- **Combinator Attack** (-a 1) - Concatenating words from multiple wordlists
- **Brute-force / Mask Attack** (mode 3, -a 3) - Trying all characters from charsets per position
- **Hybrid Attack** (-a 6, -a 7) - Combining wordlists with masks; can use rules
- **Association Attack** (-a 9) - Using usernames, filenames, hints to attack specific hashes
- **Rule-based Attack** - Applying transformation rules to wordlist words
- **Toggle-case Attack** - Toggling character case (now via rules)

## Important Documentation

- Example hashes and hash format guidance
- Brute-force and mask attack guides
- WPA/WPA2 cracking methodology
- [[HCCAPX]] format description
- Job resumption and .restore file format
- Machine-readable output usage
- Distributing work across systems
- Hash type categories

## Common Resources

- Password cracking cheat-sheets and guides
- GPU rig building tutorials
- Video introductions and conference presentations
- Practical case studies and cracking stories

## Limitations

**Note:** Hashcat cannot be used to recover online accounts (Gmail, Instagram, Facebook, Twitter, etc.), as it has no mechanism for attacking live online services.

## Tags

#password-cracking #hashcat #gpu-acceleration #penetration-testing #security-tools

---
_Ingested: 2026-04-15 20:48 | Source: https://hashcat.net/wiki/_
