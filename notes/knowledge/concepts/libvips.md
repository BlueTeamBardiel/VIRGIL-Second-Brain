# libvips

## What it is
Like a conveyor belt that processes images one tile at a time instead of loading the whole painting into memory, libvips is a demand-driven image processing library. It is a high-performance, open-source C library for image manipulation that processes pixels in streaming pipelines, keeping memory usage extremely low even for gigapixel images.

## Why it matters
Image processing libraries are a notorious attack surface because they parse complex, attacker-controlled binary formats. CVE-2023-40032 demonstrated a heap buffer overflow in libvips when handling malformed TIFF files — an attacker uploading a crafted image to a web application using libvips (such as a Node.js app via Sharp) could trigger remote code execution on the server. Developers often trust libvips because of its performance reputation, overlooking the need to keep it patched.

## Key facts
- libvips underpins **Sharp**, the most popular Node.js image processing library, meaning a libvips vulnerability cascades into millions of JavaScript applications
- Supports a wide attack surface of formats: JPEG, PNG, TIFF, WebP, HEIF, SVG, PDF — each parser is a potential vulnerability entry point
- Heap buffer overflows and integer overflows in image parsers are the dominant vulnerability class; attackers embed malicious data in image headers to corrupt memory
- libvips runs as the **server process user** — exploitation typically grants web server-level code execution (often `www-data`), useful for lateral movement
- Defense-in-depth: run image processing in **sandboxed containers** (seccomp, namespaces) and enforce strict input validation (magic bytes, file size limits, allowlisted MIME types) before passing to libvips

## Related concepts
[[Buffer Overflow]] [[File Upload Vulnerabilities]] [[Dependency Chain Attacks]]