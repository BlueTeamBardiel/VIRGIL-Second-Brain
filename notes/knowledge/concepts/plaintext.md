# plaintext

## What it is
Like a postcard anyone can read while it sits in the mailbox, plaintext is information in its raw, human-readable form — unencrypted and fully exposed. Precisely, it is any data that has not been transformed by a cryptographic process, making its contents directly intelligible to whoever accesses it.

## Why it matters
In 2012, LinkedIn suffered a breach where millions of passwords were stored as unsalted SHA-1 hashes — weak enough that attackers cracked them within hours, effectively exposing plaintext passwords. This attack illustrates why plaintext (or near-plaintext) credential storage is catastrophic: once an attacker has it, there is no second line of defense.

## Key facts
- Plaintext is the **input** to an encryption algorithm; the scrambled output is called **ciphertext**
- Transmitting credentials over HTTP sends them as plaintext, which is why HTTPS/TLS is mandatory for login pages
- "Plaintext attack" scenarios include **known-plaintext attacks (KPA)**, where an adversary possesses both the plaintext and its corresponding ciphertext to deduce the key
- Storing passwords as plaintext (rather than salted hashes) is a direct violation of NIST SP 800-63B and a critical finding in any security audit
- In forensics, recovering plaintext from encrypted storage (without the key) is computationally infeasible with modern algorithms — this is the entire security guarantee of encryption

## Related concepts
[[ciphertext]] [[encryption]] [[known-plaintext attack]] [[hashing]] [[TLS]]