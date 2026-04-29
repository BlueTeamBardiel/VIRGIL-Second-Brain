# Google Play

## What it is
Think of Google Play as a walled farmer's market — vendors must register, products get inspected, but occasionally a bad apple slips through the stall. It is Google's official Android app distribution platform that uses automated scanning (Play Protect) and human review to vet applications before and after publication.

## Why it matters
Attackers routinely abuse Google Play through a technique called *versioning* — publishing a clean, legitimate app that passes review, then pushing a malicious update later that downloads additional payloads from external servers. In 2021, the Joker malware family repeatedly infiltrated Play using this method, silently subscribing victims to premium SMS services and exfiltrating contact data.

## Key facts
- **Google Play Protect** scans ~125 billion apps daily on-device and can remotely disable or remove malicious apps even after installation
- **Sideloading** (installing APKs outside Play) bypasses all Play Protect vetting — a major attack surface that enterprise MDM policies should explicitly restrict
- Apps must declare **permissions** in the manifest; users can grant/deny dangerous permissions at runtime (Android 6.0+), but malicious apps often abuse over-broad permissions that users casually accept
- The **Developer Policy Center** prohibits apps that use reflection or dynamic code loading to obscure behavior — a red flag examiners look for during static analysis
- Play uses **code signing** (APK signature scheme v2/v3) to verify app integrity and attribute updates to the original developer, preventing tampering in transit

## Related concepts
[[Mobile Device Management]] [[Android Security Model]] [[Supply Chain Attack]] [[Code Signing]] [[Malware Analysis]]