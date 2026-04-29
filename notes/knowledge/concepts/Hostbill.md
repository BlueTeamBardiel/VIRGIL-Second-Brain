# Hostbill

## What it is
Like a cash register combined with a customer database for a web hosting shop, HostBill is a billing and client management platform specifically designed for hosting providers, domain registrars, and cloud service companies. It handles invoicing, provisioning, and customer account management in one system. Because it sits at the intersection of financial data and service provisioning, it represents a high-value administrative target.

## Why it matters
In 2023, threat actors targeted hosting companies running HostBill by exploiting weak API keys and overprivileged admin accounts to mass-provision fraudulent VPS instances for cryptomining and spam infrastructure. A compromised HostBill instance gives an attacker not just billing data (credit cards, PII) but also direct control over provisioning APIs — meaning they can spin up or destroy customer services at will. Defenders must treat HostBill installations with the same rigor as core financial systems.

## Key facts
- HostBill exposes a REST API that, if inadequately secured with default or weak API tokens, allows unauthenticated provisioning commands — a critical misconfiguration risk
- It stores PCI-relevant data (partial card numbers, billing addresses) making it subject to PCI-DSS scope if full card data flows through it
- Admin panel brute-force protection is not enabled by default, making it susceptible to credential stuffing attacks against `/admin` login endpoints
- Plugin architecture allows third-party integrations (WHMCS migrations, payment gateways) that can introduce supply chain vulnerabilities
- Hardcoded database credentials in misconfigured installs have historically leaked via exposed `config.php` files indexed by search engines

## Related concepts
[[WHMCS]] [[API Security]] [[Credential Stuffing]] [[PCI-DSS]] [[Supply Chain Attack]]