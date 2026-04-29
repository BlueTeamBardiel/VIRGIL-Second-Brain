# Nitro PDF Pro

## What it is
Like a Swiss Army knife that also has a hidden lockpick built in, Nitro PDF Pro is a legitimate document productivity application that has repeatedly surfaced as an attack vector despite its benign purpose. It is a commercial PDF creation, editing, and digital signature platform widely deployed in enterprise environments — and that wide deployment makes it a high-value target.

## Why it matters
In 2020, Nitro Software suffered a significant data breach where attackers exfiltrated a database containing millions of user records, including email addresses, hashed passwords, and document metadata from enterprise customers including major tech and financial firms. Because Nitro PDF Pro integrates with Google Drive, OneDrive, and SharePoint, a credential compromise could cascade into cloud document repository access — a classic supply chain trust exploitation scenario.

## Key facts
- The **2020 Nitro breach** exposed approximately 77 million user records; the database was reportedly offered for sale on dark web forums for $1.
- Nitro PDF Pro uses **cloud-based document processing**, meaning files uploaded for conversion or signing may temporarily reside on third-party infrastructure — a data residency risk relevant to compliance frameworks like GDPR and HIPAA.
- Like Adobe Acrobat, Nitro PDF has had **CVEs related to malicious PDF parsing**, where crafted documents can trigger remote code execution (RCE) when opened.
- Enterprise deployments often grant Nitro **broad OAuth permissions** to cloud storage, making it a lateral movement pivot point if compromised.
- Patch management for third-party productivity tools like Nitro is frequently overlooked compared to OS-level patching — a common gap exploited in **vulnerability management** assessments.

## Related concepts
[[Supply Chain Attack]] [[Credential Stuffing]] [[Third-Party Risk Management]] [[PDF Malware]] [[OAuth Token Abuse]]