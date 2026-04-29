# SKB

## What it is
Like a locked filing cabinet that only the kernel itself holds the key to, the Socket Key Buffer (SKB) is Linux's internal data structure (`sk_buff`) used to manage network packets as they travel through the kernel's networking stack. It stores packet data, metadata, and protocol headers in a contiguous memory region, allowing efficient manipulation without copying data repeatedly.

## Why it matters
SKB vulnerabilities have led to serious kernel-level exploits. For example, CVE-2016-10229 involved a double-fetch vulnerability in UDP packet processing where an attacker could manipulate SKB data between two kernel reads, potentially achieving remote code execution with ring-0 privileges — a complete system compromise with no user-space containment possible.

## Key facts
- `sk_buff` is the core Linux kernel structure; every network packet in transit is wrapped in one, containing pointers to headers (MAC, IP, TCP/UDP) rather than copying them
- SKB vulnerabilities are classified as **kernel memory corruption** bugs — exploiting them bypasses ASLR, DEP, and most userland mitigations entirely
- **Use-after-free** and **heap overflow** are the two most common SKB vulnerability classes, often triggered by malformed packets
- Security tools like **eBPF** and **XDP (eXpress Data Path)** intercept and inspect SKBs at early processing stages for intrusion detection and DDoS mitigation
- Linux kernel hardening features like **KASAN** (Kernel Address Sanitizer) and **SLUB hardening** specifically help detect SKB-related heap corruption during development and testing

## Related concepts
[[Kernel Exploitation]] [[Buffer Overflow]] [[eBPF]] [[Heap Spray]] [[Network Packet Analysis]]