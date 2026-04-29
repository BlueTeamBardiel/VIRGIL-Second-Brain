# DISA STIGs

## What it is
Think of STIGs as a master chef's recipe book for secure system configuration — every step, every setting, every ingredient specified so there's no guessing and no cutting corners. Security Technical Implementation Guides (STIGs) are mandatory configuration standards published by the Defense Information Systems Agency (DISA) that specify exact security settings for hardware, software, and operating systems used within the Department of Defense. They eliminate ambiguity by prescribing precisely *how* a system must be hardened, not just *that* it should be.

## Why it matters
In 2020, misconfigured systems were a primary enabler of the SolarWinds supply chain attack — default and weak configurations gave attackers persistent footholds across government networks. Had STIG-compliant configurations been universally enforced on affected systems (including disabling unnecessary services and enforcing least privilege), the lateral movement opportunity would have been significantly reduced. STIGs exist precisely to close these configuration gaps before adversaries exploit them.

## Key facts
- STIGs are organized by **Category (CAT) severity**: CAT I = critical (can cause immediate data loss/breach), CAT II = serious, CAT III = informational — exam questions love this hierarchy
- Each STIG finding is called a **Vulnerability ID (V-ID)** or **Rule ID**, tied to a specific control check
- DISA provides the **STIG Viewer** tool and **SCAP Compliance Checker (SCC)** to automate audit and validation of STIG compliance
- STIGs map directly to **NIST SP 800-53** controls, making them interoperable with the RMF (Risk Management Framework)
- Non-DoD organizations often use STIGs as a free, authoritative baseline — they're publicly available at **public.cyber.mil**

## Related concepts
[[CIS Benchmarks]] [[NIST RMF]] [[Security Baselines]] [[SCAP]] [[Hardening]]