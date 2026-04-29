# Smart Online Order for Clover

## What it is
Think of it like a drive-through window bolted onto a brick-and-mortar restaurant — it extends the existing Clover point-of-sale (POS) ecosystem to accept orders placed remotely via web or mobile. Smart Online Order is a third-party integration plugin/service that connects online ordering functionality directly into Clover POS terminals, syncing digital orders with in-store inventory and payment processing in real time.

## Why it matters
POS integrations represent a high-value attack surface because they bridge the public internet with internal payment infrastructure. In 2023-era retail breaches, attackers have targeted exactly these integration layers — exploiting misconfigured API keys or insecure third-party plugins to intercept cardholder data in transit between the online ordering front-end and the POS backend, effectively bypassing the merchant's hardened internal network perimeter.

## Key facts
- Smart Online Order communicates with Clover via the **Clover REST API**, meaning exposed or hardcoded API tokens represent a direct path to transaction and customer data
- The integration falls under **PCI DSS scope** — the online ordering component must be assessed as part of the cardholder data environment (CDE) because it handles PANs (Primary Account Numbers)
- Third-party plugins like this are a **supply chain risk vector** (relevant to CySA+ supply chain threat modeling); a compromise of the plugin vendor affects all downstream merchants
- Data transmitted between the web front-end and Clover backend should be protected with **TLS 1.2+**; failure to enforce this enables on-path (MITM) attacks
- Merchants must ensure the plugin vendor is a **PCI DSS-compliant service provider** and appears on their SAQ (Self-Assessment Questionnaire) vendor list

## Related concepts
[[Point-of-Sale Security]] [[PCI DSS Compliance]] [[API Security]] [[Supply Chain Risk Management]] [[Third-Party Integration Risks]]