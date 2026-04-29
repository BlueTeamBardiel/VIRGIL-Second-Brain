# In-Scope and Out-of-Scope

## What it is
Think of a bug bounty or penetration test like a landlord handing you a master key — but explicitly telling you "Building A only; the hospital next door is off-limits." In-scope defines the exact systems, IP ranges, applications, or domains a tester is *authorized* to probe; out-of-scope defines everything explicitly prohibited from testing. Violating scope boundaries transforms a legitimate security assessment into unauthorized access under laws like the CFAA.

## Why it matters
During a real-world red team engagement, a tester who pivots from an in-scope web server to a third-party payment processor (out-of-scope) can inadvertently trigger incident response at an unrelated company, expose the testing firm to criminal liability, and invalidate the entire assessment. Clearly defined scope documents serve as the legal safe harbor that separates ethical hacking from criminal intrusion.

## Key facts
- Scope is formally defined in the **Rules of Engagement (ROE)** or **Statement of Work (SOW)** — testers must have written authorization before touching any target
- **IP ranges, URLs, physical locations, and test timeframes** are all common scope parameters — ambiguity here creates legal risk
- Out-of-scope assets often include **production databases, third-party services, and critical infrastructure** even if technically reachable from in-scope systems
- If a tester discovers an out-of-scope vulnerability during an engagement, the correct action is to **stop, document, and report it to the client** — not exploit it
- Bug bounty platforms (HackerOne, Bugcrowd) publish explicit scope tables; submitting vulnerabilities for out-of-scope assets results in **report rejection and potential account bans**

## Related concepts
[[Rules of Engagement]] [[Penetration Testing Phases]] [[Authorization and Consent]] [[Bug Bounty Programs]] [[Computer Fraud and Abuse Act (CFAA)]]