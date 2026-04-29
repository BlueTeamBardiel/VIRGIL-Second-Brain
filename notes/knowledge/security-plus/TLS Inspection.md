# TLS Inspection

## What it is
Like a customs officer who opens sealed diplomatic pouches, verifies the contents, then reseals them before delivery — TLS inspection (also called SSL inspection or HTTPS interception) is when a security device terminates an encrypted TLS session, decrypts and inspects the plaintext traffic, then re-encrypts it and forwards it to the destination. The inspecting device acts as a trusted man-in-the-middle, presenting its own certificate to the client while establishing a separate TLS session with the server.

## Why it matters
A threat actor distributes malware via a command-and-control server using HTTPS — without TLS inspection, the organization's next-gen firewall sees only encrypted blobs and can't detect the beaconing traffic or data exfiltration. Enabling TLS inspection on the perimeter firewall would expose the malicious payload for signature-based and behavioral detection to catch.

## Key facts
- The inspecting device (firewall, proxy, IDS) must have its CA certificate installed as **trusted** on all client machines, or users will see certificate errors
- Creates a **certificate chain break** — the client sees the proxy's cert, not the original server's cert, which can interfere with certificate pinning
- **TLS 1.3** significantly complicates inspection because it encrypts more of the handshake and removed export-grade cipher suites historically used for interception
- Privacy and legal concerns apply — TLS inspection may violate regulations (HIPAA, GDPR) if health or personal data is decrypted without proper controls
- Common deployment models: **forward proxy** (outbound inspection) and **inline/bump-in-the-wire** modes on NGFWs from vendors like Palo Alto, Fortinet, and Cisco

## Related concepts
[[Man-in-the-Middle Attack]] [[Public Key Infrastructure]] [[Certificate Pinning]] [[Next-Generation Firewall]] [[Deep Packet Inspection]]