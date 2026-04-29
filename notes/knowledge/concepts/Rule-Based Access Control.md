# Rule-Based Access Control

## What it is
Like a nightclub bouncer with a laminated checklist — "no jeans, must be 21, no prior incidents" — who admits or denies anyone matching those criteria regardless of who they are, Rule-Based Access Control (RuBAC) enforces access decisions based on a predefined set of system-wide conditions or rules, not user identity or roles. These rules typically evaluate attributes like time of day, IP address, or device type before granting access.

## Why it matters
A financial institution configures its firewall to block all traffic attempting to access the core banking system outside of business hours (18:00–07:00) and from non-whitelisted IP ranges. Even if an attacker obtains valid credentials, the rule-based policy denies the session entirely — the identity is irrelevant because the *conditions* aren't met. This is a common layered defense against credential-stuffing attacks using stolen passwords.

## Key facts
- RuBAC evaluates **environmental or contextual conditions** (time, location, protocol) rather than assigning permissions directly to users or roles
- Often implemented at the **network layer** via ACLs on firewalls and routers — the most common real-world deployment
- Rules are typically **static and administrator-defined**; they don't adapt dynamically like ABAC policies
- RuBAC is distinct from RBAC (Role-Based): RBAC asks *who are you?*, RuBAC asks *do conditions allow this?*
- Commonly confused on exams: **MAC** (Mandatory Access Control) uses labels/classifications, while RuBAC uses explicit if-then condition rules
- Can be layered *with* other models — a user may pass RBAC checks but still fail a RuBAC time-restriction rule

## Related concepts
[[Role-Based Access Control (RBAC)]] [[Attribute-Based Access Control (ABAC)]] [[Mandatory Access Control (MAC)]] [[Access Control Lists (ACLs)]]