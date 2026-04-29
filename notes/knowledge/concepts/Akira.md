# Akira

## What it is
Like a smash-and-grab robber who photographs everything before setting the store on fire, Akira is a double-extortion ransomware operation that exfiltrates data *before* encrypting it. First observed in March 2023, Akira targets Windows and Linux (including VMware ESXi) systems, demands ransom for both decryption keys and the suppression of stolen data.

## Why it matters
In 2023, Akira compromised Cisco VPN infrastructure by exploiting accounts lacking multi-factor authentication, using valid credentials to move laterally through corporate networks before deploying ransomware. This attack demonstrated how a single MFA gap can hand threat actors full network access, making perimeter-hardening insufficient without identity controls.

## Key facts
- **Initial access vector**: Primarily exploits compromised VPN/RDP credentials and vulnerabilities in Cisco ASA/FTD appliances (notably CVE-2023-20269)
- **Double extortion model**: Stolen data is published on Akira's Tor-based leak site if ransom is unpaid — victims face both operational disruption and reputational damage
- **Encryption behavior**: Uses a hybrid encryption scheme (ChaCha20 + RSA) and appends `.akira` extension to encrypted files; ESXi variants target virtual machine disk files (.vmdk)
- **Defense evasion**: Deletes Windows Shadow Volume Copies using `vssadmin` to eliminate native recovery options; disables Windows Defender via PowerShell
- **Affiliate model**: Operates as Ransomware-as-a-Service (RaaS), meaning multiple threat actors deploy the malware under Akira's brand in exchange for a revenue cut

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Lateral Movement]] [[Shadow Copy Deletion]] [[CVE Exploitation]]