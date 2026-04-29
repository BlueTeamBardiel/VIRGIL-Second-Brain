# SSH Public Key Authentication

## What it is
Imagine a padlock you leave on a server, and only *you* hold the matching key — no one needs to shout the combination across the room. SSH public key authentication works exactly like this: a **key pair** (public + private) replaces passwords, where the server stores your public key and you authenticate by proving possession of the private key through a cryptographic challenge-response, never transmitting the secret itself.

## Why it matters
In 2020, the SolarWinds attackers pivoted laterally through compromised environments partly because password-based SSH credentials were reused and exposed. Organizations using public key authentication with properly restricted `authorized_keys` files would have significantly narrowed that lateral movement surface — a stolen password is useless when the server only accepts cryptographic proof.

## Key facts
- The **private key never leaves the client**; the server only holds the public key in `~/.ssh/authorized_keys`
- Authentication works via a **challenge-response**: the server encrypts a random value with your public key; only the holder of the private key can decrypt and return it
- Private keys should be protected with a **passphrase**, adding a second factor even if the key file is stolen
- Default key algorithms: **RSA (2048/4096-bit)**, **Ed25519** (preferred for modern systems — shorter, faster, equally secure), and ECDSA
- Disabling **PasswordAuthentication** in `sshd_config` and enforcing key-only login eliminates brute-force and credential-stuffing attacks against SSH entirely

## Related concepts
[[Asymmetric Cryptography]] [[Multi-Factor Authentication]] [[Privilege Escalation]]