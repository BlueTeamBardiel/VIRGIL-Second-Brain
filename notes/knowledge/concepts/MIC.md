# MIC

## What it is
Think of MIC like a wax seal on a medieval letter — it doesn't encrypt the contents, but it proves nobody tampered with it in transit. A **Message Integrity Code** (MIC) is a cryptographic value appended to data that allows the receiver to verify the message hasn't been altered, typically generated using a shared secret and a hashing algorithm.

## Why it matters
In WPA/WPA2 Wi-Fi security, the MIC is the linchpin of the 4-way handshake. During the **KRACK attack (Key Reinstallation Attack)**, adversaries force nonce reuse by replaying handshake messages — the MIC value remains valid even as the underlying encryption is undermined, which is exactly what made KRACK so dangerous. Defenders patch this by ensuring handshake messages are never accepted out of sequence.

## Key facts
- MIC is often used interchangeably with **MAC (Message Authentication Code)** in networking contexts, but MIC typically implies a weaker, non-cryptographic guarantee in some older protocols (e.g., WEP used a flawed MIC called **ICV**)
- WPA/WPA2 uses **TKIP's Michael algorithm** to generate MICs; the Michael algorithm was later found to be cryptographically weak
- A MIC provides **integrity and authenticity**, but NOT confidentiality — the data is still readable
- If MIC verification fails twice within 60 seconds under TKIP, the protocol triggers a **60-second lockout** as a countermeasure against brute-force MIC attacks
- Unlike a simple checksum (which only detects accidental corruption), a MIC requires knowledge of a **shared secret key** to forge, making it resistant to deliberate tampering

## Related concepts
[[Message Authentication Code]] [[WPA2 4-Way Handshake]] [[TKIP]] [[KRACK Attack]] [[Data Integrity]]