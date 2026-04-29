# Asterisk

## What it is
Like a Swiss Army knife someone left unlocked in a server room, Asterisk is a powerful open-source PBX (Private Branch Exchange) software framework that turns a standard Linux server into a full-featured telephony system. It handles VoIP calls, voicemail, call routing, and conferencing using protocols like SIP, IAX2, and H.323.

## Why it matters
Attackers frequently scan for exposed Asterisk installations with default or weak credentials to commit toll fraud — hijacking the PBX to place thousands of dollars worth of international calls billed to the victim. In one common attack pattern, a threat actor brute-forces SIP credentials on port 5060, registers a rogue extension, and routes calls through expensive premium-rate numbers they control, resulting in bills exceeding tens of thousands of dollars overnight.

## Key facts
- Asterisk listens on **UDP/TCP port 5060** (SIP) and **UDP port 4569** (IAX2) by default — both are prime scanning targets
- Default configurations historically allowed **unauthenticated AMI (Asterisk Manager Interface)** access on port **5038**, enabling full system control
- Toll fraud via compromised Asterisk systems is one of the **most financially damaging VoIP threats**, costing the industry billions annually
- Asterisk supports **SRTP** for media encryption and **TLS for SIP signaling** — both should be enforced to prevent eavesdropping on call content
- Common hardening steps include **disabling guest SIP access**, **IP whitelisting on AMI**, and enabling **fail2ban** to block SIP brute-force attempts

## Related concepts
[[VoIP Security]] [[SIP Protocol]] [[Toll Fraud]] [[Port Scanning]] [[Brute Force Attacks]]