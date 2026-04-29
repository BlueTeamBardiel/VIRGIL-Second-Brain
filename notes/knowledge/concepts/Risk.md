# Risk

## What it is
Like a chess player calculating whether to sacrifice a bishop — weighing the value of what you might lose against the probability the opponent takes it — risk is the intersection of likelihood and impact. Formally, **Risk = Threat × Vulnerability × Asset Value**: the probability that a threat exploits a vulnerability multiplied by the consequences if it does.

## Why it matters
In 2017, Equifax left an Apache Struts vulnerability unpatched for 78 days despite a known exploit existing in the wild. The risk was calculable beforehand — a critical CVE, internet-facing systems, highly sensitive PII — yet it went unaddressed, resulting in 147 million records exposed and roughly $575 million in FTC settlements. Proper risk assessment would have flagged this as *high likelihood × catastrophic impact = unacceptable risk*.

## Key facts
- **Risk = Threat × Vulnerability × Asset Value** is the foundational formula; removing any variable collapses the risk to zero
- The four risk responses are: **Accept, Transfer, Avoid, Mitigate** (mnemonic: *ATAM*)
- **Residual risk** is what remains after controls are applied; **inherent risk** is the raw risk before any controls
- **Risk appetite** is how much risk an organization *willingly* accepts; **risk tolerance** is the acceptable variance around that threshold
- Quantitative risk uses numbers: **ALE = SLE × ARO** (Annual Loss Expectancy = Single Loss Expectancy × Annualized Rate of Occurrence); qualitative risk uses descriptors like High/Medium/Low

## Related concepts
[[Threat]] [[Vulnerability]] [[Asset Management]] [[Risk Assessment]] [[ALE and SLE]] [[Security Controls]]