# Lenovo Software Fix

## What it is
Like a landlord quietly installing a skeleton key in every apartment before tenants move in, Lenovo pre-installed hidden software on consumer laptops that created serious vulnerabilities before users ever touched the device. "Lenovo Software Fix" refers specifically to the remediation patches and removal tools Lenovo released in 2015 to address **Superfish**, a man-in-the-middle adware that shipped pre-installed on consumer laptops and broke HTTPS certificate validation system-wide.

## Why it matters
Superfish installed its own self-signed root Certificate Authority (CA) into the Windows certificate store, allowing it to intercept and decrypt all HTTPS traffic to inject ads — and any attacker on the same network could exploit the same CA (whose private key was easily extracted and shared publicly) to perform undetected MITM attacks against affected users. This meant a coffee shop attacker could silently intercept encrypted banking sessions on any unpatched Lenovo laptop.

## Key facts
- Superfish used a **self-signed root CA** installed in the Windows Trusted Root store, undermining the entire chain of trust for TLS/SSL.
- The Superfish private key was cracked within **hours** of public disclosure using the password "komodia," exposing millions of devices simultaneously.
- Lenovo released a standalone **removal tool** and a **security advisory** because manual removal was insufficient — deleting the application left the rogue CA certificate in place.
- This incident is a textbook example of a **supply chain attack** — the vulnerability was introduced before the product reached the end user.
- Affected Lenovo models shipped between **2014–2015**; the fix required both application uninstallation and manual or tool-assisted CA certificate removal from the Windows trust store.

## Related concepts
[[Supply Chain Attack]] [[Man-in-the-Middle Attack]] [[Certificate Authority Compromise]]