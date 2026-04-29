# software update mechanisms

## What it is
Like a pharmacist verifying a prescription's authenticity before dispensing medication, software update systems must verify that patches are genuinely from the vendor before installing them. Update mechanisms are the automated or manual processes by which software retrieves, validates, and applies patches — typically using cryptographic signatures, hash verification, and trusted delivery channels (HTTPS, CDNs) to ensure integrity and authenticity.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries compromised the build pipeline so that *legitimate, signed updates* delivered malicious code (SUNBURST) to ~18,000 organizations. This demonstrated that even cryptographically valid updates can be weaponized if the signing infrastructure itself is compromised — defenders can't simply trust a valid signature without also securing the entire build and release process.

## Key facts
- **Downgrade attacks** trick clients into installing older, vulnerable versions; mitigated by version pinning and monotonic version counters
- **Code signing** uses vendor private keys to sign update packages; clients verify with the vendor's public certificate before execution
- **Hash verification** (SHA-256) confirms integrity — the file wasn't corrupted or tampered with *in transit*, but does NOT confirm the source
- **Auto-update vs. manual patching**: Auto-updates reduce mean time to patch but expand attack surface if the update channel is compromised; a key risk/benefit tradeoff on Security+ exams
- **WSUS (Windows Server Update Services)** and similar centralized update servers are high-value targets — compromise one to push malicious updates to an entire enterprise fleet

## Related concepts
[[supply chain attacks]] [[code signing]] [[patch management]] [[integrity verification]] [[man-in-the-middle attacks]]