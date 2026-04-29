# SIP

## What it is
Think of SIP like a telephone switchboard operator who connects calls but doesn't actually carry the conversation — it just sets up, manages, and tears down the session. Session Initiation Protocol (SIP) is an application-layer signaling protocol used to establish, modify, and terminate multimedia communication sessions such as VoIP calls, video conferencing, and instant messaging. It operates over UDP (port 5060) or TLS-encrypted TCP (port 5061).

## Why it matters
Attackers routinely exploit misconfigured SIP servers to conduct toll fraud — they send unauthorized INVITE requests to a vulnerable PBX, which then routes expensive international calls billed to the victim organization. In one common scenario, exposed SIP ports allow attackers to enumerate valid extensions via OPTIONS scanning, brute-force credentials, and then hijack accounts to rack up thousands of dollars in fraudulent calls within hours.

## Key facts
- SIP uses port **5060 (UDP/TCP)** for unencrypted traffic and port **5061 (TCP/TLS)** for encrypted signaling — SRTP is separately used to encrypt the actual media stream
- Common SIP attacks include **INVITE flooding** (DoS), **registration hijacking**, **toll fraud**, and **eavesdropping** on unencrypted SIP messages
- SIP messages are **human-readable text**, similar to HTTP, making them easy to intercept and manipulate with tools like Wireshark or SIPVicious
- **SIPVicious** is a well-known open-source tool used for SIP enumeration, extension scanning, and credential brute-forcing
- Defenses include deploying a **Session Border Controller (SBC)**, enforcing mutual TLS authentication, rate-limiting INVITE requests, and never exposing SIP ports directly to the internet

## Related concepts
[[VoIP Security]] [[SRTP]] [[DoS Attacks]] [[Session Border Controller]] [[Port Scanning]]