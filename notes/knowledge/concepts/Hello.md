# Hello

## What it is
Like a postal carrier knocking on a door before handing off a package, "Hello" messages in networking are the opening handshake signals that establish whether two systems are ready and willing to communicate. In cybersecurity contexts, "Hello" refers specifically to the initial protocol greeting messages — most notably the **ClientHello** and **ServerHello** in the TLS handshake — that negotiate encryption parameters before any secure data flows.

## Why it matters
Attackers can intercept and manipulate TLS ClientHello messages to perform **downgrade attacks**, forcing a server to negotiate weaker cipher suites or older protocol versions like SSLv3. The POODLE attack (2014) exploited exactly this mechanism, tricking servers into falling back to SSLv3, which could then be broken to expose plaintext cookies and session tokens.

## Key facts
- The **ClientHello** message advertises supported TLS versions, cipher suites, compression methods, and a random nonce used in key derivation.
- The **ServerHello** selects from the client's advertised options — whatever the server picks becomes the session's security baseline.
- TLS 1.3 significantly reduced handshake exposure by removing weak cipher suites entirely and encrypting more of the handshake early.
- **OSCP stapling** and **SNI (Server Name Indication)** are both transmitted during the Hello phase, making this packet a goldmine for passive network reconnaissance.
- Inspecting Hello messages is a core technique in **network traffic analysis** — malware C2 channels often have anomalous or self-signed certificate fingerprints visible here.

## Related concepts
[[TLS Handshake]] [[Downgrade Attack]] [[Cipher Suite Negotiation]] [[POODLE Vulnerability]] [[Network Traffic Analysis]]