# Embargo

## What it is
Like a shipping port that holds containers in a locked yard until a trade agreement is signed, an embargo in cybersecurity is a coordinated hold on vulnerability disclosure — researchers and vendors agree to keep a flaw secret until a patch is ready and distributed. Formally, it is a time-limited non-disclosure agreement between a vulnerability discoverer and the affected vendor, governing when public release of exploit details is permitted.

## Why it matters
In 2021, researchers discovered PrintNightmare (CVE-2021-34527), a critical Windows Print Spooler vulnerability under an active embargo with Microsoft. A researcher accidentally published a proof-of-concept to GitHub before the patch shipped, breaking the embargo and forcing Microsoft to rush an emergency out-of-band patch — attackers immediately weaponized the PoC before many organizations could remediate. This illustrates how a broken embargo directly collapses the defender's response window.

## Key facts
- Embargoes are typically **90 days**, a standard popularized by Google Project Zero as the balance point between vendor response time and public safety.
- **Coordinated Vulnerability Disclosure (CVD)** is the formal framework governing embargo agreements, replacing the older "full disclosure" vs. "no disclosure" debate.
- If a vendor fails to patch within the embargo window, researchers are generally ethically (and sometimes contractually) permitted to publish anyway — this is called **deadline enforcement**.
- Bug bounty platforms like HackerOne and Bugcrowd act as neutral third parties that formalize embargo terms between researchers and vendors.
- An embargo breach can trigger **parallel discovery exploitation** — once details leak, threat actors race to exploit before defenders can patch.

## Related concepts
[[Coordinated Vulnerability Disclosure]] [[Responsible Disclosure]] [[Zero-Day Vulnerability]] [[Bug Bounty Program]] [[Patch Management]]