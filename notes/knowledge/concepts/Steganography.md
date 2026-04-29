# Steganography

## What it is
Like a spy writing in invisible ink between the lines of an innocent letter, steganography hides secret data *inside* ordinary-looking files — not by scrambling it, but by concealing its very existence. Formally, it is the practice of embedding information within non-secret carrier data (images, audio, video, or text) so that the communication itself goes undetected.

## Why it matters
APT groups have used steganography to exfiltrate data by encoding stolen credentials inside innocuous-looking JPEG images uploaded to public social media platforms — bypassing DLP tools that scan for encrypted or suspicious traffic. The Turla threat group notably used image-based steganography on Instagram to receive C2 commands, hiding the malicious channel in plain sight.

## Key facts
- **LSB (Least Significant Bit) injection** is the most common technique — replacing the lowest bit of each pixel's color value with payload data, causing imperceptible visual changes
- Steganography provides **obscurity, not confidentiality** — combining it with encryption adds a meaningful security layer
- Detection is called **steganalysis**, which looks for statistical anomalies in file structures (e.g., unusual noise patterns, file size discrepancies)
- Unlike cryptography, steganography is **not regulated by export controls**, making it attractive for covert communication
- On Security+/CySA+ exams, steganography is classified under **covert channels** and associated with **data exfiltration** and **insider threat** scenarios

## Related concepts
[[Cryptography]] [[Data Exfiltration]] [[Covert Channels]] [[Digital Forensics]] [[DLP Controls]]