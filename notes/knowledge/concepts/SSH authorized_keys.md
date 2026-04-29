# SSH authorized_keys

## What it is
Think of it like a nightclub's VIP list — if your name (public key) is on the list, you walk right in without showing ID (no password needed). The `authorized_keys` file is a plaintext file stored in `~/.ssh/authorized_keys` on an SSH server that contains public keys whose corresponding private key holders are granted passwordless login access.

## Why it matters
Attackers who gain temporary write access to a target system will often inject their own public key into `authorized_keys` — a technique called **SSH key persistence** — allowing them to return indefinitely even after passwords are changed or the initial vulnerability is patched. This is a common post-exploitation move in Linux intrusions and appears in real-world APT toolkits, making it a critical artifact to hunt during incident response.

## Key facts
- Located at `~/.ssh/authorized_keys` by default; each line holds one public key with optional options and a comment field
- Permissions matter critically: the file must be `600` (owner read/write only) and the `~/.ssh/` directory must be `700`, or SSH will refuse to use the file
- Each entry can include restrictions like `command="backup.sh"` (forced command), `no-pty`, or `from="192.168.1.0/24"` to limit what that key can do
- Unauthorized entries in this file indicate **persistence mechanisms** — a key IOC in CySA+ incident response scenarios
- `sshd_config` directive `AuthorizedKeysFile` controls the lookup path; adversaries can modify this to point to attacker-controlled locations

## Related concepts
[[SSH Public Key Authentication]] [[Privilege Persistence]] [[Linux File Permissions]] [[Indicator of Compromise]] [[sshd_config Hardening]]