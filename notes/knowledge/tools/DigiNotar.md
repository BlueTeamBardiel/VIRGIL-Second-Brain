# DigiNotar

## What it is
Imagine a notary public who secretly stamps "authentic" on thousands of forged documents while criminals watch over their shoulder — that's what happened here. DigiNotar was a Dutch Certificate Authority (CA) that was compromised in 2011, allowing attackers to issue fraudulent SSL/TLS certificates for major domains including google.com, enabling large-scale man-in-the-middle attacks.

## Why it matters
After the breach, Iranian users attempting to reach Google were silently intercepted — their browsers trusted the fraudulent DigiNotar-signed certificate and showed no warning, allowing attackers to read encrypted traffic. This demonstrated that the entire HTTPS trust model collapses if even one CA in the chain is compromised, since browsers trusted any certificate DigiNotar signed.

## Key facts
- Attackers issued over **500 fraudulent certificates** for high-value domains including Google, Mozilla, Microsoft, and the CIA
- The breach was traced to an Iranian threat actor; an estimated **300,000 Iranian users** had their Google traffic intercepted
- DigiNotar failed to detect or disclose the breach promptly — it was discovered when a user in Iran noticed a certificate anomaly and reported it publicly
- Following exposure, all major browsers **revoked trust** in DigiNotar's root certificate within days, effectively destroying the company; DigiNotar filed for bankruptcy shortly after
- The incident directly accelerated adoption of **Certificate Transparency (CT) logs** and **HPKP (HTTP Public Key Pinning)** as mechanisms to detect rogue certificate issuance

## Related concepts
[[Certificate Authority]] [[Man-in-the-Middle Attack]] [[Certificate Transparency]] [[SSL/TLS]] [[Public Key Infrastructure]]