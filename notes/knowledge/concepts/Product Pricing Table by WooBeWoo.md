# Product Pricing Table by WooBeWoo

## What it is
Like a restaurant menu board that anyone can edit if the kitchen door is left unlocked, Product Pricing Table by WooBeWoo is a WordPress/WooCommerce plugin that displays product pricing grids — and has carried known vulnerabilities allowing unauthorized users to inject malicious content or manipulate plugin behavior. It is a third-party e-commerce plugin with a history of Cross-Site Scripting (XSS) and privilege escalation weaknesses affecting WordPress installations.

## Why it matters
An attacker targeting a WooCommerce storefront could exploit a stored XSS vulnerability in this plugin to inject malicious JavaScript into the pricing table visible to all visitors — silently redirecting customers to a phishing page that mimics the checkout flow and harvests payment credentials. This represents a classic supply-chain risk where trusting a third-party plugin introduces a critical attack surface into an otherwise hardened application.

## Key facts
- The plugin has been assigned CVEs related to **Stored Cross-Site Scripting (XSS)**, allowing low-privileged users (e.g., Contributors) to inject persistent scripts.
- Vulnerabilities often stem from **insufficient input sanitization and output escaping** on shortcode parameters and admin-facing fields.
- Exploitation typically requires only **Contributor-level authentication** or less, lowering the attacker barrier significantly.
- Risk is amplified in **multi-vendor or open-registration WordPress sites** where untrusted users can create posts containing plugin shortcodes.
- Remediation follows standard plugin hardening: **update to patched versions, enforce least-privilege roles, and use a WAF** to filter malicious input patterns.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[WordPress Plugin Vulnerabilities]] [[Input Validation and Sanitization]] [[Stored vs Reflected XSS]] [[Least Privilege]]