# Bank Fraud

## What it is
Like a counterfeiter slipping fake bills into a cash register during a busy rush, bank fraud involves deceiving financial institutions or their customers to illegally obtain money or assets. Precisely, it is any scheme that uses deception, false pretenses, or misrepresentation to fraudulently acquire funds, credit, or property held by a financial institution. It encompasses both technical attacks and social engineering targeting banking systems or individuals.

## Why it matters
In 2016, attackers compromised SWIFT banking credentials at Bangladesh Bank and fraudulently transferred $81 million by injecting malicious instructions into interbank messaging systems — a real-world example where authentication failures met insider threat vectors. Defenders responded by implementing multi-party authorization controls and anomaly detection on transaction patterns, directly mapping to security concepts tested in CySA+.

## Key facts
- Bank fraud is a federal crime under **18 U.S.C. § 1344**, carrying penalties up to 30 years imprisonment — making intent and knowledge legally critical elements
- **Account takeover (ATO)** is the dominant technical form: attackers use credential stuffing or phishing to authenticate as the legitimate account holder
- **Synthetic identity fraud** combines real and fabricated PII to create ghost accounts that pass KYC (Know Your Customer) checks — a growing threat not caught by traditional fraud filters
- **Insider threats** account for roughly 30% of bank fraud cases; privileged access misuse is the primary vector
- Behavioral analytics and **User and Entity Behavior Analytics (UEBA)** are the primary detective controls recommended by FFIEC guidelines for identifying fraudulent transaction patterns

## Related concepts
[[Phishing]] [[Account Takeover]] [[Synthetic Identity Fraud]] [[Credential Stuffing]] [[UEBA]] [[Insider Threat]]