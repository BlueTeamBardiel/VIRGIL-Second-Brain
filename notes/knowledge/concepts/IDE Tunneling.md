# IDE Tunneling

## What it is
Imagine a secret postal service hidden inside a legitimate courier — packages labeled "office supplies" but actually containing contraband. IDE tunneling works the same way: it abuses the network connectivity built into Integrated Development Environments (like VS Code's Remote Development feature) to create persistent, authenticated backdoors into internal systems, disguised as normal developer tooling traffic.

## Why it matters
In 2023, threat actors exploited VS Code's legitimate remote tunnel feature to maintain persistent access to compromised environments — the tunnel appears as authorized developer activity, bypasses most firewall rules since it uses HTTPS outbound connections to Azure infrastructure, and evades EDR tools that whitelist IDE processes. Defenders must audit which machines have Remote Tunnel enabled and monitor for unusual `code tunnel` process execution outside development environments.

## Key facts
- VS Code Remote Tunnels use Microsoft's `dev tunnels` infrastructure (formerly Visual Studio Tunnel Service) — traffic exits on port 443 to `global.rel.tunnels.api.visualstudio.com`, making it nearly indistinguishable from legitimate HTTPS
- The tunnel authenticates via GitHub or Microsoft account, meaning stolen OAuth tokens can re-establish access without malware on disk
- This is a **Living-off-the-Land (LotL)** technique — no custom implant required, just a signed, trusted binary
- Detection signatures include: `code.exe --tunnel`, `code-server` processes on non-developer endpoints, or unexpected Azure tunnel domain DNS queries
- Relevant MITRE ATT&CK mapping: **T1572** (Protocol Tunneling) and **T1021.005** (Remote Services: VNC — analogous category)

## Related concepts
[[Living off the Land (LotL)]] [[Protocol Tunneling]] [[Command and Control (C2)]] [[OAuth Token Abuse]] [[Defense Evasion]]