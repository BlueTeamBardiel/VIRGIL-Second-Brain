# Sequence Numbers

## What it is
Like a postal service that stamps each envelope with a sequential number so the recipient can detect missing or reordered packages, TCP sequence numbers are 32-bit values embedded in every segment to track byte order and ensure reliable, in-order delivery. Each side of a TCP connection initializes with an Initial Sequence Number (ISN) and increments it with every byte transmitted, allowing the receiver to reconstruct data correctly and detect missing segments.

## Why it matters
Predictable sequence numbers are the critical weakness exploited in **TCP session hijacking**. If an attacker can guess the next expected sequence number — because the OS generates ISNs in a non-random pattern — they can inject forged packets into an established connection, impersonating a legitimate host without completing the three-way handshake. Modern OSes use cryptographically random ISNs specifically to defeat this attack.

## Key facts
- ISNs should be **cryptographically random**; historically, systems like older BSD used predictable counters, enabling the famous 1994 Mitnick attack against Shimomura
- TCP sequence numbers are **32-bit**, rolling over to 0 after ~4.3 billion bytes
- Sequence numbers enable **blind spoofing attacks** when an attacker is off-path but can predict the ISN
- The **three-way handshake** (SYN → SYN-ACK → ACK) is where ISNs are exchanged and synchronized between client and server
- RFC 6528 formalizes the requirement for randomized ISNs to mitigate off-path injection attacks

## Related concepts
[[TCP Three-Way Handshake]] [[Session Hijacking]] [[Blind Spoofing]] [[TCP/IP Stack Fingerprinting]]