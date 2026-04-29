# FFmpeg

## What it is
Think of FFmpeg as a Swiss Army knife for media files — it can open, disassemble, convert, and reassemble virtually any audio or video format. Precisely, FFmpeg is a free, open-source command-line framework for decoding, encoding, transcoding, muxing, demuxing, streaming, and playing multimedia content. It powers the media handling of hundreds of applications, from VLC to Chrome, often invisibly.

## Why it matters
FFmpeg has repeatedly been a vector for **heap buffer overflow** and **integer overflow** vulnerabilities due to its massive attack surface across dozens of codec parsers — maliciously crafted media files can trigger arbitrary code execution when processed by vulnerable versions. In 2017, a Server-Side Request Forgery (SSRF) vulnerability in FFmpeg's HLS playlist processing allowed attackers to read arbitrary local files from servers that used FFmpeg to process user-uploaded videos (e.g., video transcoding services). Defenders must keep FFmpeg patched and sandbox its execution environment, especially when handling untrusted media uploads.

## Key facts
- FFmpeg processes media via **demuxers → decoders → filters → encoders → muxers**, each stage being a potential vulnerability surface
- The **HLS (HTTP Live Streaming) SSRF bug (CVE-2016-1897/1898)** allowed file exfiltration by embedding malicious playlist URLs in uploaded video files
- Malicious media files exploiting FFmpeg bugs are a classic **file upload attack** vector; content-type validation alone does not prevent exploitation
- FFmpeg runs with whatever privileges the calling process has — running it as root or in an uncontained environment dramatically increases blast radius
- Static analysis tools and **fuzzing** (e.g., OSS-Fuzz continuously fuzzes FFmpeg) are primary methods used to find codec parsing vulnerabilities

## Related concepts
[[Buffer Overflow]] [[Server-Side Request Forgery]] [[File Upload Vulnerabilities]] [[Fuzzing]] [[Arbitrary Code Execution]]