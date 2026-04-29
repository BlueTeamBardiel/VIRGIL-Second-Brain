# Mozilla

## What it is
Think of Mozilla like a non-profit city planner who builds public roads (browsers and tools) instead of selling real estate — existing to serve users rather than profit from them. Mozilla Foundation is the open-source organization behind Firefox, Thunderbird, and key web security standards, operating as a public benefit entity focused on internet health and privacy.

## Why it matters
Mozilla's Firefox browser implements strict Certificate Transparency enforcement and enhanced tracking protection, making it a frequent reference point in enterprise security policy decisions. When organizations evaluated responses to the 2019 Kazakhstan government root CA interception attempt — where the government tried to MITM all HTTPS traffic — Firefox's decision to hard-block that CA demonstrated how browser vendors act as a last line of defense against nation-state certificate abuse.

## Key facts
- Firefox was the first major browser to block known malicious third-party tracking cookies by default (Enhanced Tracking Protection, 2019)
- Mozilla maintains the **Common CA Database (CCADB)**, a shared repository used by Apple, Microsoft, and Google to manage trusted root Certificate Authorities
- Firefox uses a separate certificate store from the OS — meaning rogue enterprise CAs added to Windows certificate store are NOT automatically trusted by Firefox
- Mozilla's **Content Security Policy (CSP)** headers were pioneered and standardized largely through Mozilla's involvement with the W3C
- Mozilla publishes regular **Mozilla Security Blog** advisories and contributes to CVE disclosures for browser vulnerabilities

## Related concepts
[[Certificate Authority]] [[Certificate Transparency]] [[Content Security Policy]] [[Browser Security]] [[Public Key Infrastructure]]