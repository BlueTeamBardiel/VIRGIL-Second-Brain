# XMPP

## What it is
Think of XMPP like a postal system where every address looks like an email (user@domain.com), but instead of letters arriving hours later, messages are delivered in real time over persistent TCP connections. XMPP (Extensible Messaging and Presence Protocol) is an open, XML-based protocol originally designed for instant messaging and presence notification, operating primarily on **port 5222** (client-to-server) and **port 5269** (server-to-server). Its federated, decentralized architecture means anyone can run their own XMPP server and communicate across domains.

## Why it matters
Threat actors have historically abused XMPP as a **C2 (command-and-control) channel** because its traffic blends into legitimate enterprise chat traffic and many firewalls permit it. Malware families like the Winnti group's tools have used XMPP to tunnel instructions to compromised hosts, exploiting the fact that security teams often whitelist common messaging ports without deep packet inspection.

## Key facts
- Default ports: **5222** (client-to-server, plaintext or STARTTLS) and **5269** (server-to-server federation)
- XMPP uses **STARTTLS** to upgrade plaintext connections to encrypted ones — without it, credentials and messages are exposed in cleartext
- **Jabber** is the legacy name for XMPP; they refer to the same protocol (Jabber was the original name before IETF standardization)
- Authentication is handled via **SASL** (Simple Authentication and Security Layer), making weak or misconfigured SASL mechanisms a direct attack surface
- XMPP's extensibility through **XEPs** (XMPP Extension Protocols) means features like file transfer or voice (Jingle) can introduce additional vulnerabilities beyond core messaging

## Related concepts
[[STARTTLS]] [[Command and Control (C2)]] [[SASL]] [[Protocol Tunneling]] [[Port-Based Firewall Evasion]]