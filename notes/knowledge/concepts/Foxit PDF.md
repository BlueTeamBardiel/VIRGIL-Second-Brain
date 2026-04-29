# Foxit PDF

## What it is
Like a rival car manufacturer that shares the same roads as Toyota but builds its engine differently, Foxit PDF Reader is an alternative PDF rendering engine to Adobe Acrobat — same file format, different codebase. It is a widely-used PDF viewer and editor that interprets the PDF specification independently, meaning its vulnerability surface differs substantially from Adobe's implementation.

## Why it matters
In 2018–2019, researchers discovered that Foxit's "Safe Reading Mode" could be bypassed, allowing malicious PDFs to execute JavaScript and launch remote code execution without user prompting. Attackers specifically targeted Foxit users because security teams often focused patches and monitoring on Adobe products, leaving Foxit deployments under-hardened — a classic case of security assumptions built around market share rather than actual deployment inventory.

## Key facts
- Foxit PDF has had multiple critical CVEs involving its JavaScript engine, including heap-based buffer overflows triggered by malformed PDF objects
- The "Safe Reading Mode" feature is designed to suppress JavaScript execution by default, but bypasses have been demonstrated through crafted PDF actions
- Foxit supports U3D and embedded file streams — both historically exploited attack vectors shared with Adobe Acrobat
- Organizations using Foxit in enterprise environments must separately track its patch cycle; it does NOT follow Adobe's Patch Tuesday cadence
- PDF-based malware delivery (using `/Launch`, `/JavaScript`, or `/OpenAction` PDF dictionary keys) affects both Adobe and Foxit, but exploit code is often written separately for each parser

## Related concepts
[[PDF Malware]] [[JavaScript Engine Vulnerabilities]] [[Remote Code Execution]] [[Patch Management]] [[Attack Surface Management]]