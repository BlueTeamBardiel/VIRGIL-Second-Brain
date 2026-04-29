# Target Breach 2013

## What it is
Like a burglar who can't pick the front lock of a bank, so they compromise the cleaning crew's badge instead — the Target breach was a landmark supply chain attack where attackers infiltrated one of the largest U.S. retailers not through Target directly, but through a third-party HVAC vendor. Approximately 40 million credit/debit card numbers and 70 million customer records were exfiltrated between November and December 2013.

## Why it matters
This breach fundamentally changed how organizations assess third-party vendor risk. The attackers used stolen credentials from Fazio Mechanical Services to access Target's vendor portal, then pivoted laterally to point-of-sale (POS) systems and deployed RAM-scraping malware called BlackPOS to harvest unencrypted card data in memory during transaction processing.

## Key facts
- **Initial vector:** Phishing email to Fazio Mechanical (HVAC vendor) → stolen VPN credentials → access to Target's network
- **Malware used:** BlackPOS (a RAM scraper), which harvested Track 1/Track 2 card data from POS memory *before* encryption
- **Network segmentation failure:** Vendor portal was not properly isolated from the POS network — a critical control failure
- **Data exfiltration:** Stolen card data was staged on internal FTP drop servers, then pushed to external C2 servers
- **Financial impact:** ~$202 million in total costs; Target's CIO and CEO both resigned following the breach

## Related concepts
[[Supply Chain Attack]] [[RAM Scraping Malware]] [[Point-of-Sale Security]] [[Network Segmentation]] [[Third-Party Risk Management]]