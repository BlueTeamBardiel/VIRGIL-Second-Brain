# XIII. Performing Forensic Analysis and Techniques for Incident Response

## What it is
Like an archaeologist sifting through layers of sediment to reconstruct a lost civilization, digital forensics reconstructs what happened on a system by carefully preserving and examining evidence artifacts. It is the disciplined process of identifying, collecting, preserving, analyzing, and presenting digital evidence in a manner that maintains its integrity and legal admissibility during an incident response investigation.

## Why it matters
During the 2020 SolarWinds breach, investigators had to perform forensic analysis across thousands of compromised endpoints to determine the attacker's dwell time (nearly 9 months), lateral movement paths, and exfiltrated data. Without proper forensic techniques — memory captures, log correlation, and timeline analysis — responders would have been unable to scope the breach or satisfy regulatory reporting requirements.

## Key facts
- **Order of volatility** dictates collection sequence: CPU registers → RAM → swap/page files → disk → remote logs → archived media. Always capture most volatile first.
- **Chain of custody** documentation must be unbroken from collection to courtroom; any gap can render evidence inadmissible.
- **Write blockers** (hardware or software) must be used during disk imaging to prevent accidental modification of evidence; forensic images are verified with MD5/SHA-256 hashes.
- **Memory forensics** (using tools like Volatility) can reveal running processes, injected code, and encryption keys that disappear after a reboot — disk forensics alone will miss them.
- **Legal holds** must be issued immediately upon anticipating litigation to suspend routine data deletion policies and preserve relevant artifacts.

## Related concepts
[[Chain of Custody]] [[Order of Volatility]] [[Incident Response Lifecycle]] [[Memory Forensics]] [[E-Discovery]]