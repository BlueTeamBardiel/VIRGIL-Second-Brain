# apt-get

## What it is
Think of apt-get like a trusted librarian who fetches, verifies, and installs books (software) from a curated catalog — but if someone poisons the catalog, every book you receive could be compromised. Precisely, `apt-get` is a command-line package management tool for Debian-based Linux systems (Ubuntu, Kali, etc.) that handles downloading, installing, upgrading, and removing software packages along with their dependencies.

## Why it matters
In 2016, the Linux Mint website was compromised and attackers replaced the ISO with a backdoored version — a reminder that supply chain attacks target the distribution layer itself. Defenders use `apt-get` to apply security patches rapidly (`apt-get upgrade` or `apt-get dist-upgrade`), and failure to run timely updates is one of the most exploited gaps in system hardening. Unpatched systems reachable via known CVEs are low-hanging fruit for automated scanning tools like Shodan-connected bots.

## Key facts
- `apt-get update` refreshes the package index from repositories but does **not** install updates — it is frequently confused with `apt-get upgrade`, which actually installs them
- Package authenticity is verified using **GPG signatures** on repository metadata; tampering triggers a warning and blocks installation by default
- Running `apt-get install <package>` as root or via `sudo` grants elevated privilege — a misconfigured sudoers file allowing unrestricted apt-get can be exploited for **privilege escalation** (GTFOBins documents this)
- `/etc/apt/sources.list` defines trusted repositories — adding a malicious PPA (Personal Package Archive) here is a classic persistence and supply chain attack vector
- `apt-get autoremove` removes orphaned dependencies, reducing attack surface by eliminating unnecessary software

## Related concepts
[[Package Manager Security]] [[Privilege Escalation]] [[Supply Chain Attack]] [[Patch Management]] [[Sudo Misconfiguration]]