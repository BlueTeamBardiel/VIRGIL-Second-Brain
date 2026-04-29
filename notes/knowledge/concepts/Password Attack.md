# Password Attack

## What it is
Like a thief trying every key on a massive keyring until one opens the lock, a password attack is any technique used to recover or bypass authentication credentials. These attacks exploit weak passwords, poor storage practices, or authentication logic to gain unauthorized access to systems.

## Why it matters
In 2012, LinkedIn suffered a breach where 6.5 million SHA-1 unsalted password hashes were dumped publicly. Because SHA-1 is fast and the hashes lacked salts, attackers cracked the majority within days using rainbow tables — exposing how poor hashing choices turn a breach into a credential catastrophe.

## Key facts
- **Brute force** tries every possible combination; **dictionary attacks** use wordlists of common passwords — dictionary attacks are far faster in practice
- **Rainbow table attacks** use precomputed hash chains to reverse hashes; **salting** defeats rainbow tables by making each hash unique even for identical passwords
- **Credential stuffing** takes leaked username/password pairs and replays them against other services, exploiting password reuse — highly effective because ~65% of users reuse passwords
- **Password spraying** tries one common password (e.g., `Winter2024!`) against many accounts to avoid account lockout thresholds — common against Active Directory and Office 365
- **Pass-the-hash (PtH)** doesn't crack the password at all — it captures the NTLM hash and replays it directly for authentication, bypassing the need for plaintext recovery

## Related concepts
[[Brute Force Attack]] [[Credential Stuffing]] [[Multi-Factor Authentication]] [[Rainbow Table]] [[Pass-the-Hash]]