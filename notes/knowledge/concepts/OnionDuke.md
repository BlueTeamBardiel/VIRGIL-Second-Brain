# OnionDuke

## What it is
Imagine a crooked toll booth operator who secretly photographs every driver's ID before letting them through — that's OnionDuke. It is a malware family attributed to APT29 (Cozy Bear) that was distributed by wrapping legitimate software bundles with a malicious backdoor, most infamously injected into Tor exit node traffic to trojanize files downloaded through the Tor anonymity network.

## Why it matters
In 2014, a malicious Tor exit node in Russia was caught modifying Windows executables in transit, embedding OnionDuke into files that users downloaded believing Tor protected them. This demonstrated that anonymity networks don't protect against a compromised exit node performing man-in-the-middle content injection — a chilling counterintuitive lesson for privacy-conscious targets inside government and defense sectors.

## Key facts
- **Attribution:** Linked to APT29 (Cozy Bear), a Russian state-sponsored threat actor associated with the SVR intelligence service
- **Delivery mechanism:** Trojanized executables injected at a malicious Tor exit node — users downloaded what appeared to be legitimate software
- **Relationship to MiniDuke:** OnionDuke shares code components and command-and-control infrastructure with MiniDuke, suggesting a shared development team or toolkit
- **Backdoor capability:** Once installed, it contacts C2 servers to exfiltrate credentials, establish persistence, and download additional payloads
- **Target profile:** Primarily European government and defense organizations — sectors that ironically use Tor for operational security

## Related concepts
[[APT29]] [[MiniDuke]] [[Tor Exit Node Attack]] [[Supply Chain Compromise]] [[Command and Control Infrastructure]]