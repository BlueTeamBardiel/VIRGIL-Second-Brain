# RFC Standards

## What it is
Think of RFCs like the building codes for the internet — a shared blueprint that every contractor (developer, vendor, engineer) agrees to follow so structures don't collapse when they connect. RFC (Request for Comments) documents are formal technical specifications published by the IETF that define protocols, procedures, and best practices governing how internet communication works — from TCP/IP to TLS to email.

## Why it matters
When an attacker exploits a protocol weakness — like the BEAST attack against SSL/TLS — defenders trace the vulnerability back to specific RFC specifications to understand *exactly* what the protocol allows and where it breaks. Security patches and hardening guides (like disabling TLS 1.0 per RFC 8996) cite RFC numbers precisely so engineers know which implementation to replace, not just that "encryption is bad."

## Key facts
- RFCs are numbered sequentially and never revised — if a standard changes, a *new* RFC is issued that *obsoletes* the old one (e.g., RFC 8446 obsoletes RFC 5246 for TLS 1.3)
- RFC 5280 defines the X.509 certificate standard used in PKI — directly relevant to HTTPS and certificate validation
- RFC 2617 defined HTTP Basic/Digest Authentication; RFC 7617 superseded it — understanding obsolete RFCs helps identify legacy vulnerabilities
- Not all RFCs are standards — categories include *Informational*, *Experimental*, *Best Current Practice (BCP)*, and *Standards Track*
- RFC 1918 defines private IP address ranges (10.x.x.x, 172.16-31.x.x, 192.168.x.x) — foundational knowledge for network segmentation and firewall rules

## Related concepts
[[PKI and Certificates]] [[TLS/SSL]] [[TCP/IP Model]] [[HTTP/HTTPS]] [[Network Protocols]]