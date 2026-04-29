# containment

## What it is
Like a doctor isolating a patient in quarantine before knowing the full diagnosis, containment is the act of limiting a threat's spread before you fully understand it. Precisely: containment is the incident response phase where affected systems are isolated or restricted to prevent an active threat from propagating further across the network. It occurs after detection but before eradication.

## Why it matters
During the 2017 NotPetya attack, organizations that failed to rapidly segment infected systems watched the worm traverse flat networks and destroy thousands of machines within hours. Companies like Maersk that lacked automated containment controls lost entire global infrastructure; those with network segmentation in place limited the blast radius significantly. Containment bought time — or in its absence, cost everything.

## Key facts
- Containment has two phases: **short-term** (immediate isolation — pull the network cable, disable the port) and **long-term** (applying temporary fixes so business can continue while eradication is prepared)
- The decision to isolate vs. monitor is a deliberate tradeoff — isolating too early may destroy forensic evidence or alert the attacker; monitoring too long allows damage to spread
- Containment strategies include: **network segmentation**, **ACL modifications**, **endpoint quarantine via EDR**, and **disabling compromised accounts**
- NIST SP 800-61 (Computer Security Incident Handling Guide) formally defines containment as step 3 of the incident response lifecycle: Preparation → Detection & Analysis → **Containment** → Eradication → Recovery → Post-Incident
- Evidence preservation must happen during or before containment — memory capture (volatile data) should occur prior to pulling power or isolating a system

## Related concepts
[[incident response]] [[network segmentation]] [[eradication]] [[endpoint detection and response]] [[NIST 800-61]]