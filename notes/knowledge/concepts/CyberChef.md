# CyberChef

## What it is
Think of it as a Swiss Army knife bolted to a kitchen blender — you feed it raw, messy data and dial in a "recipe" of transformations to get something intelligible out the other side. CyberChef is a browser-based data analysis and transformation tool developed by GCHQ, capable of encoding, decoding, encrypting, hashing, and parsing data through chainable operations called "recipes." It requires no installation and runs entirely client-side in the browser.

## Why it matters
During incident response, analysts frequently encounter malware that obfuscates payloads using layered encoding — Base64 wrapping XOR wrapping gzip, for example. CyberChef allows a SOC analyst to rapidly chain decode operations and extract the actual shellcode or C2 URL without writing a single line of Python, cutting triage time from hours to minutes.

## Key facts
- **Recipes** are saved, shareable chains of operations — analysts can distribute a recipe URL to replicate exact decoding steps across a team
- Supports over **300 operations** including Base64, ROT13, XOR, AES/DES encryption, hash functions (MD5, SHA-256), JWT decoding, and regex extraction
- The **"Magic" operation** auto-detects encoding layers, making it useful when an analyst doesn't yet know how data was obfuscated
- Runs **entirely client-side** — no data is sent to a server, making it acceptable for handling sensitive or classified artifacts
- Commonly used in **CTF competitions and malware analysis** to decode obfuscated strings, extract IOCs, and reverse multi-layer encoding schemes

## Related concepts
[[Base64 Encoding]] [[XOR Obfuscation]] [[Malware Analysis]] [[Incident Response]] [[IOC Extraction]]