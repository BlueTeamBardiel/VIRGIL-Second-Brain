# Plugin Security Checker

## What it is
Like a health inspector walking through a restaurant kitchen before opening day, a Plugin Security Checker examines third-party add-ons, extensions, and modules for known vulnerabilities before they're trusted in a production environment. It is an automated or semi-automated tool that scans plugins against vulnerability databases (such as CVE/NVD), checks for outdated versions, and flags insecure coding patterns within plugin code.

## Why it matters
In 2020, attackers exploited vulnerable WordPress plugins—particularly File Manager—to upload malicious shells to over 700,000 sites. A Plugin Security Checker integrated into the deployment pipeline would have flagged the outdated plugin version before it ever reached production, blocking the attack vector entirely. This illustrates why supply chain security now demands vetting every third-party component, not just the core application.

## Key facts
- Plugin Security Checkers commonly query the **CVE database**, **WPScan Vulnerability Database** (for WordPress), or **Snyk** to match installed plugin versions against known exploits.
- They enforce the principle of **least privilege** by identifying plugins requesting unnecessary permissions or API access beyond their stated function.
- False negatives are a real risk: a "clean" scan only means no *known* vulnerabilities exist at scan time — zero-day flaws remain undetected.
- Many tools perform **Software Composition Analysis (SCA)**, mapping plugin dependencies recursively, since a secure plugin can pull in a vulnerable library.
- On CySA+, plugin/extension vetting falls under **vulnerability management** and the **application security** control category; expect questions linking unpatched plugins to supply chain compromise scenarios.

## Related concepts
[[Software Composition Analysis]] [[Supply Chain Attack]] [[Vulnerability Scanning]] [[CVE Database]] [[Patch Management]]