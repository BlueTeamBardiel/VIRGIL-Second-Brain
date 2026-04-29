# Risk Identification

## What it is
Like a ship's captain cataloguing every leak, weak hull section, and faulty engine *before* leaving port — risk identification is the systematic process of discovering and documenting all potential threats, vulnerabilities, and events that could negatively impact an organization's assets. It is the first step in the risk management lifecycle, producing a risk register as its primary output.

## Why it matters
In 2017, Equifax suffered a breach exposing 147 million records because an unpatched Apache Struts vulnerability went unidentified in their asset inventory — a failure of risk identification at the most basic level. Had a proper asset discovery and threat enumeration process been in place, the known CVE (CVE-2017-5638) would have appeared in their risk register weeks before exploitation.

## Key facts
- **Risk = Threat × Vulnerability × Impact** — identification must capture all three components, not just threats alone
- Common identification methods include vulnerability scans, penetration testing, asset inventories, threat intelligence feeds, and OSINT
- A **risk register** is the formal output: a documented list of identified risks with asset, threat source, vulnerability, and likelihood noted
- Risk identification feeds directly into **risk analysis** (qualitative or quantitative) — you cannot analyze what you haven't named
- NIST SP 800-30 provides the formal framework for risk identification in federal contexts; ISO 27005 covers it in enterprise contexts
- **Threat modeling** (e.g., STRIDE) is a structured risk identification technique specifically used during software/system design phases

## Related concepts
[[Risk Register]] [[Threat Modeling]] [[Vulnerability Assessment]] [[Risk Analysis]] [[Asset Management]]