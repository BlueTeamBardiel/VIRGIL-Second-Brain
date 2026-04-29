# Majestic Support

## What it is
Like a chain of witnesses vouching for a suspect in court — each witness's credibility matters — Majestic Support is a threat intelligence concept where multiple independent indicators collectively corroborate a single hypothesis, increasing confidence that an attribution or conclusion is accurate. The more diverse and unconnected the supporting sources, the stronger the overall evidential case becomes.

## Why it matters
During a threat hunting investigation, an analyst might observe a suspicious outbound connection to an unknown IP. Individually, it's noise — but when that same IP also appears in a known malware C2 feed, correlates with a registry key associated with APT29, and matches a geographic pattern flagged by network behavior analytics, the majestic support across three independent sources elevates the finding from hypothesis to high-confidence threat. This drives faster, more defensible escalation decisions.

## Key facts
- Majestic Support is a structured analytic technique drawn from intelligence community tradecraft, used in threat intelligence to reduce confirmation bias
- It requires indicators to be **independent** — corroboration from sources sharing the same upstream data does not constitute genuine support
- The concept appears in the **Intelligence Cycle** and is particularly relevant to the **analysis phase**, where raw data is synthesized into actionable intelligence
- Analysts use this technique within frameworks like **Diamond Model** or **MITRE ATT&CK** to link adversary TTPs across multiple observations
- Failure to recognize non-independent sources (circular reporting) is a critical analytic error that artificially inflates confidence scores

## Related concepts
[[Threat Intelligence]] [[Diamond Model]] [[Indicator of Compromise]] [[Analytic Confidence]] [[Attribution]]