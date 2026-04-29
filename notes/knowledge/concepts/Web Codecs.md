# Web Codecs

## What it is
Like handing a web page a professional audio/video editing suite instead of a toy cassette player, WebCodecs is a browser API that grants JavaScript direct, low-level access to video and audio encoding/decoding pipelines. It bypasses the black-box abstraction of `<video>` tags, letting developers manipulate raw media frames with hardware acceleration. Introduced in Chrome 94, it exposes codec internals (H.264, VP8, AAC, etc.) directly to untrusted web content.

## Why it matters
In 2022, researchers demonstrated that WebCodecs could be exploited as a high-resolution timing oracle to defeat browser-level ASLR. By measuring how long hardware decoders take to process crafted video frames, attackers could fingerprint memory layout and chain the timing leak with a separate memory corruption bug to achieve reliable code execution — all from a malicious webpage with zero user interaction beyond a visit.

## Key facts
- **Attack surface expansion**: WebCodecs runs in the renderer process, meaning a bug in codec parsing code (historically CVE-dense) is now directly reachable from JavaScript.
- **Timing side-channels**: Hardware codec paths have non-uniform timing behavior that leaks information about CPU/GPU state, usable for cross-origin data inference attacks.
- **Origin isolation dependency**: WebCodecs' safety model relies heavily on Site Isolation and Cross-Origin-Opener-Policy (COOP) headers being correctly deployed; misconfigured servers undermine these protections.
- **Permissions model**: No user permission prompt is required to use WebCodecs — any page can instantiate encoders/decoders silently, making it available for covert fingerprinting.
- **CVE-2022-2294**: A heap buffer overflow in WebRTC (related codec pipeline) was exploited in the wild, demonstrating the real-world severity of low-level media processing bugs in browsers.

## Related concepts
[[Browser Security Model]] [[Side-Channel Attacks]] [[Site Isolation]] [[Content Security Policy]] [[Cross-Origin Resource Policy]]