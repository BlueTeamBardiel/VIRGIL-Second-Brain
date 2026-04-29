# fragmented packet attacks

## What it is
Imagine mailing a bomb by splitting it across 100 separate packages, each harmless alone — reassembly only happens at the destination. Fragmented packet attacks exploit IP fragmentation, where large packets are split into smaller fragments for transmission, by crafting malicious payloads spread across fragments so that security devices inspecting individual fragments miss the attack entirely. The dangerous payload only reveals itself after reassembly at the target host.

## Why it matters
In 1996, the Ping of Death attack sent oversized ICMP packets deliberately fragmented to bypass size checks; upon reassembly, the reconstructed packet exceeded 65,535 bytes and caused buffer overflows that crashed or rebooted systems. Modern IDS/IPS systems must perform full fragment reassembly before inspection — a computationally expensive operation that attackers exploit to exhaust resources or slip payloads past stateless firewalls that only examine individual fragments.

## Key facts
- **Teardrop attack**: Sends overlapping fragments with malformed offset values, causing the reassembly engine to crash when it cannot correctly reconstruct the packet
- **Firewall evasion**: Stateless firewalls inspect fragments individually and may approve each piece while the reassembled payload contains a malicious exploit or port scan
- **Tiny fragment attack**: Forces TCP header data into a second fragment so the first fragment contains too little header information for firewall rules (port-based ACLs) to trigger
- **Fragment offset field**: Located in the IP header, this 13-bit field tells the receiver where each fragment belongs — manipulation of this field is the core mechanism in most fragmentation attacks
- **Mitigation**: Stateful packet inspection with mandatory reassembly before rule evaluation, dropping abnormally small fragments (< 400 bytes carrying TCP headers), and RFC 1858 compliance checks

## Related concepts
[[ping of death]] [[IP spoofing]] [[intrusion detection evasion]] [[stateful packet inspection]] [[teardrop attack]]