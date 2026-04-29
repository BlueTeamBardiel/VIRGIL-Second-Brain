# Credit Card Fraud

## What it is
Like a counterfeiter who studies a genuine bill under a microscope to replicate every detail, credit card fraudsters clone or steal card data to impersonate legitimate cardholders. Precisely, credit card fraud is the unauthorized use of payment card information — account numbers, CVVs, expiration dates — to make purchases or withdraw funds without the cardholder's consent.

## Why it matters
In 2013, attackers compromised Target's point-of-sale systems using malware called BlackPOS, harvesting magnetic stripe data from over 40 million cards in real time. The stolen track data was sold on dark web carding forums and encoded onto blank cards for physical "cashing out" — a complete fraud pipeline from breach to brick-and-mortar theft. This attack directly accelerated the U.S. shift to EMV chip cards.

## Key facts
- **Card-present vs. card-not-present (CNP) fraud**: CNP fraud dominates today because chip cards stopped physical cloning; online transactions don't require the physical card
- **Track 1 and Track 2 data**: Magnetic stripe stores two data tracks; Track 2 (account number + expiry + service code) is the primary target for cloning
- **CVV2 is never stored**: PCI-DSS explicitly prohibits merchants from storing the card verification value post-authorization — its theft indicates a live skimming or phishing attack, not a database breach
- **Skimmers vs. shimmers**: Traditional skimmers read magnetic stripes; shimmers are paper-thin devices inserted into chip readers to capture EMV transaction data (though limited in exploitability)
- **PCI-DSS compliance** requires encryption of cardholder data at rest and in transit, regular penetration testing, and network segmentation of cardholder data environments (CDE)

## Related concepts
[[PCI-DSS]] [[Skimming Attacks]] [[Card-Not-Present Fraud]] [[Point-of-Sale Malware]] [[Social Engineering]]