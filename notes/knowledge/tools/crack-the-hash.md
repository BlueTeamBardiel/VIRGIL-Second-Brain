# Crack The Hash

TryHackMe room focused on identifying and cracking various hash types. Covers hash identification techniques, common hashing algorithms, and cracking methodologies.

## What Is It? (Feynman Version)

A hash is like a fingerprint for a piece of data: you press a fixed‑size stamp onto a document, and the stamp is always the same for that document but never the same for a different one. Unlike a photograph, you can’t reconstruct the original document from the stamp, but you can see if two documents match by comparing stamps.

## Why Does It Exist?

Businesses store passwords as hashes to avoid keeping the real passwords in plain text. If a database leaks, the attacker can’t immediately log in; they must guess the password and compute its hash until it matches one stored in the database. This process turns a simple lookup into a computationally hard problem, buying time for defenders to lock accounts or detect breaches.

## How It Works (Under The Hood)

1. **Input** – User provides a password (plain text).  
2. **Transformation** – A hashing algorithm (MD5, SHA‑1, SHA‑256, etc.) processes the input in fixed‑size blocks, mixing the bits through mathematical functions.  
3. **Output** – A fixed‑length hexadecimal string (the hash).  
4. **Storage** – The hash is stored; the original password is discarded.  
5. **Verification** – When a user logs in, the system hashes the supplied password and compares the result with the stored hash. If they match, access is granted.

Cracking tools reverse step 3 by guessing passwords (dictionary, brute force, or rainbow tables) and comparing the resulting hashes to the target. If a match is found, the attacker knows the original password.

## What Breaks When It Goes Wrong?

- **Password reuse**: Users who reuse simple passwords across services enable attackers to crack one hash and immediately compromise many accounts.  
- **Weak hashing (MD5, SHA‑1)**: These algorithms have collisions and are fast; attackers can generate millions of hashes per second, turning the process into a brute‑force attack.  
- **Lack of salting**: Without a random salt, identical passwords produce identical hashes, exposing a rainbow table attack vector and allowing mass password recovery.  
- **Data breach**: If an attacker obtains a database of salted hashes, they can still spend computational resources to recover each password, potentially leading to credential stuffing attacks on other sites.

The first sign of failure is often a spike in failed login attempts or a sudden audit alert that a password database has been exfiltrated.

## Lab Relevance

| Task | Tool / Command | What to Watch For |
|------|----------------|-------------------|
| Identify hash type | `hash-identifier` | Output format; ambiguous hashes may require manual inspection |
| Crack a simple hash | `hashcat -m 0 hash.txt wordlist.txt` | Progress meter; time estimate; high hash rate indicates weak algorithm |
| Use rainbow tables | `rtgen md5 128 64 -o rainbow.txt` | Table size; collision handling; storage space |
| Brute‑force attack | `john --format=raw-sha256 --wordlist=passwords.txt --incremental=ASCII target.txt` | CPU/GPU load; possible throttling |
| Verify success | `grep -a -o -i "[A-Fa-f0-9]\{32\}" hash.txt` | Correct match; check against known password |

In a home lab, you can set up a simple SQLite database with hashed passwords, then use `hashcat` or `John the Ripper` against it. Pay attention to hash rates: if they are in the billions per second, the algorithm is too weak for real‑world use.

## Overview
This room teaches hash identification and cracking skills, essential for penetration testing and security analysis. Participants learn to recognize different hash formats and use appropriate tools to crack them.

## Topics Covered
- Hash identification and analysis
- Common hash types ([[MD5]], [[SHA-1]], [[SHA-256]], etc.)
- Hash cracking tools and techniques
- Rainbow tables and dictionary attacks
- Brute force methodologies

## Tools & Concepts
- [[Hashcat]]
- [[John the Ripper]]
- [[Hash-identifier]]
- [[Online hash lookup databases]]
- [[Dictionary attacks]]
- [[Brute force]]
- [[Rainbow tables]]

## Learning Path
Part of TryHackMe's fundamental security training for hash analysis and offline password recovery techniques.

## Tags
#tryhackme #hashing #cryptography #password-cracking #penetration-testing

---  
_Ingested: 2026-04-15 20:48 | Source: https://tryhackme.com/room/crackthehash_