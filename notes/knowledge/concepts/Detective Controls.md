# Detective controls

## What it is
Like a smoke detector that doesn't stop a fire but immediately tells you one has started, detective controls are security measures that identify and alert on security events *as they occur or after the fact*. They don't prevent incidents but provide visibility, enabling a timely response before damage compounds.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the network for weeks undetected. A properly tuned SIEM or IDS configured as a detective control — flagging anomalous Point-of-Sale traffic to an external IP — could have triggered an alert days earlier, dramatically limiting the 40 million card records ultimately stolen.

## Key facts
- Detective controls are one of three functional control categories: **preventive** (block), **detective** (identify), and **corrective** (fix) — Security+ expects you to distinguish all three
- Common examples: **IDS** (not IPS), **SIEM**, **audit logs**, **security cameras**, **honeypots**, and **file integrity monitoring (FIM)**
- A detective control without an alert or response workflow attached is nearly useless — detection only creates value if someone acts on it
- **Log review** is the most foundational detective control; without logs, most other detective tools lose their evidence base
- Detective controls are especially critical for satisfying **compliance frameworks** (PCI-DSS, HIPAA) that mandate audit trails and anomaly detection

## Related concepts
[[Preventive controls]] [[Corrective controls]] [[Security Information and Event Management (SIEM)]] [[Intrusion Detection System (IDS)]] [[Audit Logging]]