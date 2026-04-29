# CCTV

## What it is
Like a librarian who silently watches every aisle and records who touched which book, CCTV (Closed-Circuit Television) is a network of cameras whose video feeds are transmitted to a limited, private set of monitors or recorders — not broadcast publicly. Unlike broadcast TV, the signal stays within a controlled loop, making it a physical security control for monitoring and recording activity in specific locations.

## Why it matters
In a 2013 retail breach investigation, forensic teams used CCTV footage to confirm that an insider threat actor had physically accessed a server room after hours — corroborating log data that alone wouldn't have held up in court. CCTV bridges the gap between digital forensics and physical security, providing visual evidence that timestamps and access logs cannot fully replace.

## Key facts
- CCTV is classified as a **physical detective control** — it detects and records incidents but does not inherently prevent them (a deterrent effect is secondary)
- Modern IP-based CCTV cameras are network devices and therefore attack surfaces — default credentials and unpatched firmware have led to mass exploitation (e.g., Mirai botnet recruited thousands of cameras)
- **Retention policy** matters: many compliance frameworks (PCI-DSS, HIPAA) require footage to be stored for a defined period (often 90 days minimum) to support incident response
- CCTV placement falls under **crime prevention through environmental design (CPTED)** principles on Security+ objectives
- Footage integrity can be challenged in court if chain of custody is broken — tamper-evident storage and hashing of recordings strengthen admissibility

## Related concepts
[[Physical Security Controls]] [[Crime Prevention Through Environmental Design (CPTED)]] [[Mirai Botnet]] [[Defense in Depth]] [[Chain of Custody]]