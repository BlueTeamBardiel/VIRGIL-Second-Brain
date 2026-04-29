# Counterfeit Equipment

## What it is
Like buying a "Rolex" from a street vendor that tells time but also records your conversations, counterfeit equipment refers to hardware that mimics legitimate branded networking or computing devices but contains unauthorized modifications — backdoors, malicious firmware, or degraded components — designed to deceive buyers about origin and integrity.

## Why it matters
In 2008, the FBI's "Operation Cisco Raider" uncovered thousands of fake Cisco routers and switches sold to U.S. military and government networks. Because the hardware appeared functionally identical to genuine equipment, malicious firmware could intercept traffic or create persistent footholds that no software patch could remove — the threat lived in the silicon itself.

## Key facts
- Counterfeit network hardware often originates from gray-market supply chains; purchasing only through authorized resellers (VAR channels) is the primary preventive control
- Hardware integrity verification via TPM (Trusted Platform Module) and Secure Boot helps detect unauthorized firmware modifications at startup
- NIST SP 800-161 provides supply chain risk management (SCRM) guidance specifically addressing counterfeit component threats for federal systems
- Counterfeit equipment may pass visual and basic functional inspection but fail cryptographic attestation checks — making hash verification of firmware a critical detective control
- This threat falls under the broader category of **Hardware/Supply Chain Attacks** and is directly tested on Security+ under the "Attacks, Threats, and Vulnerabilities" domain (supply chain risk)

## Related concepts
[[Supply Chain Attacks]] [[Hardware Root of Trust]] [[Trusted Platform Module]] [[Firmware Security]] [[Third-Party Risk Management]]