# Key Rotation

## What it is
Like changing the locks on your house after a roommate moves out — even if they never misused their key, their access window should close. Key rotation is the practice of periodically replacing cryptographic keys with newly generated ones, limiting the window of exposure if a key is ever silently compromised.

## Why it matters
In the 2013 Adobe breach, attackers exfiltrated encrypted passwords along with the encryption keys used to protect them — meaning the keys were as compromised as the data. Had Adobe routinely rotated those keys and re-encrypted sensitive data, the blast radius of any single key theft would have been dramatically smaller, limiting long-term attacker leverage.

## Key facts
- **Limits the cryptoperiod** — the defined lifespan of a key's authorized use; NIST SP 800-57 provides explicit guidance on cryptoperiods by key type and algorithm.
- **Reduces exposure from undetected compromise** — an attacker who silently steals a key gains nothing after rotation revokes that key's usefulness.
- **Mandatory in many compliance frameworks** — PCI-DSS requires encryption key rotation at least annually for keys protecting cardholder data.
- **Automated rotation is preferred** — manual rotation is error-prone; cloud providers (AWS KMS, Azure Key Vault) support automatic rotation schedules to eliminate human delay.
- **Rotation ≠ revocation** — rotation is scheduled and proactive; revocation is reactive, triggered by confirmed or suspected compromise, and typically uses a CRL or OCSP.

## Related concepts
[[Certificate Revocation]] [[Public Key Infrastructure (PKI)]] [[Cryptoperiod]] [[Key Management]] [[Hardware Security Module (HSM)]]