# Control Effectiveness

## What it is
Think of a deadbolt on a door: having it installed means nothing if the tenant never locks it. Control effectiveness is the measured degree to which a security control actually achieves its intended risk-reduction outcome in practice — not just on paper. It distinguishes between a control that *exists* and one that *works*.

## Why it matters
During the 2013 Target breach, network segmentation controls *existed* between the payment card environment and vendor-accessible systems — but they were misconfigured and effectively unenforced. Attackers pivoted freely from an HVAC vendor's credentials into POS systems. A proper effectiveness assessment would have revealed the segmentation wasn't actually blocking lateral movement, potentially preventing 40 million compromised card records.

## Key facts
- **Design effectiveness** asks "is this the right control for the threat?" while **operational effectiveness** asks "is it functioning correctly right now?" — both must pass.
- The NIST SP 800-53A framework provides assessment procedures specifically for measuring whether implemented controls satisfy their stated security requirements.
- Control effectiveness feeds directly into residual risk calculation: `Residual Risk = Inherent Risk × (1 − Control Effectiveness)`.
- A control rated at 0% effectiveness contributes nothing to risk reduction and may create false confidence — worse than acknowledged absence of a control.
- Security control assessments (SCAs) and continuous monitoring programs (per NIST RMF) are the primary mechanisms for measuring effectiveness over time, not just at implementation.

## Related concepts
[[Security Controls]] [[Residual Risk]] [[Risk Assessment]] [[Continuous Monitoring]] [[NIST RMF]]