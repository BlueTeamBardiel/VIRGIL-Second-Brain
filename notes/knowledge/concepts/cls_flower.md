# cls_flower

## What it is
Think of it like a postal sorting machine that reads the actual label on a package rather than just checking which truck it arrived on — cls_flower (Flower Classifier) is a Linux kernel traffic control (tc) classifier that matches network packets based on specific flow key attributes such as IP addresses, ports, VLAN IDs, and protocol types. It operates within the Linux tc subsystem and is frequently offloaded to hardware (NICs/switches) for line-rate filtering.

## Why it matters
In 2023, a privilege escalation vulnerability (CVE-2023-1829) was discovered in the cls_flower implementation where a use-after-free bug allowed local attackers to escalate privileges to root by manipulating traffic control filter deletion. This made it a critical attack vector on Linux servers and container hosts, since any local user or compromised container process could potentially own the host kernel.

## Key facts
- cls_flower is part of the Linux kernel's **tc (traffic control)** subsystem, used for Quality of Service (QoS) and packet filtering at the network layer
- CVE-2023-1829 is a **use-after-free vulnerability** in cls_flower — local privilege escalation to root; CVSS score 7.8 (High)
- The classifier supports **hardware offloading**, meaning filter rules can be pushed directly to smart NICs or switches, bypassing the kernel — a double-edged sword for security visibility
- Exploitation of cls_flower bugs typically requires **local access or code execution** in an unprivileged container, making container escape scenarios highly relevant
- Mitigations include patching the kernel, restricting `CAP_NET_ADMIN` capability, and using **seccomp/AppArmor profiles** to block tc syscalls in container environments

## Related concepts
[[Linux Kernel Privilege Escalation]] [[Use-After-Free Vulnerability]] [[Container Escape]] [[Network Traffic Classification]] [[Capability-Based Access Control]]