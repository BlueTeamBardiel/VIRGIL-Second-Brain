# XCSSET

## What it is
Like a parasite that hides its eggs inside a bird's own nest, XCSSET embeds malicious code directly into Xcode projects so that developers unknowingly compile and distribute malware alongside their legitimate apps. It is a sophisticated macOS malware family first discovered in 2020 that targets Apple developers by injecting malicious modules into Xcode projects, spreading downstream to anyone who downloads or installs the compromised software.

## Why it matters
In a supply chain attack scenario, a developer downloads a shared Xcode project from GitHub, unknowingly compiles XCSSET malware into their own app, and distributes it to thousands of users. The malware then steals browser cookies, captures screenshots, and exfiltrates data from apps like Notes and Telegram — all without triggering obvious red flags because it ships inside a trusted, developer-signed application.

## Key facts
- **Supply chain vector**: Spreads through poisoned Xcode projects, making developers the unwitting delivery mechanism rather than the target
- **Persistence via zero-days**: Has exploited zero-day vulnerabilities in macOS components like Safari and the Data Vault mechanism to maintain persistence and bypass SIP (System Integrity Protection)
- **Capabilities**: Steals browser session cookies, ransoms local files, captures screenshots, exfiltrates sensitive app data, and can inject malicious JavaScript into browsers
- **Apple Silicon adaptation**: Updated variants emerged targeting Apple M1 chips, demonstrating active maintenance by threat actors
- **Attribution**: Associated with Chinese-speaking threat actors; initially analyzed by Trend Micro in August 2020

## Related concepts
[[Supply Chain Attack]] [[macOS Malware]] [[Code Signing]] [[Xcode]] [[Browser Cookie Theft]]