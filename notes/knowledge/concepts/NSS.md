# NSS

## What it is
Like a specialized tool belt that only holds cryptographic instruments, NSS (Network Security Services) is a set of open-source cryptographic libraries developed by Mozilla that provides implementations of SSL/TLS, PKI, and other security standards. Applications like Firefox and Thunderbird use NSS under the hood to handle certificates, encryption, and digital signatures without reinventing the wheel.

## Why it matters
In 2015, researchers discovered the **FREAK attack**, which exploited weaknesses in how NSS (among other libraries) handled export-grade RSA keys — legacy 512-bit keys mandated by 1990s U.S. export law. Attackers could perform a man-in-the-middle attack to force NSS-based clients to downgrade to these weak keys, then crack them and decrypt the session. Patching NSS was critical to closing this vulnerability across millions of Firefox users simultaneously.

## Key facts
- NSS is maintained by Mozilla and is the cryptographic backbone of Firefox, Thunderbird, and LibreOffice
- It implements **PKCS #11** as its interface for communicating with hardware security modules (HSMs) and smart cards
- NSS stores certificates and keys in a local **certificate database** (traditionally `cert8.db`/`key3.db`, now SQLite-based `cert9.db`)
- The `certutil` and `pk12util` command-line tools are part of NSS and used for managing certificates — common in Linux environments
- NSS has been subject to multiple CVEs related to **buffer overflows** and **signature forgery** (e.g., CVE-2021-43527, a critical heap overflow in DER-encoded DSA/RSA-PSS signatures)

## Related concepts
[[TLS]] [[PKI]] [[Certificate Management]] [[PKCS#11]] [[OpenSSL]]