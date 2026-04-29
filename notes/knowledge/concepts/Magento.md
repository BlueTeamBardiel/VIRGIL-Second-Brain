# Magento

## What it is
Think of Magento like a pre-built shopping mall where store owners customize the layout but share the same plumbing — if the pipes are compromised, every store is affected. Magento is an open-source e-commerce platform written in PHP, used by thousands of online retailers to manage storefronts, product catalogs, and payment processing. Its plugin-heavy architecture and widespread deployment make it a high-value target for attackers.

## Why it matters
In the "MageCart" family of attacks, threat actors exploit unpatched Magento vulnerabilities (such as CVE-2019-7139, a SQL injection flaw) to inject malicious JavaScript skimmers into checkout pages, silently harvesting credit card data from thousands of customers before detection. British Airways and Ticketmaster both suffered breaches traced to this attack pattern. Defenders must prioritize patch management and Content Security Policy (CSP) headers to prevent unauthorized script execution.

## Key facts
- **MageCart attacks** use JavaScript skimmers injected into Magento checkout forms to exfiltrate payment card data (PCI DSS scope violation).
- Magento 1.x reached **end-of-life in June 2020**, leaving unpatched installations as persistent targets in the wild.
- Default Magento admin panels are commonly found at `/admin` or `/index.php/admin` — a predictable path attackers actively scan for.
- SQL injection and Remote Code Execution (RCE) vulnerabilities have repeatedly appeared in Magento core and third-party extensions.
- Adobe acquired Magento in 2018 and rebranded it **Adobe Commerce**, though the open-source community edition remains widely used.

## Related concepts
[[SQL Injection]] [[JavaScript Skimming]] [[Content Security Policy]] [[PCI DSS]] [[Supply Chain Attack]]