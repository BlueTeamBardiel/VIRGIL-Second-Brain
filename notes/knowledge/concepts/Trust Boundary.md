# Trust Boundary

## What it is
Think of a trust boundary like the TSA checkpoint at an airport: everything on one side (the terminal) is assumed safe, but anything crossing from the other side (the street) must be inspected before it's trusted. In security architecture, a trust boundary is a point where data or control passes between two zones with *different levels of trust* — where the rules governing what's allowed fundamentally change. Anything crossing that line must be validated, authenticated, or filtered.

## Why it matters
SQL injection attacks succeed precisely because developers fail to enforce a trust boundary between user-supplied input (untrusted) and the database layer (trusted). When raw HTTP parameters are passed directly into SQL queries without validation at the boundary crossing, attackers can inject commands that the database executes with full privileges — turning user input into database instructions.

## Key facts
- Trust boundaries appear in threat modeling (STRIDE/DREAD) as the lines on a Data Flow Diagram (DFD) where threat analysis is most critical
- Common trust boundaries: internet → DMZ, DMZ → internal network, user space → kernel space, client → server
- Data crossing a trust boundary should always be **validated, sanitized, and authenticated** — the "never trust, always verify" principle
- Privilege escalation attacks specifically target trust boundaries between lower-privileged and higher-privileged execution contexts
- Zero Trust Architecture formally eliminates implicit trust zones, treating *every* boundary as untrusted regardless of network location

## Related concepts
[[Zero Trust Architecture]] [[Attack Surface]] [[Defense in Depth]] [[Input Validation]] [[DMZ]]