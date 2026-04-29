# Graphics: Canvas2D

## What it is
Think of Canvas2D like a digital whiteboard that websites can draw on pixel-by-pixel using JavaScript — except the browser remembers exactly what ink you used. It is an HTML5 API (`<canvas>` element) that allows scripts to render 2D graphics, shapes, text, and images directly in the browser via the `CanvasRenderingContext2D` interface.

## Why it matters
Canvas2D is a cornerstone of **browser fingerprinting** attacks. When a website silently instructs your browser to render a hidden canvas — drawing a specific string of text in a specific font — subtle differences in GPU, OS font rendering, and anti-aliasing produce a pixel-level output unique enough to re-identify users across sessions, even after clearing cookies. Privacy-focused browsers like Tor Browser deliberately add noise to canvas output specifically to defeat this tracking vector.

## Key facts
- **Canvas fingerprinting** works because the same drawing instructions produce slightly different pixel values across hardware/OS/driver combinations — these differences are measurable and stable enough to act as a quasi-unique identifier.
- The attack is **passive and invisible** — no user interaction required; the canvas element can be hidden with CSS (`display:none` or zero dimensions).
- Browsers expose canvas data via `toDataURL()` or `getImageData()` — these are the specific methods an attacker's script calls to extract the fingerprint.
- **Content Security Policy (CSP)** does not block canvas fingerprinting by default; mitigations require browser-level controls or extensions (e.g., CanvasBlocker).
- Canvas2D can also be abused for **cryptomining UI camouflage** — rendering a fake progress bar or animation while executing hidden compute tasks via WebGL or WebAssembly underneath.

## Related concepts
[[Browser Fingerprinting]] [[Content Security Policy]] [[Cross-Site Tracking]] [[WebGL]] [[JavaScript Sandbox]]