# wappalyzer

## What it is
Like reading the brand labels on someone's clothing to deduce their lifestyle, Wappalyzer inspects HTTP headers, HTML patterns, cookies, and script filenames to fingerprint what technology stack a website is running. It is an open-source web technology profiler that identifies CMS platforms, JavaScript frameworks, web servers, analytics tools, and dozens of other components from passive observation alone.

## Why it matters
During the reconnaissance phase of a penetration test or real attack, an adversary runs Wappalyzer against a target and discovers the site runs WordPress 6.1 with WooCommerce — both with known CVEs. The attacker now skips guesswork and moves directly to exploit selection, dramatically narrowing the attack surface research from hours to seconds. Defenders use this same intelligence to audit their own exposure and enforce technology baseline policies.

## Key facts
- Wappalyzer works as a browser extension, CLI tool, and API, making it usable in both manual and automated recon pipelines.
- It identifies technologies using a JSON-based signature file of regex patterns matched against response headers, cookies, HTML meta tags, and JavaScript globals.
- Falls under MITRE ATT&CK **T1592.002 – Gather Victim Host Information: Software**, classifying it as passive reconnaissance tradecraft.
- Because it reads only what the server already broadcasts publicly, it requires **no authentication** and generates minimal logs — making it near-invisible to blue teams.
- Organizations can reduce Wappalyzer's effectiveness by removing version strings from `X-Powered-By` and `Server` headers (security hardening / header scrubbing).

## Related concepts
[[passive reconnaissance]] [[fingerprinting]] [[attack surface management]] [[CVE exploitation]] [[HTTP security headers]]