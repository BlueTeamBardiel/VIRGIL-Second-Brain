# Trezor One

## What it is
Like a bank vault that physically separates your cash from your wallet — even if someone steals your wallet, the cash stays locked away — the Trezor One keeps private keys isolated from internet-connected devices. It is an open-source hardware security key (HSM-adjacent device) designed for cryptocurrency private key storage, ensuring that signing operations occur on the device itself, never exposing keys to the host machine.

## Why it matters
In 2022, researchers at Unciphered demonstrated a voltage glitching attack against Trezor One's STM32 microcontroller, allowing extraction of the encrypted seed from flash memory — bypassing PIN protection entirely if an attacker had physical access. This illustrates a critical hardware security principle: physical access often defeats software-layer protections, and threat models must account for supply chain and possession attacks, not just network-based intrusions.

## Key facts
- Uses a **BIP-39 seed phrase** (12–24 words) as the root secret; compromise of this phrase = total loss of all derived keys
- Private key operations (signing transactions) occur **on-device only** — the host computer sees only the signed output, never the key itself
- Lacks a **secure element chip** (unlike Ledger), making it more vulnerable to physical extraction attacks via fault injection or glitching
- PIN brute-force is rate-limited with **exponential delays**, doubling wait time after each failed attempt up to ~17 minutes at 16 attempts
- Open-source firmware enables community auditing but also allows attackers to study the codebase for exploitable logic

## Related concepts
[[Hardware Security Module (HSM)]] [[BIP-39 Seed Phrase]] [[Side-Channel Attack]] [[Fault Injection Attack]] [[Cold Storage]]