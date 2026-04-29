# Data Leakage

## What it is
Like a sealed envelope that bleeds ink through its walls — the secret is technically contained, but the contents are readable from the outside. Data leakage occurs when sensitive information is unintentionally exposed to unauthorized parties through misconfigured systems, insecure channels, or inadvertent disclosure — without necessarily involving a deliberate breach.

## Why it matters
In 2021, a misconfigured Microsoft Power Apps portal exposed 38 million records — including COVID vaccination data and employee information — because the default setting allowed public access. No attacker needed to "break in"; the data was simply walking out the front door. Defenders must treat misconfiguration as a first-class threat, not an edge case.

## Key facts
- **DLP (Data Loss Prevention)** tools inspect traffic at endpoints, email gateways, and cloud services to detect and block sensitive data leaving the organization — a primary technical control against leakage.
- Data leakage differs from a **data breach**: leakage is often accidental (misconfiguration, human error); a breach typically implies intentional unauthorized access.
- **Metadata leakage** is a common overlooked vector — Office documents, photos, and PDFs often embed author names, GPS coordinates, or internal network paths.
- Cloud storage misconfiguration (public S3 buckets, open Azure Blob containers) is the most frequently cited cause of large-scale data leakage incidents.
- **Covert channels** — such as DNS tunneling or steganography — can represent intentional data leakage designed to evade DLP inspection.

## Related concepts
[[Data Loss Prevention (DLP)]] [[Insider Threat]] [[Cloud Misconfiguration]] [[Covert Channel]] [[Information Classification]]