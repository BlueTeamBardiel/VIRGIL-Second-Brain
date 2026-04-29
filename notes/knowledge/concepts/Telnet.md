# Telnet

## What it is
Imagine shouting your username, password, and every command across a crowded room — everyone can hear every word. Telnet is exactly that: a plaintext remote terminal protocol (TCP port 23) that allows a user to log in and execute commands on a remote host with zero encryption protecting the session.

## Why it matters
In penetration tests and real breaches, attackers running Wireshark on a network segment containing a legacy Telnet-enabled router or switch can capture administrator credentials in seconds — no cracking required, just read the packet capture. This is why PCI-DSS explicitly prohibits Telnet for accessing cardholder data environments and mandates SSH as the replacement. Finding an open port 23 during a vulnerability scan is an immediate critical finding.

## Key facts
- Telnet operates on **TCP port 23** and transmits all data — including credentials — in **cleartext**
- Developed in **1969**, it predates the modern threat model entirely; security was never a design goal
- **SSH (port 22)** is the direct, encrypted replacement and is considered the industry-standard swap
- Telnet is commonly used as a **banner-grabbing tool** by attackers (`telnet <host> <port>`) to fingerprint services even when not used for remote login
- Detecting active Telnet services is a standard finding in **network vulnerability scans** (Nessus, OpenVAS); its presence often indicates outdated or unpatched infrastructure

## Related concepts
[[SSH]] [[Cleartext Protocols]] [[Banner Grabbing]] [[Port Scanning]] [[Network Sniffing]]