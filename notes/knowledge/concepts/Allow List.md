# Allow List

## What it is
Like a velvet-rope club where only names already on the guest list get in — everyone else is turned away by default, no arguments. An allow list (formerly "whitelist") is a security control that explicitly permits only pre-approved entities — applications, IPs, domains, or file hashes — while blocking everything else by default. This is the inverse of a deny list and follows the principle of least privilege at the access-control layer.

## Why it matters
In 2020, attackers targeted industrial control systems by deploying malicious executables disguised as legitimate software. Organizations with application allow listing in place blocked execution outright — the unsigned or unrecognized binary hash simply couldn't run, regardless of how convincingly it was packaged. This stopped the attack cold where signature-based AV would have failed against a novel payload.

## Key facts
- **Default-deny posture**: Allow lists block everything not explicitly permitted — the opposite of deny lists, which only block known-bad items
- **Application allow listing** is a top mitigation recommended by NIST and CISA against ransomware and APTs; it prevents unauthorized executables from running even if malware bypasses AV
- **Types of allow list criteria** include file path, cryptographic hash (most secure), digital signature/publisher, or IP/domain
- **Hash-based allow listing** is the most precise but high-maintenance — any software update changes the hash, requiring list updates
- **Email allow lists** (trusted sender lists) are a common anti-phishing complement to spam filters; spoofed domains not on the list are quarantined by default

## Related concepts
[[Deny List]] [[Application Control]] [[Principle of Least Privilege]] [[Zero Trust Architecture]]