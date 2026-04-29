# bPlugins 3D Viewer - Embed 3D Models

## What it is
Think of it like a window display in a store — it looks like just a pretty showcase, but if the glass isn't properly secured, anyone can reach through it. bPlugins 3D Viewer is a WordPress plugin that allows website owners to embed interactive 3D models (GLB/GLTF formats) directly into pages, but like many feature-rich plugins, its input handling has carried exploitable vulnerabilities including Cross-Site Scripting (XSS).

## Why it matters
In 2024, security researchers identified stored XSS vulnerabilities in bPlugins 3D Viewer, where an authenticated attacker with contributor-level access could inject malicious JavaScript into a post containing the 3D viewer shortcode. Once a site administrator views that post, the script executes in their browser, potentially stealing session cookies and enabling full site takeover — a classic privilege escalation path through a trusted feature.

## Key facts
- Vulnerability class: **Stored (Persistent) XSS**, meaning the payload lives in the database and executes for every victim who loads the page
- Authentication requirement: Contributor-level access was sufficient — demonstrating why **least privilege** enforcement matters even for "low-trust" roles
- Attack vector is **network-based** with **low attack complexity** once access is obtained, earning high CVSS scores in similar plugin CVEs
- WordPress plugin vulnerabilities are catalogued in the **WPScan Vulnerability Database** and **NVD (National Vulnerability Database)**
- Remediation follows standard plugin hygiene: **input sanitization**, **output encoding**, and prompt patching — the plugin required a version update to resolve the flaw

## Related concepts
[[Cross-Site Scripting (XSS)]] [[WordPress Plugin Vulnerabilities]] [[Principle of Least Privilege]] [[Stored vs Reflected XSS]] [[Session Hijacking]]