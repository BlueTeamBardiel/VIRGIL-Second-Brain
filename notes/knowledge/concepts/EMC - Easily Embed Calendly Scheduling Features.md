# EMC - Easily Embed Calendly Scheduling Features

## What it is
Like dropping a vending machine into a lobby — someone else built it, you just cut the hole in the wall — embedding Calendly means inserting a third-party scheduling widget into your own web application via iframe or JavaScript snippet. EMC (Easily Embed Calendly) refers to the practice of integrating Calendly's scheduling functionality directly into websites or apps using their provided embed codes, allowing users to book appointments without leaving your domain.

## Why it matters
Third-party embeds are a classic supply chain attack surface: if Calendly's CDN-hosted JavaScript is compromised, every site embedding it inherits the malicious payload — a scenario analogous to the Magecart attacks that skimmed payment data from embedded scripts. Defenders must treat embedded scheduling widgets as third-party dependencies requiring Content Security Policy (CSP) headers and Subresource Integrity (SRI) checks to limit blast radius.

## Key facts
- **Third-party trust risk**: Embedded iframes and scripts run with the trust level of the embedding page, making them vectors for clickjacking and script injection if not properly sandboxed.
- **CSP mitigation**: A properly configured `Content-Security-Policy` header should whitelist only `calendly.com` domains to prevent unauthorized script execution from the embed point.
- **iframe sandboxing**: Using the `sandbox` attribute on iframes restricts capabilities (e.g., `allow-forms`, `allow-scripts`) reducing privilege escalation from embedded content.
- **Data exposure risk**: Calendly embeds can leak referrer data, user metadata, and session context to the third-party vendor — relevant to privacy compliance (GDPR, CCPA).
- **SRI not applicable to iframes**: Subresource Integrity protects `<script>` and `<link>` tags but cannot verify iframe content integrity, making iframe embeds inherently harder to validate.

## Related concepts
[[Supply Chain Attack]] [[Content Security Policy]] [[Clickjacking]] [[Subresource Integrity]] [[Third-Party Risk Management]]