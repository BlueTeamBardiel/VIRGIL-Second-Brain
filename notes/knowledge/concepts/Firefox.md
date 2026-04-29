# Firefox

## What it is
Like a city's postal service that opens and inspects every package you receive before handing it to you, Firefox is a web browser that acts as the interpreter between raw internet data and your operating system. More precisely, it is an open-source web browser developed by Mozilla that renders HTML, executes JavaScript, and manages web sessions, cookies, and certificates on behalf of the user.

## Why it matters
In 2022, Firefox patched CVE-2022-26485, a use-after-free vulnerability in its XSLT parameter processing — attackers who could lure a user to a malicious webpage could execute arbitrary code with no user interaction beyond the click. This class of browser-based exploitation is a primary delivery vector for drive-by downloads and is directly relevant to endpoint hardening strategies tested on CySA+.

## Key facts
- Firefox uses a **sandboxed multi-process architecture** (Fission), isolating each site into its own process to contain cross-site memory attacks
- The **Mozilla Root Store** controls which Certificate Authorities Firefox trusts, making it independent of the OS trust store — relevant for enterprise MITM proxy deployments
- Firefox supports **Content Security Policy (CSP)** headers, which defenders configure to mitigate XSS by whitelisting allowed script sources
- **Enhanced Tracking Protection (ETP)** blocks third-party trackers by default, reducing fingerprinting surface used in targeted attacks
- Firefox stores saved passwords in `logins.json` encrypted with a key in `key4.db` — both files are common targets for credential-harvesting malware

## Related concepts
[[Web Browser Security]] [[Content Security Policy]] [[Cross-Site Scripting (XSS)]] [[Drive-By Download]] [[Certificate Authority]]