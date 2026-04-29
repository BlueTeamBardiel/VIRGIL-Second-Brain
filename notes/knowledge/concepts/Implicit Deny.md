# Implicit Deny

## What it is
Think of a nightclub bouncer whose list says exactly who gets in — if your name isn't on it, you're not getting through the door, no argument. Implicit deny is the principle that any traffic, user, or action not explicitly permitted by a security policy is automatically blocked by default. It is the foundational rule at the end of every well-designed firewall ruleset or ACL: silence means no.

## Why it matters
In 2020, misconfigured AWS S3 buckets exposed millions of records precisely because cloud storage defaults to *allow* in certain configurations rather than deny — the opposite of implicit deny. A properly hardened environment with implicit deny as the baseline would have blocked all unauthorized access until an administrator explicitly granted permissions, containing the breach before data ever left the bucket.

## Key facts
- Implicit deny is always the **last rule** in a firewall ACL or policy chain; it never needs to be written explicitly because it applies to everything not matched above it
- Contrasted with **explicit deny**, which is a written rule blocking specific traffic — implicit deny catches everything else
- PCI DSS and NIST SP 800-41 both require implicit deny as a baseline for firewall configurations protecting cardholder and sensitive data environments
- On Security+, "default deny" and "implicit deny" are treated as synonymous — know both terms
- Implementing implicit deny supports the **principle of least privilege**: nothing is allowed unless justified and documented

## Related concepts
[[Firewall Rules and ACLs]] [[Principle of Least Privilege]] [[Default Configurations]] [[Defense in Depth]] [[Network Segmentation]]