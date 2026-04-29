# Strong Password Policy

## What it is
Like a bank vault that requires both a specific combination length AND random digits rather than "1234," a strong password policy is an organizational ruleset that enforces complexity, length, age, and reuse restrictions on user credentials. It transforms passwords from guessable phrases into computationally expensive targets for attackers.

## Why it matters
In the 2012 LinkedIn breach, 117 million passwords were cracked because users chose simple passwords like "linkedin" and "123456" — and LinkedIn failed to enforce any meaningful complexity requirements. A strong password policy with minimum 12 characters, mixed character classes, and reuse prevention would have dramatically reduced the number of crackable credentials even after the hash dump.

## Key facts
- **Minimum length beats complexity**: NIST SP 800-63B (2017) recommends at least **8 characters minimum**, but security professionals favor **16+**; length exponentially increases brute-force time
- **NIST no longer recommends mandatory periodic rotation** unless compromise is suspected — forced rotation leads to predictable patterns like `Password1!` → `Password2!`
- **Password history enforcement** (typically last 10–24 passwords) prevents users from cycling back to compromised credentials
- **Account lockout policy** (e.g., 5 failed attempts → 30-minute lockout) mitigates online brute-force attacks but must balance availability concerns
- **Complexity requirements** should include at least 3 of 4 character types: uppercase, lowercase, numbers, special characters — enforced at the **directory or IdP level** (Active Directory, Okta)

## Related concepts
[[Multi-Factor Authentication]] [[Credential Stuffing]] [[Account Lockout Policy]] [[Password Hashing]] [[NIST SP 800-63B]]