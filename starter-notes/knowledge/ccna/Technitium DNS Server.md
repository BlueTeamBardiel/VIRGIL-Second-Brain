# Technitium DNS Server

## What it is
Like a librarian who not only finds books but keeps a detailed log of every patron request and lets you forge catalog entries for testing — Technitium is a self-hosted, open-source DNS server with a full web UI, built-in logging, and blocklist support. It gives administrators granular control over DNS resolution, forwarding, and zone management without depending on ISP or cloud-provider infrastructure.

## Why it matters
In a red team or home lab scenario, an attacker who has compromised internal DNS can redirect traffic silently — for example, poisoning an internal zone so that `bankingportal.corp` resolves to an attacker-controlled IP. Technitium is used defensively to implement DNS-over-HTTPS (DoH) or DNS-over-TLS (DoT), enforce response policy zones (RPZ) to block malware C2 domains, and audit every DNS query made on a network — making covert DNS tunneling much harder to hide.

## Key facts
- Supports **DNS-over-HTTPS (DoH)**, **DNS-over-TLS (DoT)**, and **DNS-over-QUIC**, all of which encrypt DNS traffic to prevent eavesdropping and manipulation
- Built-in **blocklist integration** allows importing threat intelligence feeds (e.g., public malware domain lists) to block resolution at the DNS layer
- Provides **full query logging** with per-client visibility — critical for detecting DNS tunneling (e.g., `iodine`, `dnscat2`) or data exfiltration via TXT records
- Can function as an **authoritative, recursive, or forwarder** DNS server, making it flexible for both isolated lab environments and production networks
- Runs on **Windows and Linux** via .NET, making it accessible for security labs without enterprise licensing costs

## Related concepts
[[DNS Poisoning]] [[DNS Tunneling]] [[DNS over HTTPS (DoH)]] [[Response Policy Zones (RPZ)]] [[Split-Horizon DNS]]
