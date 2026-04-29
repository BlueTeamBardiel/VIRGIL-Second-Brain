# Call Tampering

## What it is
Like a telephone operator in an old switchboard room secretly cutting into your conversation to inject noise, drop words, or reroute your call — call tampering is the deliberate manipulation of active VoIP sessions to disrupt, intercept, or alter voice communications in transit. Attackers interfere with the signaling or media streams of a call to degrade quality, inject audio, or terminate sessions entirely.

## Why it matters
In a targeted corporate espionage scenario, an attacker positioned via a man-in-the-middle attack on an unencrypted SIP trunk can inject forged SIP BYE messages to silently drop calls between executives mid-negotiation — making the attack invisible and attributable to "network issues." Alternatively, RTP stream injection allows an adversary to insert fabricated audio into a live call, potentially manipulating decisions or impersonating a voice.

## Key facts
- **SIP (Session Initiation Protocol)** is the primary target; unauthenticated SIP allows forged INVITE, BYE, and CANCEL messages to hijack or terminate calls
- **RTP (Real-time Transport Protocol)** carries the actual voice media and lacks built-in encryption or authentication by default, making it vulnerable to stream injection and eavesdropping
- **SRTP (Secure RTP)** and **TLS for SIP signaling** are the primary countermeasures, providing encryption and integrity verification for both media and control channels
- Call tampering falls under the broader **VoIP attack** category alongside toll fraud, vishing, and call interception — relevant to both Security+ and CySA+ threat identification objectives
- Detection involves monitoring for **anomalous SIP message rates**, unexpected session terminations, and RTP stream discontinuities using VoIP-aware IDS/IPS tools

## Related concepts
[[VoIP Security]] [[Man-in-the-Middle Attack]] [[SIP Spoofing]] [[SRTP]] [[Eavesdropping]]