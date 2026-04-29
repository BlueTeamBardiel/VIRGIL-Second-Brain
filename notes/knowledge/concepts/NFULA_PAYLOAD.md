# NFULA_PAYLOAD

## What it is
Like reading the actual letter inside an envelope rather than just examining the envelope's postmark and address, `NFULA_PAYLOAD` is the attribute that carries the raw packet data in a Netfilter Userspace Logging (ULOG) message. Precisely, it is a TLV (Type-Length-Value) attribute within the `nflog` netlink message structure that contains the captured network packet bytes passed from kernel space to a userspace logging daemon such as `ulogd`.

## Why it matters
During network forensics, an attacker using a covert exfiltration channel (e.g., DNS tunneling or ICMP covert channels) can be detected by a `ulogd` pipeline that extracts and deep-inspects `NFULA_PAYLOAD` data. Security analysts writing custom `libnfnetlink` or `libnetfilter_log` parsers specifically pull this attribute to reconstruct full packet content, enabling payload-level signature matching that catches malware that carefully crafts headers to look legitimate but hides data in packet bodies.

## Key facts
- `NFULA_PAYLOAD` is attribute type `NFULA_PACKET_HDR + 9` (value `0x0009`) in the `nfnetlink_log` attribute enumeration defined in `linux/netfilter/nfnetlink_log.h`
- It delivers a copy of the packet up to the snapshot length (`snaplen`) configured in the `NFULNL_MSG_CONFIG` command — similar to `tcpdump`'s `-s` flag
- Data is in **network byte order (big-endian)**, so parsers must use `ntohs()`/`ntohl()` when reading multi-byte fields
- Accessible in userspace via `nflog_get_payload()` from `libnetfilter_log`, returning a raw byte pointer and length
- Capturing this attribute requires the iptables/nftables rule to target `NFLOG` with sufficient privileges (CAP_NET_ADMIN), making it a sensitive capability to audit on hardened systems

## Related concepts
[[Netfilter]] [[Netlink Sockets]] [[Packet Capture and Analysis]] [[Network Forensics]] [[Linux Capabilities]]