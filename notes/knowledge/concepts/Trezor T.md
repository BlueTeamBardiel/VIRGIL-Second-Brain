# Trezor T

## What it is
Think of it like a physical safe that only opens when you physically press a button — even if someone steals the combination. The Trezor Model T is a hardware security key and cryptocurrency wallet that stores private keys in an isolated, air-gapped microcontroller, requiring physical confirmation for every transaction. No private key material ever leaves the device unencrypted, making remote compromise fundamentally impossible by design.

## Why it matters
In 2022, attackers demonstrated that Trezor One devices could be physically compromised via voltage glitching — injecting electrical noise to extract a seed phrase from flash memory. The Trezor T's upgraded STM32F4 processor with improved secure boot and passphrase support (stored nowhere on the device) significantly raises the bar for this attack class, forcing adversaries to invest sophisticated, expensive lab equipment rather than off-the-shelf tools.

## Key facts
- Uses a **touchscreen interface** eliminating USB HID injection risks present in keyboard-emulating devices
- Private keys are derived from a **BIP-39 mnemonic seed phrase** (12–24 words) — possession of the seed equals possession of all funds, regardless of device ownership
- Implements **FIDO2/U2F** authentication, making it dual-purpose as a hardware MFA token for web services
- PIN brute-force is defeated by **exponential delay lockout** — each failed attempt doubles wait time
- Open-source firmware (available on GitHub) allows community auditing, distinguishing it from security-through-obscurity approaches

## Related concepts
[[Hardware Security Module (HSM)]] [[Cold Wallet Storage]] [[FIDO2 Authentication]] [[Voltage Glitching]] [[BIP-39 Seed Phrase]]