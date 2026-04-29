# RTP

## What it is
Think of RTP like a postal truck that doesn't wait for delivery confirmation — it just keeps tossing packages out the window as it drives, trusting they'll land close enough to be useful. Real-time Transport Protocol (RTP) is an application-layer protocol that delivers audio and video over IP networks, operating over UDP to prioritize speed and low latency over guaranteed delivery. It's the engine behind VoIP calls, video conferencing, and streaming media.

## Why it matters
RTP traffic is a prime target for **VoIP interception attacks**: because RTP streams are often unencrypted, an attacker performing a man-in-the-middle attack on a SIP-based phone system can capture RTP packets and reconstruct entire voice conversations using tools like Wireshark or rtpdump. Defenders counter this by enforcing **SRTP (Secure RTP)**, which adds AES encryption and HMAC-SHA1 authentication to the media stream itself — separate from SIP signaling encryption.

## Key facts
- RTP runs over **UDP** (typically ports 16384–32767) for low latency; it does NOT guarantee delivery or ordering
- RTP pairs with **RTCP (RTP Control Protocol)** which provides out-of-band statistics on call quality, jitter, and packet loss
- **SRTP** (RFC 3711) is the secure version, providing confidentiality, integrity, and replay protection for media streams
- RTP headers include **sequence numbers and timestamps** used to reorder packets and detect loss — these fields can be exploited in replay attacks if SRTP is absent
- VoIP attacks targeting RTP include **eavesdropping**, **RTP injection** (inserting malicious audio), and **replay attacks**

## Related concepts
[[SRTP]] [[VoIP Security]] [[SIP]] [[UDP]] [[Man-in-the-Middle Attack]]