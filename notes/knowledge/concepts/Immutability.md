# Immutability

## What it is
Like a wax seal on a medieval letter — once pressed, any tampering is immediately visible and the original can't be quietly altered. In security, immutability means a resource (server, container, log record) cannot be modified after creation; instead of patching it, you destroy and replace it with a known-good version.

## Why it matters
In 2020, attackers compromised SolarWinds' build pipeline and modified software updates in transit — a classic tampering attack. Immutable infrastructure defenses directly counter this: if production servers are never modified post-deployment and are rebuilt from verified golden images, an attacker who gains a foothold finds their changes wiped on the next automated redeploy, dramatically shrinking dwell time.

## Key facts
- **Immutable logs** are critical for forensic integrity — SIEM solutions often write logs to write-once storage (WORM drives) so evidence cannot be retroactively altered by an attacker covering tracks
- **Containers** (e.g., Docker) embrace immutability by design — a running container's filesystem changes are discarded when it stops, returning to a clean image state
- **Integrity hashing** (SHA-256 checksums, digital signatures) enforces immutability by making any modification *detectable*, even if the system itself doesn't block the change
- **Immutable infrastructure** shifts patching from in-place updates to full replacement, eliminating configuration drift and reducing the attack surface from unauthorized changes
- **Blockchain** achieves immutability through cryptographic chaining — altering any block invalidates all subsequent blocks, making tampering computationally impractical

## Related concepts
[[Integrity]] [[WORM Storage]] [[Configuration Management]] [[Container Security]] [[Digital Signatures]]