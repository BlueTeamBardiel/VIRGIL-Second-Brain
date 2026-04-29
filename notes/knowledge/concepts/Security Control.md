# Security Control

## What it is
Think of a medieval castle: the moat, the drawbridge, the guards, and the keep are all different layers protecting the king — each one a distinct mechanism serving a specific defensive purpose. A security control is any safeguard or countermeasure — technical, administrative, or physical — designed to reduce risk by protecting the confidentiality, integrity, or availability of assets. Controls either prevent threats from occurring, detect them when they do, or help recover after damage is done.

## Why it matters
In the 2013 Target breach, attackers used stolen HVAC vendor credentials to pivot into the payment network. Proper network segmentation (a **preventive technical control**) and anomaly detection (a **detective control**) would have either blocked lateral movement or flagged the unusual traffic before 40 million card numbers were exfiltrated. The breach illustrated that no single control is sufficient — layered controls are essential.

## Key facts
- Controls are classified by **function**: Preventive, Detective, Corrective, Deterrent, Compensating, and Directive
- Controls are classified by **type**: Technical (firewalls, encryption), Administrative (policies, training), and Physical (locks, cameras)
- A **compensating control** substitutes for a required control when the primary one isn't feasible — e.g., enhanced monitoring replacing mandatory MFA for a legacy system
- **Detective controls** like IDS and audit logs do not stop an attack — they only identify it after or during the fact
- The **Security Control Frameworks** (NIST SP 800-53, CIS Controls, ISO 27001) provide standardized catalogs organizations use to select and audit controls

## Related concepts
[[Defense in Depth]] [[Risk Management]] [[NIST SP 800-53]] [[Compensating Controls]] [[Threat and Vulnerability Management]]