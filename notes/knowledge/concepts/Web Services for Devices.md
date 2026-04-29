# Web Services for Devices

## What it is
Think of it like a universal TV remote standard — instead of every device speaking its own proprietary language, WS-Management (WSMan) gives networked devices a common XML/SOAP-based "dialect" to receive instructions. Web Services for Devices (WSD) is a Microsoft protocol stack enabling automatic discovery and management of networked printers, scanners, and hardware over HTTP/HTTPS using standardized SOAP messages.

## Why it matters
In a real-world scenario, an attacker on a local network segment can abuse WSD's UDP multicast discovery mechanism (port 3702) to conduct amplification attacks — sending small spoofed discovery requests that cause devices to flood a victim with large XML response payloads, achieving amplification ratios up to 300:1. Defenders should restrict UDP port 3702 at network boundaries and disable WSD on devices where automatic discovery isn't operationally necessary.

## Key facts
- WSD operates primarily over **UDP port 3702** (discovery) and **TCP port 5357/5358** (data transport)
- Uses **WS-Discovery** as its underlying protocol for zero-configuration device detection via multicast
- WSD amplification DDoS attacks exploit the asymmetry between small probe packets and large XML-formatted SOAP responses
- Windows hosts run the **Function Discovery Resource Publication** service to advertise themselves via WSD — disabling this reduces attack surface
- WSD is distinct from **UPnP** but shares similar threat vectors: unauthenticated local network exposure and potential for network reconnaissance

## Related concepts
[[UPnP Security]] [[SOAP Injection]] [[Network Service Discovery]] [[Amplification Attacks]] [[Zero-Configuration Networking]]