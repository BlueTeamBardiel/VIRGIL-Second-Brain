# OpenVPN

## What it is
Think of it like a sealed pneumatic tube running through a busy post office — your package travels inside a locked cylinder, invisible to every postal worker handling it. OpenVPN is an open-source VPN solution that creates encrypted tunnels over TCP or UDP, using SSL/TLS for key exchange and authentication to secure traffic between endpoints across untrusted networks.

## Why it matters
A remote employee connecting to corporate resources over public Wi-Fi at an airport is trivially vulnerable to a man-in-the-middle attack — an adversary can intercept unencrypted credentials or session tokens. Deploying OpenVPN forces all traffic through an authenticated, encrypted tunnel, meaning even if the underlying network is compromised, the attacker sees only ciphertext they cannot practically decrypt.

## Key facts
- Uses **SSL/TLS** for the control channel (authentication and key exchange) and can use **AES-256-GCM** for the data channel encryption — both considered strong by current standards
- Operates on **UDP port 1194** by default, but can be configured to run over **TCP 443** to blend with HTTPS traffic and bypass restrictive firewalls
- Supports two authentication modes: **certificate-based (PKI)** and **username/password**, with certificate-based being significantly stronger against credential-stuffing attacks
- Runs entirely in **user space**, not kernel space, which simplifies cross-platform deployment but introduces slightly more overhead compared to kernel-level solutions like WireGuard
- OpenVPN's **two channels** — control (TLS-protected) and data (HMAC-authenticated) — mean even if the data channel is somehow attacked, the control channel key material remains separately protected

## Related concepts
[[TLS Handshake]] [[PKI]] [[IPSec]] [[WireGuard]] [[Split Tunneling]]