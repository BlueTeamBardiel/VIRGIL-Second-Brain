# Sideloading

## What it is
Like smuggling a homemade dish into a restaurant by walking through the kitchen door instead of ordering from the menu — sideloading is the installation of applications onto a device through unofficial channels, bypassing the platform's vetted app store. It circumvents the OS vendor's security review process, allowing unsigned or unverified code to execute on the device.

## Why it matters
In 2023, threat actors distributed a trojanized version of WhatsApp for Android through third-party APK sites, targeting users in regions where the official Play Store was blocked. Victims who sideloaded the app had their messages intercepted and credentials harvested — all because they bypassed Google's malware scanning pipeline. This illustrates why mobile device management (MDM) policies often explicitly block sideloading on corporate devices.

## Key facts
- **Android** enables sideloading via APK files by toggling "Unknown Sources" (or per-app install permissions in Android 8+); **iOS** restricts it heavily, though enterprise certificates and AltStore exploit gaps
- Sideloading is a primary delivery mechanism for **mobile malware**, adware, and stalkerware in the wild
- The EU's Digital Markets Act (2022) legally required Apple to permit sideloading on iOS in the EU by March 2024, creating new enterprise attack surface
- MDM solutions (like Jamf or Microsoft Intune) can enforce policies that **prevent sideloading** by restricting unknown-source installations on managed devices
- Sideloading is distinct from a **supply chain attack** — the user voluntarily installs the unofficial app, often socially engineered via phishing or fake "cracked software" sites

## Related concepts
[[Mobile Device Management]] [[Supply Chain Attack]] [[Code Signing]] [[Malicious App]] [[Least Privilege]]