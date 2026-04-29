# Lenovo Support

## What it is
Think of it like a car dealership's service center — it's the official channel for maintaining and repairing your vehicle, but if the mechanic is compromised, every car they touch gets tampered with. Lenovo Support is the official technical assistance ecosystem provided by Lenovo, encompassing software utilities, firmware updates, driver packages, and remote support tools pre-installed on Lenovo devices (such as Lenovo Vantage and System Update).

## Why it matters
In 2015, Lenovo shipped consumer laptops with **Superfish** adware pre-installed — a classic supply chain attack where the vendor's own support software became the attack vector. Superfish installed a self-signed root CA certificate, enabling man-in-the-middle interception of HTTPS traffic on the user's own machine, effectively breaking TLS trust before the user ever opened a browser.

## Key facts
- **Lenovo Vantage** and the older **Lenovo System Update** tool run with elevated privileges and auto-download packages, making them high-value targets for privilege escalation if update integrity isn't verified.
- The **Superfish incident** is a canonical supply chain / bloatware example tested on Security+ — it violated certificate trust by injecting a rogue root CA into the Windows certificate store.
- Lenovo has disclosed multiple **BIOS/UEFI firmware vulnerabilities** (e.g., CVE-2021-3971/3972) in its support stack, allowing attackers to disable Secure Boot or write to protected flash regions.
- Pre-installed OEM support software ("bloatware") consistently expands the **attack surface** of endpoint devices before any user action occurs.
- Hardening guidance includes **removing unnecessary OEM utilities**, verifying software integrity via hashes, and applying firmware updates through authenticated channels.

## Related concepts
[[Supply Chain Attack]] [[UEFI Firmware Security]] [[Man-in-the-Middle Attack]] [[Bloatware]] [[Certificate Authority Trust]]