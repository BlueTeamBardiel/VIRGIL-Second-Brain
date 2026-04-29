# Hashcat Wiki

Hashcat is the world's fastest and most advanced password recovery utility, offering multiple attack modes and a comprehensive suite of related tools for advanced password cracking.

## Overview

**Hashcat** is a GPU‑accelerated password cracking framework that supports numerous hash types and attack methodologies. The project includes several companion utilities for password candidate generation and analysis.

## Hashcat Suite

- [[hashcat]] - Core password recovery utility
- [[hashcat-utils]] - Small utilities for advanced password cracking
- [[maskprocessor]] - High‑performance word generator with per‑position charset configuration
- [[statsprocessor]] - Word generator based on Markov chains
- [[princeprocessor]] - Standalone password candidate generator using PRINCE algorithm
- [[kwprocessor]] - Advanced keyboard‑walk generator

## Core Attack Modes

- **Dictionary Attack** (mode 0, -a 0) – Trying words from a list; also called “straight” mode
- **Combinator Attack** (-a 1) – Concatenating words from multiple wordlists
- **Brute‑force / Mask Attack** (mode 3, -a 3) – Trying all characters from charsets per position
- **Hybrid Attack** (-a 6, -a 7) – Combining wordlists with masks; can use rules
- **Association Attack** (-a 9) – Using usernames, filenames, hints to attack specific hashes
- **Rule‑based Attack** – Applying transformation rules to wordlist words
- **Toggle‑case Attack** – Toggling character case (now via rules)

## Important Documentation

- Example hashes and hash format guidance
- Brute‑force and mask attack guides
- WPA/WPA2 cracking methodology
- [[HCCAPX]] format description
- Job resumption and .restore file format
- Machine‑readable output usage
- Distributing work across systems
- Hash type categories

## Common Resources

- Password cracking cheat‑sheets and guides
- GPU rig building tutorials
- Video introductions and conference presentations
- Practical case studies and cracking stories

## Limitations

**Note:** Hashcat cannot be used to recover online accounts (Gmail, Instagram, Facebook, Twitter, etc.), as it has no mechanism for attacking live online services.

## Tags

#password-cracking #hashcat #gpu-acceleration #penetration-testing #security-tools

---

## What Is It? (Feynman Version)

Imagine a mechanic who can try every possible key combination on a lock in the time it takes to brew a cup of coffee. Hashcat is that mechanic, but for digital locks: it takes a hashed password, knows the algorithm used to produce it, and rapidly tests billions of candidate passwords using a computer’s GPU cores until the original text password is found.

## Why Does It Exist?

Before Hashcat, cracking password hashes was a slow, CPU‑bound affair that could take months or never finish. The rise of GPU hardware, the explosion of encrypted data, and high‑profile breaches (e.g., the 2014 Ashley Madison leak) highlighted the need for a tool that could turn a powerful workstation into a password‑cracking super‑computer. Hashcat fills that gap, enabling security professionals to validate password strength, perform forensic recoveries, and stress‑test password policies efficiently.

## How It Works (Under The Hood)

1. **Hash Parsing** – Hashcat first identifies the hash type (MD5, NTLM, WPA‑PSK, etc.) and any embedded salts or iterations.  
2. **Candidate Generation** – Depending on the chosen attack mode, it creates a stream of password guesses:
   * *Dictionary* pulls raw words from a file.  
   * *Mask* builds strings position‑by‑position from defined character sets.  
   * *Hybrid* or *Rule‑based* transforms existing words through user‑supplied rules (e.g., append “1”, reverse).  
   * *Combinator* concatenates two wordlists pairwise.  
3. **GPU Kernel Execution** – Each guess is sent to the GPU in a block. The GPU hash kernel applies the relevant cryptographic algorithm to the guess, producing a hash value.  
4. **Comparison** – The produced hash is compared to the target hash(es). If a match occurs, the plaintext is reported.  
5. **Job Management** – Hashcat keeps state in a .restore file so that long jobs can be paused and resumed. It also splits workloads across multiple GPUs or machines if configured.

## What Breaks When It Goes Wrong?

- **Resource Overcommitment** – A misconfigured mask (e.g., 10‑character full‑ASCII) can exhaust GPU memory and stall the entire job, costing time and power.  
- **Incorrect Hash Type** – Using the wrong hash mode misinterprets the input, leading to endless loops with no hits, wasting effort and potentially exposing sensitive data to logging.  
- **Misused Rules** – Aggressive rule sets can generate millions of useless candidates, overwhelming I/O and network logs, and causing false positives in monitoring systems.  
- **Unprotected Hash Dumps** – If the hash file is not securely handled, attackers can retrieve the dump and perform offline cracking themselves, compromising any compromised accounts.

## Lab Relevance

| Lab Setup | Command Example | What to Watch For |
|-----------|-----------------|-------------------|
| Single GPU rig | `hashcat -m 0 -a 3 -o found.txt example.hash ?a?a?a?a?a` | Watch GPU memory usage (`nvidia-smi`) and ensure the mask doesn’t exceed 128 GB per GPU. |
| Distributed across 2 machines | `hashcat -m 1000 -a 6 -r rules/best64.rule example.hash wordlist.txt ?d` | Verify the `-d` option (device selection) and monitor network bandwidth if the hash list is streamed over SSH. |
| WPA‑PSK cracking | `hashcat -m 2500 -a 0 -w 4 example.hccapx rockyou.txt` | Check that the `hccapx` file was captured correctly; missing handshakes mean a 0% success rate. |

- **Hands‑On Tip**: Use the `--status-timer=60` flag to get a live update every minute; this helps spot stalls early.  
- **Break‑Point**: If the job stalls on a particular mask, try simplifying the character set or reduce the length; large masks can hit the GPU’s instruction cache limit.  
- **Security Note**: Always run Hashcat inside a virtualized or isolated container to prevent accidental exposure of password files to the host OS.