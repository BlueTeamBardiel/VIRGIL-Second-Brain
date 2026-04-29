# dnf

## What it is
Like a librarian who not only fetches the book you asked for but automatically retrieves every reference it cites, `dnf` (Dandified YUM) is a package manager for RPM-based Linux systems that resolves and installs software dependencies automatically. It is the modern successor to `yum`, used on Fedora, RHEL 8+, and CentOS Stream to install, update, and remove software packages from configured repositories.

## Why it matters
During a supply chain attack, a threat actor who compromises a trusted Linux repository can push malicious package updates that `dnf update` will silently pull and execute with root privileges — exactly the attack vector behind the 2024 XZ Utils backdoor incident. Defenders counter this by configuring GPG signature verification in `dnf` and using repository pinning to prevent unauthorized package sources from being added.

## Key facts
- `dnf` enforces GPG signature checking by default (`gpgcheck=1` in `/etc/yum.repos.d/*.repo`), making unsigned packages a red flag during security audits
- Running `dnf history` provides a full audit trail of installed, updated, and removed packages — critical for incident response and change tracking
- `dnf` repos are defined in `/etc/yum.repos.d/`; rogue `.repo` files dropped by malware can redirect package downloads to attacker-controlled servers
- The `--security` flag (`dnf update --security`) restricts updates to only security-relevant patches, useful in hardened environments
- Privilege escalation via `dnf` is documented in GTFOBins — if `sudo dnf` is misconfigured, an attacker can install a malicious RPM to gain a root shell

## Related concepts
[[Package Manager Security]] [[Supply Chain Attack]] [[Privilege Escalation]] [[Sudo Misconfiguration]] [[GPG Signature Verification]]