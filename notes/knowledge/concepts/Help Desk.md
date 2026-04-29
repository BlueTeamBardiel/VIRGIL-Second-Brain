# Help Desk

## What it is
Like a hospital triage nurse who quickly assesses patients and routes them to the right doctor, a help desk is the first point of contact that triages user problems and escalates them to the appropriate technical resource. In security contexts, it is a support function that handles password resets, account lockouts, access requests, and incident reports — making it both a critical service and a high-value attack target.

## Why it matters
In the 2020 Twitter breach, attackers used **vishing (voice phishing)** to impersonate employees and manipulate Twitter's internal help desk staff into granting access to administrative tools — ultimately compromising 130 high-profile accounts. This illustrates how help desks, without strong identity verification procedures, become the weakest link in an organization's authentication chain. Proper caller verification protocols (e.g., requiring employee ID, manager callback confirmation, or multi-factor verification) are the primary defense.

## Key facts
- Help desks are a primary target for **social engineering attacks**, particularly vishing and pretexting, because staff are trained to be helpful
- **Identity verification before any account action** is a Security+ exam staple — acceptable methods include shared secrets, manager authorization, or out-of-band confirmation
- Help desks should follow the **principle of least privilege** when restoring access — granting only what the user needs, not full restoration by default
- All help desk interactions should be **logged and ticketed** to create an audit trail, supporting incident response and forensic investigations
- Help desk staff are often required to follow a **call script or decision tree** to ensure consistent security procedures and reduce manipulation susceptibility

## Related concepts
[[Social Engineering]] [[Vishing]] [[Identity Verification]] [[Principle of Least Privilege]] [[Incident Response]]