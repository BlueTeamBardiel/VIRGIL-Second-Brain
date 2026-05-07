# DNS rebinding

## What it is
Imagine a locksmith who shows you legitimate credentials to enter a building, then swaps their identity badge mid-visit to gain access to restricted floors they were never authorized to enter. DNS rebinding tricks a browser into believing a malicious external site is actually a trusted local resource — the attacker first serves a normal hostname that resolves to their server, then rapidly changes the DNS record to resolve to an internal IP (e.g., 192.168.1.1), bypassing the browser's Same-Origin Policy.

## Why it matters
An attacker hosting a malicious webpage can use DNS rebinding to make a victim's browser act as a proxy, issuing requests to the victim's internal router admin panel (typically 192.168.1.1) and exfiltrating configuration data or changing settings. This was demonstrated against home routers and IoT devices where no authentication existed on the internal interface — the browser itself becomes the attack tool.

## Key facts
- **Same-Origin Policy bypass**: DNS rebinding defeats SOP because the browser sees requests as going to the "same origin" after the DNS swap, allowing cross-origin reads
- **TTL manipulation**: Attackers set extremely low DNS TTLs (often 0–1 seconds) to force rapid re-resolution to an internal IP address
- **Defense — DNS pinning**: Browsers cache the first IP for the lifetime of a tab to resist rebinding, though this protection is inconsistently implemented
- **Defense — private IP filtering**: DNS resolvers and firewalls should reject DNS responses that resolve public hostnames to RFC 1918 private addresses (e.g., 10.x.x.x, 172.16.x.x, 192.168.x.x)
- **Attack surface**: Any service listening on localhost or LAN without authentication is vulnerable — routers, IoT dashboards, development servers (e.g., Kubernetes dashboards)

## Related concepts
[[Same-Origin Policy]] [[Cross-Site Request Forgery]] [[DNS Spoofing]]