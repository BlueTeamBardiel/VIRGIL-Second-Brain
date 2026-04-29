# Mirai Botnet

## What it is
Imagine an army of sleepwalking security cameras and DVRs — none of them aware they've been conscripted — all waiting for a single command to flood a target with traffic. Mirai is a self-propagating malware strain that compromises IoT devices running Linux by brute-forcing factory-default Telnet credentials, then enslaves them into a botnet capable of launching massive DDoS attacks. Unlike traditional botnets targeting PCs, Mirai's weapon of choice is the forgotten, never-patched thermostat or webcam sitting on your network.

## Why it matters
In October 2016, Mirai was weaponized against Dyn, a major DNS provider, knocking Twitter, Netflix, Reddit, and Spotify offline for millions of users across the U.S. East Coast. The attack demonstrated that insecure consumer IoT devices are a critical infrastructure liability — not just a personal privacy risk. Defenders learned that network segmentation of IoT devices and disabling default credentials are non-negotiable controls.

## Key facts
- Mirai's source code was publicly released in 2016, spawning dozens of variants (Hajime, Satori, Reaper) still active today
- It scans the internet on TCP ports **23 (Telnet)** and **2323**, attempting ~60 hardcoded default credential pairs
- Compromised bots receive commands via a C2 server using a custom binary protocol over TCP port **48101**
- The Dyn attack peaked at an estimated **1.2 Tbps**, making it the largest DDoS attack recorded at that time
- Mitigation focuses on: changing default credentials, disabling Telnet/UPnP, network segmentation (IoT VLAN), and ISP-level BCP38 filtering to block spoofed traffic

## Related concepts
[[DDoS Attack]] [[IoT Security]] [[Botnet C2 Infrastructure]] [[Default Credentials]] [[DNS Infrastructure Attacks]]