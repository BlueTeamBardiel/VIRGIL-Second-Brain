# Vaultwarden

## What it is
Think of it as building your own bank vault in your basement instead of renting a safety deposit box from a commercial bank — you control everything, but you also carry all the responsibility. Vaultwarden is an unofficial, open-source, self-hosted backend server that is fully compatible with Bitwarden clients, written in Rust, designed to run on minimal hardware. It allows individuals and organizations to operate their own password manager infrastructure rather than relying on Bitwarden's cloud servers.

## Why it matters
A security-conscious organization might deploy Vaultwarden on an air-gapped or internal network so that employee credentials never leave the corporate perimeter — eliminating third-party breach exposure. However, a misconfigured Vaultwarden instance exposed to the internet without proper TLS, strong admin credentials, or rate limiting becomes a high-value target: one successful compromise hands an attacker an entire organization's credential vault in a single breach.

## Key facts
- Vaultwarden is **not** an official Bitwarden product; it reimplements the Bitwarden server API and is community-maintained, meaning security patches depend on volunteer contributors
- The admin panel (`/admin`) is disabled by default but, if enabled without a strong token, represents a critical attack surface for unauthorized vault access
- Self-hosting shifts responsibility for **encryption key management, backup integrity, and TLS certificate maintenance** entirely to the operator
- Vault data is encrypted client-side using AES-256-CBC before transmission, meaning the server stores ciphertext — but server compromise can still enable phishing relay or MitM attacks against syncing clients
- Relevant hardening controls include: disabling open registration (`SIGNUPS_ALLOWED=false`), enabling 2FA enforcement, and placing the instance behind a reverse proxy with fail2ban integration

## Related concepts
[[Password Manager Security]] [[Self-Hosted Infrastructure]] [[Secrets Management]] [[Credential Exposure]] [[Defense in Depth]]