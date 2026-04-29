# SMS

## What it is
Think of SMS like passing paper notes in class — the teacher (your carrier) reads every note before passing it along, and anyone intercepting the hallway can grab a copy. SMS (Short Message Service) is a text messaging protocol built on the SS7 signaling network, transmitting messages as plaintext through carrier infrastructure with no end-to-end encryption by default.

## Why it matters
SMS-based multi-factor authentication (MFA) is widely deployed but fundamentally weak — attackers use SIM swapping (convincing a carrier to transfer your number to their SIM) to intercept one-time passcodes and hijack accounts. In 2019, Twitter CEO Jack Dorsey's account was compromised via SIM swapping, demonstrating that even high-profile targets relying on SMS MFA are vulnerable. NIST SP 800-63B explicitly discourages SMS OTP as a primary authentication factor because of this attack surface.

## Key facts
- **SS7 vulnerabilities** allow nation-state actors and sophisticated criminals to intercept SMS messages by exploiting routing protocol weaknesses in the global telecom backbone
- **SIM swapping** is a social engineering attack against carriers that redirects a victim's phone number to an attacker-controlled SIM card
- **Smishing** (SMS phishing) delivers malicious links or pretexts via text message — a common initial access vector in targeted attacks
- **NIST SP 800-63B** classifies SMS OTP as a "restricted" authenticator, recommending TOTP apps or hardware tokens instead
- SMS messages are stored on carrier servers and can be subpoenaed, making them inadmissible as a secure communication channel for sensitive data

## Related concepts
[[SIM Swapping]] [[Smishing]] [[Multi-Factor Authentication]] [[SS7 Attack]] [[Out-of-Band Authentication]]