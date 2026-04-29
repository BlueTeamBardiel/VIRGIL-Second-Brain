# LibreSSL

## What it is
Think of LibreSSL as a neighborhood watch formed after a major break-in — created specifically because the original homeowners (OpenSSL) proved dangerously negligent. LibreSSL is a fork of OpenSSL developed by the OpenBSD team in 2014, built to provide a cleaner, more auditable implementation of the TLS/SSL cryptographic protocols. It strips out decades of legacy code bloat and insecure defaults that made OpenSSL a persistent attack surface.

## Why it matters
The Heartbleed vulnerability (CVE-2014-0160) exposed a catastrophic buffer over-read in OpenSSL that leaked private keys and session data from millions of servers — the direct catalyst for LibreSSL's creation. LibreSSL's aggressive removal of dead code and enforcement of safer memory handling practices directly reduces the likelihood of similar implementation-level flaws surviving a code audit. Organizations running OpenBSD or macOS (which briefly adopted LibreSSL) benefit from this hardened posture without changing their TLS workflows.

## Key facts
- **Born from Heartbleed (2014):** The OpenBSD team forked OpenSSL within two weeks of Heartbleed's disclosure, removing over 90,000 lines of code in the first week
- **Removes legacy protocols:** LibreSSL disables SSLv2 and SSLv3 by default, mitigating POODLE and DROWN attack vectors out of the box
- **API compatible:** It maintains backward compatibility with most OpenSSL applications, meaning it's a drop-in replacement for many deployments
- **Portable edition:** `LibreSSL Portable` packages it for Linux and other Unix-like systems beyond OpenBSD
- **Separate from BoringSSL:** Google independently forked OpenSSL into BoringSSL for Chrome/Android — both are hardened alternatives but maintained by different teams with different goals

## Related concepts
[[OpenSSL]] [[Heartbleed]] [[TLS]] [[POODLE Attack]] [[Cryptographic Libraries]]