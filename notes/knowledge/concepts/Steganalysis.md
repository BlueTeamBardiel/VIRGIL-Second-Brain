# Steganalysis

## What it is
Like a customs agent who knows smugglers hide contraband in hollow book spines, steganalysis is the forensic discipline of detecting hidden data concealed within ordinary-looking files. It is the counterpart to steganography — the practice of using statistical, visual, or algorithmic techniques to reveal whether a carrier file (image, audio, video, text) contains covert embedded information.

## Why it matters
In a real-world APT exfiltration scenario, attackers may embed stolen credentials or C2 commands inside innocuous JPEG images posted to public social media, bypassing DLP tools that only scan for plaintext secrets. A SOC analyst using steganalysis tools like StegExpose or Stegdetect can flag statistically anomalous images — those with irregular LSB (Least Significant Bit) distributions — before data leaves the organization undetected.

## Key facts
- **LSB analysis** is the most common technique: legitimate images have pseudo-random LSB patterns; steganographic images show statistical irregularities when bits are manipulated to encode hidden data.
- **Chi-square attack** compares expected vs. observed frequency of pixel value pairs to detect sequential LSB embedding with measurable statistical confidence.
- **RS Analysis (Regular-Singular)** is a more robust steganalysis method that detects LSB steganography even when embedding rate is low (~5%).
- Tools like **StegSolve**, **zsteg**, and **binwalk** are commonly used in CTF competitions and real forensic investigations to extract hidden payloads.
- Steganalysis is classified as either **blind** (no knowledge of the steganography algorithm used) or **targeted** (optimized against a specific known tool like OpenStego or Steghide).

## Related concepts
[[Steganography]] [[Digital Forensics]] [[Data Loss Prevention]] [[Covert Channels]] [[File Carving]]