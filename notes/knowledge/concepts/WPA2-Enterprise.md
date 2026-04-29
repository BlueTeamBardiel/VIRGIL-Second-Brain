# WPA2-Enterprise

## What it is
Imagine a nightclub where instead of everyone knowing the same password written on a flyer, each person shows their own ID to a bouncer who calls headquarters to verify it — that's WPA2-Enterprise. It is a Wi-Fi security mode that replaces a shared passphrase with individual user authentication via a RADIUS server using the 802.1X framework and EAP protocols. Each user authenticates with unique credentials (certificates, username/password), so compromising one account doesn't expose the entire network.

## Why it matters
In a corporate breach scenario, an attacker who captures a WPA2-Personal handshake can crack the single shared PSK offline, instantly gaining access for every device on the network. WPA2-Enterprise prevents this by issuing per-user, per-session encryption keys — even if an attacker captures traffic and cracks one session, no other user's communications are exposed. This is why hospitals and financial institutions mandate it for wireless infrastructure.

## Key facts
- Uses **802.1X port-based access control** with a backend **RADIUS server** (commonly FreeRADIUS or Cisco ISE) to authenticate each user individually
- Supports multiple **EAP variants**: EAP-TLS (mutual certificate auth — strongest), PEAP (password inside TLS tunnel — most common), and EAP-TTLS
- Each authenticated session derives a unique **Pairwise Master Key (PMK)**, making offline PSK cracking attacks irrelevant
- A misconfigured client that **doesn't validate the server's certificate** is vulnerable to an **Evil Twin / RADIUS impersonation attack** using tools like hostapd-wpe
- Requires a **PKI infrastructure** for EAP-TLS, adding operational complexity but providing the strongest authentication guarantees

## Related concepts
[[RADIUS]] [[802.1X]] [[EAP-TLS]] [[Evil Twin Attack]] [[WPA2-Personal]]