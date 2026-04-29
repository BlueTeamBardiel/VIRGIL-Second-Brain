# power analysis

## What it is
Like reading someone's heartbeat to know when they're lying, power analysis watches the electrical current a device draws to infer what secret computations it's performing. It is a side-channel attack that measures a cryptographic device's power consumption during encryption or decryption, then uses statistical methods to extract private keys — without ever touching the software or breaking the algorithm mathematically.

## Why it matters
In 1999, researchers Paul Kocher, Joshua Jaffe, and Benjamin Jun demonstrated Simple Power Analysis (SPA) and Differential Power Analysis (DPA) against smart cards, extracting DES keys in seconds. This broke millions of deployed banking and SIM cards that were mathematically secure — the algorithm was fine, but the hardware leaked secrets through its own power draw.

## Key facts
- **Simple Power Analysis (SPA)**: a single power trace is analyzed visually to distinguish operations (e.g., squaring vs. multiplication in RSA reveals key bits directly)
- **Differential Power Analysis (DPA)**: statistically compares thousands of power traces with hypothetical key guesses; far more powerful and works against AES, DES, and ECC
- **Countermeasures** include power-line filtering, randomized execution timing, adding dummy operations (algorithmic noise), and constant-time implementations to flatten the power signature
- **Target devices** are typically embedded systems: smart cards, HSMs, IoT sensors, and TPM chips — any device running crypto in constrained hardware
- Power analysis is a **passive, non-invasive attack** — it requires only a current probe or resistor in series with the device's power supply, leaving no forensic trace

## Related concepts
[[side-channel attack]] [[timing attack]] [[electromagnetic analysis]] [[differential fault analysis]] [[hardware security module]]