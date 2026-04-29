# MMS

## What it is
Think of MMS as SMS's greedy cousin — instead of just passing a sticky note, it hands you a whole envelope stuffed with photos, videos, and audio files. Multimedia Messaging Service (MMS) is a cellular protocol extension of SMS that allows mobile devices to send and receive rich media content (images, audio, video, up to ~300KB) over carrier networks using MMSC (Multimedia Messaging Service Centers) as relay infrastructure.

## Why it matters
In 2015, the **Stagefright** vulnerability devastated Android devices: a maliciously crafted MMS message could trigger remote code execution *before the user even opened it*, because Android auto-processed media on receipt. Attackers only needed a target's phone number to silently compromise a device — no clicks required. This demonstrated that MMS attack surface exists at the OS media-parsing layer, not just the network layer.

## Key facts
- MMS rides on top of **WAP (Wireless Application Protocol)** and HTTP, making it susceptible to HTTP-layer attacks unlike SMS
- Messages are not stored end-to-end on the device path — they pass through carrier **MMSC servers**, creating interception/logging points
- **Stagefright (CVE-2015-1538)** affected ~950 million Android devices and is the canonical MMS exploit reference for certification exams
- MMS does **not use E2E encryption** natively; content traverses carrier infrastructure in cleartext or with transport-only encryption
- Auto-retrieval settings in messaging apps are a key hardening target — disabling auto-fetch MMS prevents zero-click media parsing exploits

## Related concepts
[[SMS Attacks]] [[Mobile Device Security]] [[Zero-Click Exploits]] [[WAP]] [[Stagefright Vulnerability]]