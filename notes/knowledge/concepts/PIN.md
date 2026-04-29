# PIN

## What it is
Like a secret handshake known only to you and your bank, a PIN (Personal Identification Number) is a short numeric code used to authenticate a user's identity, typically as one factor in a multi-factor authentication scheme. PINs are "something you know" — a memorized secret, usually 4–8 digits, verified locally on a device or remotely against a stored hash.

## Why it matters
In the 2013 Target breach, attackers compromised point-of-sale terminals to harvest encrypted PINs alongside card data. Because Target's PIN pads used Triple-DES encryption keyed to the hardware, attackers still needed to crack the encryption — demonstrating why a PIN alone isn't sufficient and why secure PIN entry devices (SPEDs) matter in payment security.

## Key facts
- PINs differ from passwords: they are typically validated **locally on a device** (e.g., a chip-and-PIN card or TPM), meaning the secret never travels across the network in cleartext
- Windows Hello uses a PIN tied to a specific device via the **TPM** — if the PIN is stolen, it's useless on any other machine, unlike a password
- PINs are vulnerable to **shoulder surfing**, **skimming**, and **brute-force** attacks when lockout policies are absent
- PCI DSS requires that PINs be encrypted using **Triple-DES or AES** within certified PIN Entry Devices (PEDs) during card transactions
- A 4-digit PIN has only **10,000 possible combinations**, making lockout policies (e.g., 3–10 attempts before lockout) a critical compensating control

## Related concepts
[[Multi-Factor Authentication]] [[TPM]] [[Shoulder Surfing]] [[Brute Force Attack]] [[PCI DSS]]