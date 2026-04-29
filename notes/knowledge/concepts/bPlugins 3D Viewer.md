# bPlugins 3D Viewer

## What it is
Like a museum security guard who trusts every visitor carrying a clipboard, this plugin renders 3D models inside WordPress pages without properly verifying what's written on that clipboard. bPlugins 3D Viewer is a WordPress plugin that allows website owners to embed interactive 3D model files directly into pages and posts, but has contained documented vulnerabilities — notably arbitrary file upload and path traversal flaws — that attackers can exploit without authentication.

## Why it matters
In 2023, security researchers identified that bPlugins 3D Viewer allowed unauthenticated attackers to upload arbitrary files, including PHP webshells, to a target server. An attacker could upload a malicious `.php` file disguised as a 3D model, then navigate to it directly to achieve Remote Code Execution (RCE), effectively handing them full server control — a critical compromise requiring immediate patching and incident response.

## Key facts
- Classified under **CVE-2023-2181** (and related CVEs), with a CVSS score reaching **Critical (9.8)** due to unauthenticated arbitrary file upload
- Vulnerability class: **Unrestricted File Upload** — OWASP ranks this as a top web application risk enabling RCE
- Affected versions existed **below 1.0.2**; the fix involved proper MIME-type validation and nonce-based authentication checks
- Attack vector is **network-accessible with no privileges required**, making it trivially weaponizable via automated scanners like WPScan
- Defense requires **principle of least privilege** on upload directories (removing execute permissions) as a compensating control even after patching

## Related concepts
[[Arbitrary File Upload]] [[Remote Code Execution]] [[WordPress Plugin Vulnerabilities]] [[Unrestricted File Upload (OWASP)]] [[Webshell]]