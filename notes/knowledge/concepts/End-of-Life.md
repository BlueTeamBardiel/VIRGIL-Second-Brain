# End-of-Life

## What it is
Like a car model discontinued by its manufacturer — no more recall fixes, no more spare parts, no more safety updates — End-of-Life (EOL) describes software or hardware that a vendor no longer supports with patches, updates, or security fixes. Once EOL status is reached, any newly discovered vulnerabilities in that product will remain permanently unpatched.

## Why it matters
In 2017, the WannaCry ransomware attack devastated organizations worldwide largely because it exploited SMBv1 vulnerabilities in Windows XP and Windows Server 2003 — both EOL systems that Microsoft had stopped patching years earlier. The UK's National Health Service was crippled because hospitals were still running EOL Windows XP on critical infrastructure, demonstrating that EOL systems in production environments create systemic, unmitigable risk.

## Key facts
- **Windows XP reached EOL on April 8, 2014**; Microsoft issued an emergency out-of-band patch for WannaCry in 2017 only due to the extraordinary global impact.
- EOL systems violate **PCI-DSS, HIPAA, and NIST 800-53 compliance requirements**, which mandate that systems receive security updates.
- The correct compensating controls for unavoidable EOL systems include **network segmentation, application whitelisting, and enhanced monitoring** — not simply accepting the risk.
- EOL differs from **End-of-Support (EOS)**: EOS may end general support while extended security updates continue; EOL means all support has fully ceased.
- On the **Security+ exam**, EOL systems are frequently cited as examples of **system/application vulnerabilities** and as drivers for patch management and asset lifecycle policies.

## Related concepts
[[Patch Management]] [[Vulnerability Management]] [[Legacy Systems]] [[Risk Acceptance]] [[Configuration Management]]