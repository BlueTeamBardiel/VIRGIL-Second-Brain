# NIST RMF

## What it is
Think of it as a doctor's protocol for treating a sick patient — you assess symptoms, prescribe treatment, monitor recovery, and adjust — rather than guessing once and walking away. The NIST Risk Management Framework (SP 800-37) is a structured, six-step lifecycle process that federal agencies (and increasingly private organizations) use to identify, assess, and continuously manage security and privacy risks to information systems.

## Why it matters
When the Office of Personnel Management suffered its catastrophic 2015 breach (21.5 million records stolen), investigators found systemic failures in authorization controls and continuous monitoring — exactly the gaps the RMF is designed to close. Had the RMF's Assess and Monitor steps been rigorously applied, anomalous data exfiltration patterns would have triggered alerts before the damage compounded over months.

## Key facts
- **Six steps in order:** Prepare → Categorize → Select → Implement → Assess → Authorize → Monitor (the "Prepare" step was added in Rev. 2, 2018)
- **Categorize** uses FIPS 199 to assign Low/Moderate/High impact levels based on Confidentiality, Integrity, and Availability
- **Select** pulls security controls from NIST SP 800-53, matching the baseline to the system's impact category
- **Authorize** produces an Authorization to Operate (ATO), signed by an Authorizing Official (AO) — this is a named individual accepting residual risk
- **Monitor** is continuous, not a one-time event — it feeds back into the cycle, making RMF iterative rather than linear
- RMF aligns with FISMA compliance requirements, making it mandatory for all U.S. federal information systems

## Related concepts
[[FISMA]] [[NIST SP 800-53]] [[Security Authorization (ATO)]] [[Risk Assessment]] [[FIPS 199]]