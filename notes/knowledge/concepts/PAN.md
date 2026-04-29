# PAN

## What it is
Think of a PAN like a social security number for your credit card — a unique identifier that follows it everywhere and proves its identity. A Primary Account Number (PAN) is the 13–19 digit number embossed on a payment card that identifies the card issuer and account holder, governed by the ISO/IEC 7812 standard.

## Why it matters
In the 2013 Target breach, attackers used RAM-scraping malware on point-of-sale terminals to harvest PANs in plaintext during the split second between card swipe and encryption — stealing over 40 million card numbers. This attack directly drove PCI DSS requirements mandating that PANs be rendered unreadable (via tokenization, truncation, or encryption) anywhere they are stored, processed, or transmitted.

## Key facts
- PCI DSS requires that stored PANs be protected using strong cryptography, tokenization, or truncation — displaying no more than the first six and last four digits is the maximum allowed
- The first six digits of a PAN form the Bank Identification Number (BIN/IIN), identifying the issuing institution
- PANs are considered **sensitive authentication data** under PCI DSS and must never be stored post-authorization in their full form
- Tokenization replaces a PAN with a surrogate value (token) that has no exploitable mathematical relationship to the original number
- Truncation, hashing, and encryption are all acceptable protection methods, but hashed and truncated versions of the *same* PAN must not be present in the same environment — they can be correlated to reconstruct the full PAN

## Related concepts
[[PCI DSS]] [[Tokenization]] [[Data Masking]] [[Point-of-Sale Malware]] [[Sensitive Data Exposure]]