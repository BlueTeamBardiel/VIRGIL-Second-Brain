# App Store

## What it is
Think of it as a bouncer at a club with a strict guest list — only vetted apps get through the velvet rope, and the bouncer (Apple/Google) decides who stays. An app store is a centralized digital distribution platform where developers publish software that users can download to mobile or desktop devices, with the platform operator controlling the approval pipeline through code signing, policy enforcement, and sandboxing requirements.

## Why it matters
In 2021, researchers discovered "Goldoson" malware embedded in 60+ legitimate Android apps that had slipped through Google Play review — collectively downloaded over 100 million times — demonstrating that even curated stores are not airtight. Defenders use app store provenance as a first-line mobile device management (MDM) policy: restricting installs to official stores reduces the attack surface from sideloaded, unreviewed APKs or IPA files.

## Key facts
- **Code signing is mandatory**: Apps must be signed with a developer certificate issued by the platform (Apple Developer ID, Google Play signing key), providing integrity and authenticity verification
- **Sideloading bypasses these controls**: Installing apps outside official stores (enabled via Android's "Unknown Sources" or iOS jailbreaks) removes vetting, dramatically increasing malware risk
- **Google Play Protect** continuously scans installed Android apps for malicious behavior — a runtime defense layer beyond initial submission review
- **Supply chain risk exists inside stores**: Malicious SDKs (e.g., XcodeGhost in 2015) have compromised legitimate apps *before* submission, poisoning the trusted supply chain
- **BYOD policies** in enterprises typically mandate app store restrictions via MDM profiles to enforce acceptable-use and prevent unauthorized software

## Related concepts
[[Code Signing]] [[Mobile Device Management]] [[Supply Chain Attack]] [[Sandboxing]] [[Sideloading]]