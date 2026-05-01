# padding oracle attack

## What it is
Imagine a lock that doesn't tell you *what* the secret is, but *does* tell you whether you inserted the key correctly — now you can brute-force the lock one tumbler at a time. A padding oracle attack exploits a system that reveals whether decrypted ciphertext has valid padding, allowing an attacker to decrypt messages or forge ciphertext **without ever knowing the key**. The "oracle" is any signal — an error message, timing difference, or HTTP response code — that leaks padding validity.

## Why it matters
In 2010, the POODLE and BEAST attacks demonstrated real-world exploitation of padding oracles in SSL/TLS. The ASP.NET vulnerability (MS10-070) allowed attackers to decrypt session cookies by sending crafted requests and observing whether the server returned a 500 error versus a 200 — leaking one byte of plaintext per ~128 requests, eventually compromising encrypted ViewState and authentication tokens.

## Key facts
- **Targets block ciphers in CBC mode** (e.g., AES-CBC); the attack exploits how XOR chaining interacts with PKCS#7 padding validation
- **Decrypts without the key**: an attacker only needs ciphertext and oracle access, recovering 1 byte per ~256 requests on average
- **Also enables encryption forgery**: attacker can craft arbitrary ciphertext that decrypts to chosen plaintext
- **Fix**: use **authenticated encryption** (AES-GCM) or apply MAC-then-encrypt with constant-time comparison — never reveal padding errors distinctly from decryption errors
- **Side-channel variant**: even if error messages are identical, timing differences in server responses can serve as the oracle (timing oracle)

## Related concepts
[[CBC mode encryption]] [[chosen ciphertext attack]] [[authenticated encryption]] [[PKCS7 padding]] [[side-channel attack]]
