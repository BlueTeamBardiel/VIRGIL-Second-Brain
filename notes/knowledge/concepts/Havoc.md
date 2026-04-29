# Havoc

## What it is
Like Cobalt Strike's rebellious open-source cousin built in a garage, Havoc is a modern Command and Control (C2) framework written in Go and Qt that provides adversaries with a full post-exploitation platform. It gives attackers a slick GUI dashboard to manage compromised "agents" (called Demons), issue commands, and coordinate lateral movement across victim networks.

## Why it matters
In 2023, threat actors were observed deploying Havoc alongside SharePoint phishing lures to drop the Demon implant on corporate endpoints, bypassing many EDR solutions by leveraging indirect syscalls and sleep obfuscation techniques. Defenders must specifically tune behavioral detections for Havoc's unique network traffic patterns — including its custom encrypted C2 profile — because signature-based AV often misses it entirely.

## Key facts
- **Demon implant** is Havoc's agent payload; it supports injection, token manipulation, SOCKS proxying, and file operations from a centralized Teamserver
- Uses **indirect syscalls** to evade EDR hooks in ntdll.dll — a key anti-analysis technique that bypasses userland API monitoring
- Written in **C and Go**; the Teamserver runs on Linux while operators connect via a cross-platform Qt GUI
- Supports **malleable C2 profiles**, allowing operators to disguise beacon traffic as legitimate HTTPS traffic to blend with normal web activity
- Classified as a **dual-use offensive security tool**; it is open-source on GitHub, making it freely accessible to both red teams and real threat actors alike

## Related concepts
[[Cobalt Strike]] [[Command and Control (C2)]] [[EDR Evasion]] [[Syscall Hijacking]] [[Post-Exploitation Frameworks]]