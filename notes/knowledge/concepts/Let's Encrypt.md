# Let's Encrypt

## What it is
Think of it like a free DMV that automatically issues driver's licenses for websites — no appointment, no fee, no human clerk needed. Let's Encrypt is a free, automated, open Certificate Authority (CA) operated by the Internet Security Research Group (ISRG) that issues Domain Validation (DV) TLS/SSL certificates via the ACME protocol. It democratized HTTPS by eliminating the cost and manual overhead traditionally associated with certificate issuance.

## Why it matters
Before Let's Encrypt launched in 2015, small sites often ran unencrypted HTTP because paid certificates cost $100+/year — making them attractive targets for credential-stealing man-in-the-middle attacks on public Wi-Fi. Let's Encrypt enabled widespread HTTPS adoption, but attackers now also abuse it: phishing sites routinely obtain valid Let's Encrypt certificates to display the padlock icon, tricking users into trusting malicious domains. This is why "HTTPS" does not equal "safe" — it only means the connection is encrypted, not that the destination is legitimate.

## Key facts
- Issues **Domain Validation (DV)** certificates only — it verifies domain control, not organizational identity (no OV or EV certs)
- Certificates expire every **90 days** by design, encouraging automation and limiting exposure from compromised certs
- Uses the **ACME protocol** (Automated Certificate Management Environment, RFC 8555) for automated issuance and renewal
- Crossed **300 million active certificates** and now secures the majority of HTTPS websites globally
- Because it's free and automated, it is commonly exploited by **threat actors to legitimize phishing infrastructure** — a known indicator analysts watch for in threat intelligence

## Related concepts
[[TLS/SSL]] [[Certificate Authority]] [[Public Key Infrastructure (PKI)]] [[Man-in-the-Middle Attack]] [[Domain Validation]]