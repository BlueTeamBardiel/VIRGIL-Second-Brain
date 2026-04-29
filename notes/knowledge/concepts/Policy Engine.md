# Policy Engine

## What it is
Think of it as a bouncer at an exclusive club who doesn't just check your ID, but cross-references your name against a guest list, checks your outfit, confirms the time of night, and calls the host before letting you in. A policy engine is a centralized decision-making component that evaluates access requests against a defined set of rules, conditions, and context before granting or denying access. It is the enforcement brain of Zero Trust Architecture, separating the *decision* to allow access from the *enforcement* of that decision.

## Why it matters
In a Zero Trust deployment, a contractor attempts to access a financial database from an unmanaged personal laptop at 2 AM from an unusual geographic location. The policy engine evaluates device compliance status, user identity, time-of-access, and location simultaneously — and denies access despite valid credentials. Without a policy engine, the legacy "trust but verify once at login" model would have granted full access based on credentials alone.

## Key facts
- The policy engine works alongside the **Policy Administrator** (communicates decisions) and **Policy Enforcement Point** (executes decisions) — all three are core Zero Trust components per NIST SP 800-207
- Policy engines use **continuous verification**, not one-time authentication — trust is re-evaluated on every request
- Inputs to a policy engine include: user identity, device health/posture, resource sensitivity, time, location, and threat intelligence feeds
- A policy engine can render three verdicts: **grant, deny, or step-up authentication** (requiring MFA challenge)
- Policy engines underpin **ABAC (Attribute-Based Access Control)**, making decisions on dynamic attributes rather than static group membership

## Related concepts
[[Zero Trust Architecture]] [[Policy Enforcement Point]] [[Attribute-Based Access Control]] [[Continuous Authentication]] [[NIST SP 800-207]]