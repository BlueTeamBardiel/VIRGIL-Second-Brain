# MikroTik

## What it is
Think of MikroTik like a Swiss Army knife sold at a discount store — it packs professional-grade networking tools into budget hardware that ends up deployed everywhere from ISPs in Eastern Europe to small coffee shop networks. MikroTik is a Latvian company producing routers and switches running RouterOS, a Linux-based network operating system with powerful features like firewall rules, VPN, traffic shaping, and BGP routing at a fraction of enterprise costs.

## Why it matters
In 2018, a massive botnet campaign called "VPNFilter" and a separate "MikroTik cryptojacking" attack compromised over 200,000 MikroTik routers by exploiting CVE-2018-14847, a Winbox directory traversal vulnerability that exposed credential databases without authentication. Attackers injected malicious traffic-shaping rules to redirect user traffic through attacker-controlled proxies, turning victim networks into covert surveillance infrastructure. This demonstrated how cheap, widely-deployed edge devices with delayed patch cycles become high-value targets for nation-state actors.

## Key facts
- **CVE-2018-14847**: Critical Winbox (port 8291) vulnerability allowing unauthenticated read of `/flash/rw/store/user.dat`, leaking plaintext credentials
- RouterOS uses a proprietary management protocol (Winbox) on port 8291 and a web interface on port 80/443 — both have historically been attack surfaces
- Default credentials (`admin` / no password) are factory-set and frequently left unchanged in deployments
- MikroTik devices are frequently discovered in botnet C2 infrastructure due to their public IP exposure and weak default configurations
- RouterOS supports scripting via the `/system script` feature, which attackers abuse for persistence after initial compromise

## Related concepts
[[Edge Device Security]] [[CVE Exploitation]] [[Botnet Infrastructure]] [[Default Credentials]] [[Network Segmentation]]