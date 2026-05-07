# Brand Impersonation

## What it is
Imagine a counterfeiter printing near-perfect Rolex boxes to sell cheap watches — the packaging builds trust the product doesn't deserve. Brand impersonation is the practice of attackers mimicking the visual identity, domain names, logos, or communication style of trusted organizations (banks, tech companies, government agencies) to deceive victims into surrendering credentials, money, or sensitive data.

## Why it matters
In 2023, Microsoft was the most impersonated brand globally, appearing in over 30% of phishing kit deployments. Attackers register lookalike domains like "micros0ft-support[.]com," clone the legitimate login page pixel-perfectly, and harvest Office 365 credentials at scale — often selling access to ransomware groups within 24 hours of capture.

## Key facts
- **Homograph attacks** exploit Unicode characters (e.g., Cyrillic "а" vs. Latin "a") to create domains visually identical to legitimate ones — a direct brand impersonation technique
- **Typosquatting** registers common misspellings of target brands (e.g., "paypa1.com") and is categorized under brand impersonation in the CySA+ domain on threat intelligence
- **DMARC, DKIM, and SPF** are the primary email authentication controls that prevent attackers from sending email *as* a legitimate brand's actual domain
- Impersonation attacks are classified under **Business Email Compromise (BEC)** when targeting executive identities, carrying average losses exceeding $125,000 per incident (FBI IC3)
- **Certificate transparency logs** and tools like DomainTools or Shodan can detect newly registered lookalike domains before phishing campaigns launch — a proactive defense measure

## Related concepts
[[Phishing]] [[Typosquatting]] [[Business Email Compromise]] [[DMARC]] [[Social Engineering]]