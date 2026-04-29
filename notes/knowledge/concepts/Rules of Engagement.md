# Rules of Engagement

## What it is
Like a surgeon who must get written consent before making an incision, a penetration tester must have explicit, documented authorization before touching a single system. Rules of Engagement (ROE) are the formal document that defines the scope, boundaries, timing, methods, and permissions for a security assessment — establishing exactly what is allowed, what is off-limits, and who to contact when things go sideways.

## Why it matters
During a red team engagement, a tester who accidentally triggers a DDoS against a shared hosting environment — because the ROE failed to exclude third-party systems on the same IP range — can expose the client and the testing firm to legal liability under the Computer Fraud and Abuse Act (CFAA). A precise ROE listing excluded IP ranges, permitted attack types, and emergency halt procedures would have prevented the incident entirely.

## Key facts
- ROE must be signed **before** any testing begins; verbal authorization is legally insufficient
- Must specify **in-scope vs. out-of-scope** assets (IP ranges, domains, physical locations, social engineering targets)
- Should define **permitted testing hours** to avoid disrupting business operations or triggering false incident responses
- Includes an **emergency contact/stop condition** — a "get-out-of-jail-free" letter testers carry in case law enforcement is called
- ROE is distinct from the **Statement of Work (SOW)** — SOW covers business terms; ROE covers technical and operational constraints
- Testing without ROE — even with good intentions — can constitute unauthorized access under the CFAA

## Related concepts
[[Penetration Testing]] [[Scope of Engagement]] [[Statement of Work]] [[Computer Fraud and Abuse Act]] [[Threat Intelligence]]