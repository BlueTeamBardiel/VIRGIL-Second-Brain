# BSD

## What it is
Like a family of custom-built sports cars all derived from the same original blueprint, BSD (Berkeley Software Distribution) is a Unix-derived operating system family — including FreeBSD, OpenBSD, and NetBSD — each forked from the original AT&T Unix source code developed at UC Berkeley in the 1970s-80s. These are full operating systems, not Linux distributions, sharing a common lineage but diverging significantly in security philosophy and design goals.

## Why it matters
OpenBSD, one BSD variant, is so security-hardened by default that it powers many enterprise firewalls and is the origin of OpenSSH — the protocol securing billions of remote connections daily. When administrators deploy pfSense (a FreeBSD-based firewall), they're leveraging BSD's stable, audited codebase to protect network perimeters; an attacker targeting such a firewall must contend with a significantly smaller attack surface than typical Linux systems because OpenBSD ships with almost all services disabled by default.

## Key facts
- **OpenSSH originated in OpenBSD** — arguably the most widely deployed cryptographic protocol in history came from this OS family
- **BSD license is more permissive than GPL** — companies can incorporate BSD code into proprietary products without open-sourcing their changes (unlike Linux's GPL)
- **OpenBSD's security mantra:** "Only two remote holes in the default install, in a heck of a long time" — reflecting its minimal-default-services approach
- **FreeBSD powers major infrastructure** — Netflix, PlayStation Network, and WhatsApp have used FreeBSD in production
- **BSD uses a different kernel + userland model** than Linux; the entire OS (kernel and core utilities) is developed as one unified codebase, improving consistency of security auditing

## Related concepts
[[OpenSSH]] [[Hardened Operating Systems]] [[Least Privilege]] [[Firewall Architecture]] [[Open Source Licensing]]