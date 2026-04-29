# ufw

## What it is
Think of ufw (Uncomplicated Firewall) as a bouncer at a club who works from a simple guest list — you tell him "allow port 22, deny everything else," and he enforces it without needing to understand the full complexity of iptables underneath. ufw is a frontend interface for Linux's iptables that translates human-readable rules into the low-level packet filtering instructions the kernel actually executes. It ships by default on Ubuntu and is designed to make host-based firewall management accessible without sacrificing control.

## Why it matters
In 2021, misconfigured cloud instances left MongoDB and Elasticsearch databases exposed on port 27017 and 9200 respectively — no authentication, no firewall. A single `ufw deny 27017` rule on those hosts would have blocked external access entirely, preventing data exfiltration while leaving application traffic unaffected. Proper ufw configuration is a critical hardening step in CIS Benchmark compliance for Linux servers.

## Key facts
- Default policy should be `ufw default deny incoming` + `ufw default allow outgoing` — deny-all inbound is the hardened baseline
- `ufw allow from 192.168.1.0/24 to any port 22` restricts SSH to a specific subnet, reducing attack surface dramatically
- ufw logs can be enabled with `ufw logging on`; logs write to `/var/log/ufw.log` and are critical for audit trails
- ufw is stateful by default — it tracks connection state, so return traffic for established connections is permitted automatically
- Rules are evaluated top-down; more specific rules should precede broader ones to avoid unintended permitting

## Related concepts
[[iptables]] [[host-based firewall]] [[network segmentation]] [[principle of least privilege]] [[CIS Benchmarks]]