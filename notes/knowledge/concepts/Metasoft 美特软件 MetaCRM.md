# Metasoft 美特软件 MetaCRM

## What it is
Like a filing cabinet left unlocked in a public lobby, MetaCRM is a Chinese-developed Customer Relationship Management (CRM) platform by Metasoft (美特软件) that centralizes sensitive customer data — contacts, sales records, communications — into a single accessible system. It is a web-based enterprise application used primarily by small-to-medium businesses in Chinese markets to manage customer pipelines and business relationships.

## Why it matters
CRM platforms are high-value targets because they aggregate personally identifiable information (PII) and business intelligence in one location. A threat actor compromising a MetaCRM deployment could exfiltrate entire customer databases, enabling spear-phishing campaigns, business email compromise (BEC), or competitive espionage — especially concerning given regulatory questions around data sovereignty when Chinese-developed software handles foreign customer records. Security teams assessing third-party software risk must evaluate where CRM data is stored and whether it transits servers subject to foreign jurisdiction.

## Key facts
- MetaCRM is a **web-based SaaS/on-premise hybrid** CRM, meaning attack surface includes both the web application layer (SQLi, XSS) and any self-hosted server misconfigurations
- CRM systems typically store **PII, financial data, and communication logs**, making them Category 1 targets under most data classification frameworks
- Supply chain risk applies: third-party CRM vendors may have **privileged API access** to internal systems, expanding the blast radius of a vendor compromise
- Regulatory concern: data processed by Chinese-headquartered software vendors may fall under **China's Data Security Law (DSL) and PIPL**, relevant when assessing cross-border data transfer risk
- During CySA+ threat modeling, CRM platforms fall under **business application attack surface** requiring assessment of authentication controls, role-based access, and API security

## Related concepts
[[CRM Security]] [[Third-Party Risk Management]] [[Data Sovereignty]] [[PII Protection]] [[Supply Chain Attack]]