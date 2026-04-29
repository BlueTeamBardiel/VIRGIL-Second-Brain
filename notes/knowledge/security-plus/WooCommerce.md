# WooCommerce

## What it is
Think of WooCommerce like a cash register bolted onto an existing storefront — it transforms a standard WordPress website into a fully functional e-commerce platform. Precisely, WooCommerce is an open-source WordPress plugin that adds shopping cart, payment processing, and inventory management capabilities to any WordPress site. Because it inherits WordPress's architecture, it also inherits its attack surface.

## Why it matters
In 2021, a critical SQL injection vulnerability (CVE-2021-32789) in WooCommerce allowed unauthenticated attackers to extract sensitive data — including hashed passwords, email addresses, and payment metadata — from affected databases. Defenders patching this required immediate updates across potentially millions of installations, demonstrating how a single plugin vulnerability can cascade into a massive supply chain risk across the WordPress ecosystem.

## Key facts
- WooCommerce powers approximately **28% of all online stores** globally, making it an extremely high-value target for attackers seeking payment card data
- Payment data exposure risk: misconfigured WooCommerce installations may log full credit card details in debug files if **WP_DEBUG_LOG** is enabled in production
- WooCommerce stores customer PII and transaction records, placing it directly in scope for **PCI DSS compliance** requirements
- Plugin and theme supply chain attacks frequently target WooCommerce extensions — malicious actors have compromised legitimate plugins to inject **card-skimming scripts** (Magecart-style attacks)
- Default WordPress/WooCommerce installations expose predictable URL structures (`/wp-admin`, `/wp-json/wc/v3/`) that attackers enumerate during reconnaissance

## Related concepts
[[SQL Injection]] [[Magecart Attacks]] [[PCI DSS]] [[WordPress Security]] [[Supply Chain Attacks]]