# Metakom

## What it is
Like a skeleton key ring that opens not just doors but entire building management systems, Metakom is a Russian-origin access control and intercom system widely deployed in residential and commercial buildings across post-Soviet states. Precisely, it is a proprietary electronic key and intercom platform using a low-frequency RFID-based touch-key protocol (often called Dallas keys or iButton keys) for physical access authentication.

## Why it matters
Security researchers have demonstrated that Metakom keys can be cloned using inexpensive hardware (under $20) because the system relies solely on a static, unencrypted 64-bit serial number for authentication — no challenge-response, no rolling codes. An attacker with brief proximity to a legitimate key and a handheld duplicator can clone credentials and gain physical access to apartment buildings, server rooms, or utility infrastructure without any alarm being triggered.

## Key facts
- Uses iButton (DS1990A) touch-memory keys operating at a contact-based protocol, not truly wireless RFID, but functionally treated as RFID in access control contexts
- Authentication is based entirely on a static 64-bit unique ID — no cryptographic handshake occurs
- Cloning attacks require only seconds of physical access to the original key and a commercially available duplicator (e.g., RW1990 writers)
- Widely deployed in Eastern Europe and Russia means millions of endpoints share this fundamental design weakness
- No native logging or audit trail in basic Metakom installations, making intrusion detection post-incident nearly impossible

## Related concepts
[[iButton (Dallas Key)]] [[RFID Cloning]] [[Physical Access Control Systems (PACS)]] [[Replay Attack]] [[Defense in Depth]]