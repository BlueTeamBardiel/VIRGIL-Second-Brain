# Parrot OS

## What it is
Think of it as a Swiss Army knife that came pre-assembled in a factory — every blade already sharpened and ready. Parrot OS is a Debian-based Linux distribution purpose-built for penetration testing, digital forensics, and privacy-focused computing, shipping with hundreds of pre-installed security tools out of the box. Unlike a general-purpose OS, every component is curated for offensive and defensive security workflows.

## Why it matters
During a red team engagement, an analyst needs to pivot quickly between network reconnaissance, password cracking, and anonymized communications without spending hours configuring dependencies. Parrot OS provides tools like Metasploit, Wireshark, Aircrack-ng, and Tor integration in a single bootable environment, letting a penetration tester spin up a live session from a USB drive on a target's premises without leaving artifacts on the host machine.

## Key facts
- **Two primary editions**: Security Edition (offensive/defensive tools) and Home Edition (privacy-focused, lightweight daily use)
- **Runs live from USB** without installation, which is critical for forensic investigations where preserving drive integrity is legally required
- **Built on Debian stable** with custom-hardened kernels and AppArmor profiles enabled by default — more privacy-hardened than Kali Linux out of the box
- **Lighter resource footprint** than Kali Linux (~320MB RAM minimum), making it viable on older or low-powered hardware during field engagements
- **Includes AnonSurf**, a tool that routes all system traffic through Tor with a single command, relevant for OSINT operations requiring identity concealment

## Related concepts
[[Kali Linux]] [[Penetration Testing]] [[Live Boot Forensics]] [[Metasploit Framework]] [[Network Reconnaissance]]