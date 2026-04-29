# Data Classification Policy

## What it is
Think of a hospital's color-coded wristbands: red means critical, yellow means caution, green means stable — staff instantly know how to handle each patient. A data classification policy works the same way, assigning formal sensitivity labels (e.g., Public, Internal, Confidential, Top Secret) to organizational data so that every system and employee knows exactly what protections apply. It's a governance framework that defines how data is categorized, labeled, handled, stored, transmitted, and destroyed based on its sensitivity and business value.

## Why it matters
In 2017, an Equifax employee stored unencrypted Social Security Numbers in a folder accessible to hundreds of internal users because no classification policy enforced access controls tied to data sensitivity. Had a policy mandated that PII/financial data be labeled "Restricted" with corresponding encryption-at-rest and least-privilege access requirements, the blast radius of their breach affecting 147 million people would have been dramatically reduced.

## Key facts
- **Four common government classification levels**: Unclassified, Confidential, Secret, Top Secret — commercial equivalents are typically Public, Internal, Confidential, Restricted
- **Data owners** (not IT) are responsible for assigning classification labels; IT is responsible for enforcing the technical controls that match each label
- **Mandatory vs. Discretionary**: Government systems often use Mandatory Access Control (MAC) tied to classification; commercial environments more commonly use Discretionary Access Control (DAC)
- **Declassification** is a formal process — data doesn't automatically drop in sensitivity; someone with authority must review and reclassify it
- Classification labels drive downstream security controls: encryption requirements, retention schedules, DLP rules, and data destruction methods (e.g., degaussing vs. shredding for physical media)

## Related concepts
[[Data Loss Prevention]] [[Access Control Models]] [[Information Lifecycle Management]] [[Data Handling Procedures]] [[Personally Identifiable Information]]