# VoIP

## What it is
Think of VoIP like converting a vinyl record into an MP3 and streaming it over the internet — your voice gets digitized, packetized, and reassembled on the other end. Voice over Internet Protocol (VoIP) transmits voice communications as data packets over IP networks instead of traditional circuit-switched telephone lines. Protocols like SIP (Session Initiation Protocol) handle call setup, while RTP (Real-time Transport Protocol) carries the actual audio stream.

## Why it matters
In 2023, attackers compromised a company's SIP trunk credentials through a brute-forced VoIP PBX, then placed thousands of international calls — racking up $150,000 in fraudulent charges in a single weekend (a technique called toll fraud). Defenders mitigate this by enforcing strong authentication on SIP accounts, geo-restricting call destinations, and monitoring for abnormal call volume spikes in real time.

## Key facts
- **SIP operates on TCP/UDP port 5060 (unencrypted) and 5061 (TLS-encrypted)** — cleartext SIP is trivially intercepted with tools like SIPVicious or Wireshark
- **VLAN segmentation** is a primary defense: placing VoIP traffic on a dedicated voice VLAN isolates it from data traffic and limits lateral movement
- **Vishing (voice phishing)** exploits VoIP's low cost to spoof caller ID and impersonate banks, IRS agents, or IT help desks at scale
- **SRTP (Secure Real-time Transport Protocol)** encrypts the audio payload; without it, eavesdropping on calls is trivial on the same network segment
- **Toll fraud, eavesdropping, call hijacking, and denial-of-service** (flooding a PBX with SIP INVITE requests) are the four main VoIP attack categories on Security+ exams

## Related concepts
[[SIP Security]] [[VLAN Hopping]] [[Vishing]] [[Eavesdropping Attacks]] [[Network Segmentation]]