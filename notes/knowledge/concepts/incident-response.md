# incident-response

## What it is
Like a hospital trauma team that follows a rehearsed protocol the moment a patient crashes — not improvising, but executing practiced steps under pressure — incident response is an organization's structured, pre-planned process for detecting, containing, eradicating, and recovering from security breaches. It transforms chaos into choreography, ensuring that the right people take the right actions in the right order when an attack occurs.

## Why it matters
During the 2017 NotPetya outbreak, organizations without mature incident response plans watched the wiper malware propagate laterally for hours before anyone had authority to isolate segments or pull network cables. Companies with documented IR playbooks that included clear containment decision trees were able to sever affected subnets within minutes, limiting damage that ultimately cost others hundreds of millions of dollars.

## Key facts
- **NIST SP 800-61** defines the four IR phases: **Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-Incident Activity** (lessons learned)
- **PICERL** is an alternative mnemonic used by SANS: Preparation, Identification, Containment, Eradication, Recovery, Lessons Learned
- The **lessons learned / post-mortem** phase is the most commonly skipped — and skipping it guarantees repeat incidents
- **Chain of custody** must be maintained during evidence collection; improperly handled forensic evidence can be inadmissible and destroy legal recourse
- Mean Time to Detect (**MTTD**) and Mean Time to Respond (**MTTR**) are the primary KPIs used to measure IR program effectiveness

## Related concepts
[[digital-forensics]] [[threat-intelligence]] [[security-operations-center]] [[containment-strategies]] [[chain-of-custody]]