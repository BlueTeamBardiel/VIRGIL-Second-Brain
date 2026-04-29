# SVG

## What it is
Think of SVG like a recipe card instead of a photograph — instead of storing pixel colors, it stores *instructions* for drawing shapes using XML markup. Scalable Vector Graphics (SVG) is an XML-based image format that renders graphics through mathematical descriptions rather than fixed pixel grids, and crucially, it supports embedded scripts and event handlers natively within the file itself.

## Why it matters
Because SVG files are valid XML containing executable JavaScript, attackers weaponize them as XSS delivery vehicles. A malicious SVG uploaded to a file-sharing platform or profile picture field can execute `<script>` tags or `onload` event handlers the moment a victim's browser renders it — bypassing filters that only inspect traditional image formats like JPEG or PNG. Security teams must configure Content Security Policy headers and sanitize SVG uploads server-side, not just validate file extensions or MIME types.

## Key facts
- SVG files can contain `<script>` tags, `onload` attributes, and foreign object elements that execute JavaScript, making them a non-obvious XSS vector
- Renaming a malicious `.svg` to `.jpg` doesn't neutralize the threat if servers serve it with `image/svg+xml` MIME type — browsers parse the content type, not the extension
- SVG-based attacks bypass traditional image sanitization libraries that only strip script tags from HTML, not from XML namespaces
- The `<foreignObject>` tag in SVG allows embedding arbitrary HTML/JavaScript, expanding the attack surface beyond simple `<script>` blocks
- Mitigations include: serving user-uploaded SVGs from a sandboxed domain, enforcing strict CSP `script-src` directives, and using SVG sanitization libraries like DOMPurify

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy]] [[File Upload Vulnerabilities]]