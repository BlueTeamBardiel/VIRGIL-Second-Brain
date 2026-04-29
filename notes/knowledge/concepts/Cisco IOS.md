# Cisco IOS

## What it is
Think of it as the brain stem of a Cisco router or switch — not glamorous, but everything vital runs through it. Cisco IOS (Internetwork Operating System) is the proprietary firmware and operating system embedded in most Cisco networking devices, responsible for routing, switching, and managing network traffic through a command-line interface.

## Why it matters
In 2015, researchers demonstrated "SYNful Knock," a sophisticated attack where threat actors replaced legitimate Cisco IOS images with backdoored firmware — giving persistent, nearly invisible access to core routing infrastructure across multiple countries. This attack illustrated that compromising the OS of a router is far more dangerous than compromising an endpoint, because all traffic flows through it and detection is extremely difficult.

## Key facts
- Cisco IOS uses a **privileged EXEC mode** (enabled via the `enable` command) that provides full administrative access — a prime target for attackers who gain CLI access
- **IOS images should be verified with MD5/SHA-512 hashes** against Cisco's published values before deployment to detect tampering or supply chain compromise
- Unpatched Cisco IOS vulnerabilities (e.g., CVE-2017-6736) have been exploited by nation-state actors, making patch management critical for network infrastructure
- **AAA (Authentication, Authorization, Accounting)** integrated with TACACS+ or RADIUS is the recommended hardening approach for controlling IOS device access
- Cisco IOS differs from **IOS XE** and **IOS XR** — XE runs on a Linux kernel, making it relevant to different vulnerability classes and attack surfaces

## Related concepts
[[Network Device Hardening]] [[AAA Authentication]] [[Firmware Integrity Verification]]