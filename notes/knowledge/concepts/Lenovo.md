# Lenovo

## What it is
Like a car manufacturer that installs a hidden GPS tracker in every vehicle before it leaves the factory, Lenovo is a hardware OEM that has historically shipped devices with pre-installed software (bloatware/adware) that created significant security vulnerabilities. Lenovo is a Chinese multinational technology company and the world's largest PC vendor, producing ThinkPad, IdeaPad, and Legion product lines widely deployed in enterprise and consumer environments.

## Why it matters
In 2015, Lenovo shipped consumer laptops pre-installed with **Superfish** adware, which injected a self-signed root certificate into the Windows certificate store. This allowed Superfish to perform a man-in-the-middle attack on all HTTPS traffic — including banking sessions — without triggering browser warnings. Any attacker on the same network who knew the Superfish private key (which was quickly extracted and published) could intercept encrypted communications from affected machines.

## Key facts
- **Superfish (2015):** Pre-installed adware used a rogue root CA certificate to intercept TLS traffic; affected ~750,000 consumer laptops; CVSS-rated critical
- The Superfish private key was protected only by the password "komodia," cracked within hours of discovery — a catastrophic key management failure
- Lenovo also shipped **LenovoEME**, **OneKey Optimizer**, and **LSE (Lenovo Service Engine)** — the last of which persisted in UEFI firmware, reinstalling itself even after OS wipe
- LSE wrote files to the Windows system directory on first boot using UEFI, making traditional reimaging insufficient for remediation — a supply chain firmware attack
- U.S. DoD and federal agencies have historically restricted Lenovo hardware procurement due to espionage concerns tied to Chinese government influence

## Related concepts
[[Supply Chain Attack]] [[Man-in-the-Middle Attack]] [[Certificate Authority]] [[UEFI Firmware Security]] [[Bloatware]]