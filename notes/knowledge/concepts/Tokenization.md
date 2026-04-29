# Tokenization

## What it is
Like a coat check at a restaurant — your actual coat (sensitive data) stays locked in the back, and you carry only a numbered ticket (the token) that has no value to anyone who steals it. Tokenization replaces sensitive data (such as a credit card number) with a non-sensitive placeholder called a token, which maps back to the original value only through a secure, isolated token vault. Unlike encryption, the token itself contains no mathematical relationship to the original data.

## Why it matters
During the 2013 Target breach, attackers scraped payment card data directly from point-of-sale RAM before it could be encrypted in transit. Had tokenization been fully implemented at the POS layer, the scraped values would have been useless tokens — the actual PANs (Primary Account Numbers) would never have existed on those systems, rendering the memory-scraping attack moot.

## Key facts
- Tokenization is **not encryption** — tokens cannot be reversed through an algorithm; reversal requires lookup access to the token vault
- Commonly used to reduce **PCI DSS scope**: systems that only handle tokens are largely removed from cardholder data environment (CDE) compliance requirements
- Token vaults must be **hardened and isolated** — they become a high-value target since they hold the actual mapping
- **Format-preserving tokens** mimic the structure of the original data (e.g., 16-digit token for a 16-digit card number) to avoid breaking legacy systems
- Tokenization protects **data at rest and in use**, while TLS/encryption primarily protects **data in transit** — these are complementary, not interchangeable

## Related concepts
[[Data Masking]] [[Encryption]] [[PCI DSS]] [[Data Loss Prevention]]