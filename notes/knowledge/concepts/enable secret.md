# enable secret

## What it is
Like a bank vault with a combination lock *inside* the building — even if someone gets through the front door, they still hit an encrypted barrier. `enable secret` is a Cisco IOS command that sets a password required to enter privileged EXEC mode (enable mode), stored as an MD5 hash in the device's running/startup configuration rather than in plaintext.

## Why it matters
During a network penetration test, an attacker who gains access to a Cisco router's configuration file via TFTP misconfiguration or physical console access will find `enable secret` stored as a hash — buying defenders time and requiring cracking effort. Without it (or if only the weaker `enable password` is set), the password may appear in cleartext, instantly handing the attacker full device control and the ability to pivot through the entire network.

## Key facts
- `enable secret` uses MD5 hashing (type 5) by default; newer IOS versions support stronger algorithms like SHA-256 (type 8) and SHA-512 (type 9)
- When both `enable secret` and `enable password` are configured on the same device, `enable secret` always takes precedence
- `enable password` stores credentials in **plaintext** or weak reversible encryption (type 7) — it is considered insecure and deprecated in favor of `enable secret`
- Type 7 passwords can be decoded instantly with freely available online tools, making them functionally equivalent to plaintext
- Hardening standards (CIS Cisco Benchmarks) require `enable secret` with a strong algorithm and prohibit `enable password` use

## Related concepts
[[privileged EXEC mode]] [[password hashing]] [[Cisco IOS hardening]] [[type 7 password vulnerability]] [[network device hardening]]