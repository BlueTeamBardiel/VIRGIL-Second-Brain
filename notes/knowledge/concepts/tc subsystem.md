# tc subsystem

## What it is
Think of `tc` (Traffic Control) as a traffic cop standing at a highway on-ramp, deciding which cars get through, how fast, and in what order. Precisely, `tc` is a Linux kernel subsystem and command-line utility that manages network packet scheduling, shaping, policing, and filtering using queuing disciplines (qdiscs) attached to network interfaces.

## Why it matters
Attackers with root access on a compromised Linux host can use `tc` with `cls_bpf` or `mirred` actions to silently clone and redirect network traffic to an attacker-controlled destination — essentially a kernel-level tap with no userspace process visible in `ps`. Defenders use `tc` to rate-limit suspicious traffic flows or enforce bandwidth policies that slow down data exfiltration even when malware is present.

## Key facts
- `tc` operates via **qdiscs** (queuing disciplines) such as `pfifo_fast`, `htb` (Hierarchical Token Bucket), and `netem` — each controlling how packets are queued and forwarded
- **`cls_bpf`** allows attaching eBPF programs as classifiers, making `tc` a powerful hook for both legitimate monitoring and stealthy packet manipulation
- **`mirred` action** can duplicate or redirect packets to another interface without the originating process knowing — a living-off-the-land exfiltration technique
- `tc` rules are **ephemeral by default** — they don't survive a reboot, so attackers often persist them via startup scripts or systemd units
- On Security+/CySA+ exams, `tc` appears in the context of **traffic shaping as a defense control** and **kernel-level persistence mechanisms** post-exploitation

## Related concepts
[[eBPF]] [[Network Traffic Analysis]] [[Linux Privilege Escalation]] [[Packet Filtering]] [[Living Off the Land Binaries]]