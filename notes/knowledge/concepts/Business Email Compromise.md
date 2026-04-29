# Business Email Compromise

## What it is
Imagine a forger who studies a CEO's handwriting for months, then slips a fake check-signing request into the CFO's inbox at exactly the right moment — that's BEC. Business Email Compromise is a social engineering attack where adversaries impersonate trusted executives or vendors via email to manipulate employees into transferring funds or sensitive data. Unlike phishing, BEC rarely uses malware; it weaponizes trust and urgency alone.

## Why it matters
In 2020, the FBI reported BEC caused over $1.8 billion in losses — more than any other cybercrime category. A classic scenario: attackers compromise a CEO's email account via credential stuffing, monitor it silently for weeks, then send a wire transfer request to the CFO timed to coincide with a known overseas business trip when verification feels inconvenient. The CFO transfers $200,000 before anyone questions it.

## Key facts
- BEC is categorized under **social engineering** and typically involves **no malicious attachments or links** — making it invisible to most email security filters
- Common BEC variants: CEO fraud, vendor impersonation, attorney impersonation, W-2 data theft, and real estate wire fraud
- Attackers often use **lookalike domains** (e.g., `micros0ft-corp.com`) or **display name spoofing** to defeat casual inspection
- Defenses include **DMARC/DKIM/SPF** email authentication, out-of-band verification (phone call to known number) for financial requests, and multi-person approval workflows
- The FBI's **IC3 (Internet Crime Complaint Center)** tracks BEC separately because of its outsized financial impact relative to other cybercrime types

## Related concepts
[[Phishing]] [[Social Engineering]] [[DMARC]] [[Credential Stuffing]] [[Spoofing]]