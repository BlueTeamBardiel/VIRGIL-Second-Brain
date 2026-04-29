# Side Loading

## What it is
Imagine a bouncer who only checks IDs at the front door — so you sneak in through the kitchen. Sideloading is the practice of installing applications on a device through unofficial channels, bypassing the vetted app store marketplace entirely. On mobile platforms, this means installing APK files (Android) or unsigned packages (iOS via jailbreak) outside of Google Play or the Apple App Store.

## Why it matters
In 2023, attackers distributed a trojanized version of WhatsApp as a sideloaded APK through Telegram channels, which silently harvested credentials and contacts while appearing fully functional. Organizations allowing BYOD without mobile device management (MDM) policies prohibiting sideloading create a direct path for malicious apps to enter the enterprise network through employee devices.

## Key facts
- Android permits sideloading natively via the "Unknown Sources" toggle; iOS requires jailbreaking or Apple's Enterprise Developer Program, making Android the higher-risk platform by default
- Sideloaded apps bypass code signing verification and malware scanning performed by official app stores
- DLL sideloading (on Windows) is a related but distinct attack: placing a malicious DLL where a legitimate application will load it instead of the real library
- Security+ and CySA+ treat sideloading as a **mobile device threat** under application security and endpoint hardening domains
- Mitigations include MDM enrollment policies, application allowlisting, and disabling developer mode on managed devices

## Related concepts
[[DLL Hijacking]] [[Mobile Device Management]] [[Code Signing]] [[Jailbreaking]] [[Application Allowlisting]]