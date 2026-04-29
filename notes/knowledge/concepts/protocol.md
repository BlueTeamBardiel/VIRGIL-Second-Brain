# protocol

## What it is
Like a diplomatic rulebook that two ambassadors must both follow before exchanging classified letters, a protocol is a standardized set of rules governing how data is formatted, transmitted, and interpreted between systems. It defines the syntax, semantics, and timing of communication so that disparate devices can exchange information reliably and predictably.

## Why it matters
Protocol weaknesses are a primary attack surface in real-world breaches. The POODLE attack (2014) exploited SSL 3.0's fallback protocol negotiation, forcing modern browsers to downgrade to a legacy, broken protocol — allowing attackers to decrypt HTTPS traffic through a man-in-the-middle position. This illustrates how protocol design flaws, not just implementation bugs, can compromise entire communication channels.

## Key facts
- Protocols operate at specific OSI layers: HTTP/HTTPS at Layer 7, TCP/UDP at Layer 4, IP at Layer 3, Ethernet at Layer 2 — knowing the layer tells you the attack surface
- **Plaintext protocols** (HTTP, FTP, Telnet, SMTP without TLS) transmit data in readable form, making them vulnerable to sniffing and credential interception
- Protocol downgrade attacks trick endpoints into using weaker versions (e.g., TLS 1.3 → TLS 1.0); mitigated by enforcing minimum version policies
- **RFC documents** are the authoritative specifications for internet protocols — attackers read them to find edge-case vulnerabilities
- Encapsulation is a protocol concept where each layer wraps data in its own header, creating a predictable structure that both analysts and attackers can parse

## Related concepts
[[OSI model]] [[TLS]] [[man-in-the-middle attack]] [[network sniffing]] [[port numbers]]