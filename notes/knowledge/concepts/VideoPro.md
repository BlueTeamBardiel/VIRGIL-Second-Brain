# VideoPro

## What it is
Like a skeleton key that unlocks a door the owner didn't know existed, VideoPro is a potentially unwanted program (PUP) and adware bundler historically distributed alongside free video-related software. It installs silently alongside legitimate applications, hijacks browser settings, and injects advertisements into web sessions without meaningful user consent.

## Why it matters
In a real-world scenario, a user downloads a free video converter from a third-party site; bundled with it, VideoPro installs a browser extension that redirects search queries to monetized pages and tracks browsing history. This represents a classic supply chain / software bundling attack vector where the malicious payload piggybacks on trusted-seeming software, bypassing user suspicion and sometimes antivirus detection tuned for more aggressive malware.

## Key facts
- **Bundling technique**: VideoPro typically hides its installation consent inside "Express/Recommended" install options, exploiting user tendency to click through without reading EULA or custom install screens.
- **Persistence mechanism**: It registers browser extensions and modifies registry keys (Windows) to survive reboots and browser resets.
- **Classification**: Categorized as a PUP/PUA (Potentially Unwanted Application) — not technically illegal malware, but violates ethical software distribution standards and creates real security risk.
- **Detection evasion**: Because it's technically "consented to" via bundled licensing, many AV engines historically flagged it at low severity or not at all, illustrating the gap between legal and secure.
- **Impact**: Data exfiltration risk is real — collected browsing data (URLs, search terms, timestamps) can be sold to third-party data brokers or used for targeted phishing profiling.

## Related concepts
[[Potentially Unwanted Program (PUP)]] [[Adware]] [[Software Bundling Attack]] [[Browser Hijacking]] [[Supply Chain Attack]]