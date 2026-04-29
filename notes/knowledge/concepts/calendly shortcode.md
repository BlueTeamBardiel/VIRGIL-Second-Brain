# calendly shortcode

## What it is
Like a sticky note on your office door that says "scan here to book a meeting," a Calendly shortcode is an embedded scheduling widget or short URL snippet that organizations paste into websites, emails, or portals to let visitors book appointments. Technically, it is a lightweight embed code (typically JavaScript snippet or a `https://calendly.com/username` short link) that renders an interactive scheduling interface within third-party web properties.

## Why it matters
Attackers conduct phishing campaigns that clone legitimate Calendly booking pages to harvest credentials or deliver malware — victims trust the familiar Calendly interface and willingly enter information. In one documented tactic, threat actors embed malicious shortcodes in spear-phishing emails posing as vendor meeting invitations, redirecting targets to credential-harvesting pages that mimic the authentic scheduler. Defenders must validate that embedded scheduling links resolve to `calendly.com` domains and that Content Security Policy (CSP) headers restrict unauthorized iframe sources.

## Key facts
- Calendly shortcodes are third-party JavaScript embeds — they introduce **supply chain risk** because a compromise of Calendly's CDN could inject malicious scripts into every host site.
- Embedding third-party widgets expands a site's **attack surface** by loading external scripts that bypass the host organization's security controls.
- Attackers register **typosquatted domains** (e.g., `ca1endly.com`) and create visually identical booking pages to intercept meeting data and credentials.
- CSP `frame-src` and `script-src` directives should explicitly **allowlist** `calendly.com` to prevent unauthorized scheduling widget substitution.
- From a **data privacy** standpoint, Calendly collects PII (names, emails, IP addresses); organizations must account for this in GDPR/CCPA data processing agreements.

## Related concepts
[[Supply Chain Attack]] [[Content Security Policy]] [[Typosquatting]] [[Phishing]] [[Third-Party Risk Management]]