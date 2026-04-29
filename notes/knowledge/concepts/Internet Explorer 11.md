# Internet Explorer 11

## What it is
Like a crumbling bridge still marked on old maps that some GPS systems insist on routing traffic through, Internet Explorer 11 is Microsoft's legacy web browser — the final version of IE, released in 2013 and officially end-of-lifed on June 15, 2022 — that persists in enterprise environments despite receiving no further security patches.

## Why it matters
In 2021, APT groups actively exploited IE's MSHTML (Trident) rendering engine via malicious Office documents — users didn't even need to open IE; the engine was embedded in Microsoft Office. A crafted `.docx` file could trigger remote code execution (CVE-2021-40444) simply by being previewed, demonstrating that IE's attack surface outlives the browser itself.

## Key facts
- **End of Life:** June 15, 2022 — no security patches issued after this date; any new vulnerabilities discovered remain permanently unpatched
- **CVE-2021-40444:** Critical MSHTML zero-day (CVSS 8.8) exploited in the wild before a patch existed; required no direct IE interaction
- **IE Mode in Edge:** Microsoft Edge includes "IE Mode" using the Trident engine for legacy compatibility, meaning IE's vulnerable rendering code persists inside a modern browser
- **ActiveX Legacy Risk:** IE 11 supported ActiveX controls, a historically exploited plugin architecture with no sandboxing equivalent to modern browser extensions
- **Enterprise Persistence:** Organizations running legacy line-of-business applications built for IE create residual attack surface; a common finding in CySA+ network assessments and vulnerability scans

## Related concepts
[[End-of-Life Software]] [[CVE Management]] [[ActiveX]] [[Zero-Day Vulnerability]] [[Attack Surface Reduction]]