# cls_fw

## What it is
Think of it like a bouncer at a club who checks IDs against a list — but this bouncer lives inside the Linux kernel's networking stack. `cls_fw` (firewall classifier) is a Linux Traffic Control (tc) classifier that uses firewall marks (fwmarks) set by netfilter/iptables to classify packets for queuing disciplines (qdiscs), enabling policy-based traffic shaping based on firewall rules.

## Why it matters
An attacker who compromises a Linux router could manipulate `cls_fw` rules to reclassify malicious traffic into a high-priority queue, causing it to bypass rate-limiting controls or deprioritize legitimate traffic — effectively weaponizing QoS for a denial-of-service amplification effect. Defenders use `cls_fw` to enforce bandwidth policies that cooperate with iptables rules, meaning a misconfigured fwmark can silently break traffic shaping without generating obvious errors.

## Key facts
- `cls_fw` classifies packets by reading the `fwmark` value set by `iptables` using the `-j MARK --set-mark` target, creating a bridge between netfilter and tc
- It operates within the `tc filter` framework and is typically attached to a qdisc handle, matching marks to traffic classes (e.g., `tc filter add dev eth0 protocol ip handle 0x1 fw classid 1:10`)
- Misconfigured or absent fwmarks cause packets to fall through to a default class, which can unintentionally deprioritize critical security traffic like IDS/IPS telemetry
- `cls_fw` does not perform deep packet inspection — it relies entirely on marks already applied upstream by netfilter, making it dependent on the integrity of iptables rules
- Privilege escalation vulnerabilities in the Linux kernel's tc subsystem (e.g., CVE-2023-4128) have targeted classifiers including `cls_fw`, making kernel patching critical

## Related concepts
[[iptables]] [[Traffic Control (tc)]] [[Netfilter]] [[fwmark]] [[Queue Disciplines (qdiscs)]]