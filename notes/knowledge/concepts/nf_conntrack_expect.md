# nf_conntrack_expect

## What it is
Like a bouncer with a guest list who pre-approves someone's "+1" before they arrive at the door, `nf_conntrack_expect` is a Linux kernel mechanism that pre-registers anticipated *secondary* connections spawned by an existing tracked connection. It is part of the Netfilter connection tracking subsystem, allowing stateful firewalls to permit dynamically-negotiated data channels (like FTP's data port) without leaving rules permanently wide open.

## Why it matters
FTP in active mode negotiates a random high-numbered data port via the control channel — without `nf_conntrack_expect`, a stateful firewall would silently drop that incoming data connection. Attackers have exploited helper modules that populate the expect table (e.g., `nf_conntrack_ftp`) to punch temporary holes in firewall policy, effectively hijacking the expectation mechanism to slip malicious traffic through a "pre-approved" slot before it expires.

## Key facts
- Expectations are **time-limited** (default timeout ~30 seconds) and stored in a separate expect table distinct from the main conntrack table
- The expect table has a configurable maximum size via `/proc/sys/net/netfilter/nf_conntrack_expect_max`; exhausting it causes a DoS by dropping all new expected connections
- Protocol helpers (`nf_conntrack_ftp`, `nf_conntrack_sip`, `nf_conntrack_h323`) automatically create expectations by deep-inspecting the control channel payload — this makes them **ALG (Application Layer Gateway)** components
- Unintended helpers can be exploited: an attacker-controlled FTP server can instruct a victim's NAT gateway to open expects toward arbitrary internal hosts (NAT slipstreaming variant)
- Since Linux kernel 4.7, auto-loading of conntrack helpers is **disabled by default** (`nf_conntrack_helper=0`) to reduce attack surface

## Related concepts
[[nf_conntrack]] [[Network Address Translation (NAT)]] [[Stateful Firewall]] [[Application Layer Gateway]] [[NAT Slipstreaming]]