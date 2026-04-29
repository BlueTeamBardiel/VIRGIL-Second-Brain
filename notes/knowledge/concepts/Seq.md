# Seq

## What it is
Like a postal worker stamping each envelope with an incrementing number so the recipient knows if any letters were lost or arrived out of order — a **sequence number** (Seq) is a 32-bit field in the TCP header that tracks the byte position of the first byte of data in a segment. It enables reliable, ordered delivery by letting the receiver detect gaps, duplicates, and reordering.

## Why it matters
Attackers exploit predictable sequence numbers in **TCP session hijacking** attacks. If an adversary can guess or sniff the sequence number of an established TCP session, they can inject forged packets that the receiver accepts as legitimate — effectively stealing the session without needing the original credentials. This was the mechanism behind the famous Kevin Mitnick attack on Tsutomu Shimomura in 1994, where predictable ISNs (Initial Sequence Numbers) enabled blind spoofing.

## Key facts
- **ISN (Initial Sequence Number)** is chosen during the TCP three-way handshake (SYN); modern OSes randomize ISNs to prevent prediction attacks
- Sequence numbers increment by the **number of bytes sent**, not by packet count — sending 500 bytes advances the Seq by 500
- **TCP sequence prediction attacks** are mitigated by RFC 6528, which mandates cryptographically random ISN generation
- Wireshark displays **relative sequence numbers** by default (starting at 0) to aid human readability; raw values can be in the billions
- **Out-of-order or missing sequence numbers** are a key indicator analysts use in IDS/PCAP analysis to detect fragmentation attacks or evasion attempts

## Related concepts
[[TCP Three-Way Handshake]] [[Session Hijacking]] [[TCP SYN Flood]] [[Packet Analysis]] [[Blind Spoofing]]