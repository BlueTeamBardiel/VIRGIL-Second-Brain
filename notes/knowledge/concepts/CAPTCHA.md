# CAPTCHA

## What it is
Like a bouncer asking you to read a smudged handwritten note — easy for a human with fuzzy pattern recognition, impossible for a machine parsing clean data — a CAPTCHA (Completely Automated Public Turing test to tell Computers and Humans Apart) is a challenge-response mechanism designed to distinguish human users from automated bots. It exploits the gap between human perceptual cognition and programmatic input parsing.

## Why it matters
During credential stuffing attacks, threat actors deploy bots to test thousands of username/password combinations harvested from data breaches against login portals at machine speed. A CAPTCHA gate forces each attempt to pass a human-verification challenge, dramatically slowing automated attacks and raising the operational cost for attackers. Google's reCAPTCHA v3, for example, silently scores user behavior rather than presenting a visual puzzle, making it harder for bots to mimic organic interaction patterns.

## Key facts
- **Original CAPTCHAs** used distorted text; modern versions like reCAPTCHA v3 use behavioral analytics (mouse movement, typing cadence, browsing history) to assign a bot-probability score
- **CAPTCHA farms** are a real bypass technique — low-wage humans are paid fractions of a cent to solve CAPTCHAs in real time, defeating the control entirely
- **ML-based solvers** (using convolutional neural networks) can defeat image-based CAPTCHAs with 90%+ accuracy, which is why purely visual CAPTCHAs are considered a weakening control
- **Accessibility** is a known tradeoff — audio CAPTCHAs exist as ADA accommodations but are also more susceptible to automated audio-processing attacks
- CAPTCHAs are classified as an **authentication hardening control**, not an authentication mechanism — they protect *the process*, not the identity

## Related concepts
[[Credential Stuffing]] [[Bot Mitigation]] [[Multi-Factor Authentication]] [[Rate Limiting]] [[Turing Test]]