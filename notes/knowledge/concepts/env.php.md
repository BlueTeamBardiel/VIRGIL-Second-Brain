# env.php

## What it is
Like a master key hidden under the doormat, `env.php` is a configuration file in Magento e-commerce installations that stores plaintext database credentials, encryption keys, and connection strings in a single, human-readable file. It is automatically generated during Magento setup and lives at `app/etc/env.php`, serving as the application's runtime configuration source.

## Why it matters
In 2022, attackers targeting Magento shops used automated scanners to find misconfigured web servers that served `env.php` directly over HTTP — instantly exposing database passwords, admin credentials, and cryptographic keys used to decrypt stored customer payment data. A single misconfigured Nginx or Apache rule (or a missing `.htaccess` restriction) was the only barrier between attackers and full database compromise.

## Key facts
- Contains the `crypt/key` value — the master encryption key Magento uses to protect sensitive data at rest; if stolen, all encrypted database fields are trivially decryptable
- Should never be web-accessible; proper hardening requires blocking access at the server level (e.g., `deny all` in `.htaccess` or Nginx `location` blocks)
- Frequently targeted by Magecart threat actors during reconnaissance phases before injecting payment-skimming JavaScript
- Exposure of `env.php` constitutes a PCI-DSS violation under Requirement 6 (secure systems) and Requirement 8 (access controls) because it contains credentials protecting cardholder data
- Static analysis tools and vulnerability scanners (e.g., Nikto, custom Shodan queries) specifically probe for this file path as a high-value target during web application assessments

## Related concepts
[[Sensitive Data Exposure]] [[Credential Harvesting]] [[Web Application Misconfiguration]] [[Magecart Attack]] [[PCI-DSS Compliance]]