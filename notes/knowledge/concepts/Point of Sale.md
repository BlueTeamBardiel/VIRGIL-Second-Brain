# Point of Sale

## What it is
Think of a POS system as the cash register evolved into a networked computer — it accepts payment cards, processes transactions, and talks to backend servers, making it a live money-handling node on a corporate network. Precisely, a Point of Sale (POS) system is the hardware/software combination used to process payment card transactions at retail environments, capturing cardholder data including Track 1/Track 2 magnetic stripe data or chip data during the transaction window.

## Why it matters
In the 2013 Target breach, attackers compromised POS terminals by first pivoting through an HVAC vendor's network credentials, then deploying RAM-scraping malware (BlackPOS) that harvested unencrypted card data from process memory during the brief moment between card swipe and encryption — stealing 40 million card numbers. This attack fundamentally reshaped how defenders think about network segmentation between POS environments and corporate networks.

## Key facts
- **RAM scraping** is the dominant POS attack technique — malware reads Track 2 data from process memory during the tiny window when it exists in plaintext before encryption
- POS systems are explicitly scoped under **PCI DSS** (Payment Card Industry Data Security Standard), which mandates encryption, network segmentation, and access controls
- **Point-to-Point Encryption (P2PE)** encrypts card data at the moment of swipe, eliminating the plaintext window that RAM scrapers exploit
- POS malware families include **BlackPOS, Alina, PoSeidon, and MalumPOS** — commonly delivered via lateral movement after initial network compromise
- Attackers frequently gain initial access through **third-party vendor credentials** (supply chain exposure) rather than attacking the POS directly

## Related concepts
[[RAM Scraping]] [[PCI DSS]] [[Network Segmentation]] [[Supply Chain Attack]] [[Point-to-Point Encryption]]