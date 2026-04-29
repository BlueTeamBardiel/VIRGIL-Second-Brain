# Scapy

## What it is
Think of Scapy as a LEGO set for network packets — you pick individual pieces (IP headers, TCP flags, payloads) and snap them together into any shape you want, then throw them onto the wire. Precisely, Scapy is an interactive Python-based packet manipulation library that allows users to forge, send, capture, and decode network packets at a granular protocol level. It operates across dozens of protocols including Ethernet, IP, TCP, UDP, ICMP, DNS, and ARP.

## Why it matters
During a penetration test, an attacker can use Scapy to craft a custom ARP reply that poisons a victim's ARP cache, redirecting their traffic through the attacker's machine — a classic man-in-the-middle setup. Defenders use Scapy in the same way a forensics team uses a scalpel: dissecting captured packets to reverse-engineer malware C2 communication patterns or validate that firewall rules are actually dropping malformed packets as expected.

## Key facts
- Scapy can both **craft and sniff** packets in the same session, making it a dual-use offense/defense tool
- Uses Python syntax: `IP(dst="192.168.1.1")/TCP(dport=80, flags="S")` creates a raw SYN packet
- Operates at **Layer 2 and above**, bypassing the OS TCP/IP stack when using raw sockets — this evades some host-based firewalls
- Commonly used to **simulate attacks** like SYN floods, ping of death, and Smurf attacks in controlled lab environments
- Unlike Wireshark, Scapy is **programmable** — enabling automated, scripted packet sequences for custom protocol fuzzing

## Related concepts
[[ARP Poisoning]] [[Packet Crafting]] [[Man-in-the-Middle Attack]] [[Protocol Fuzzing]] [[Raw Sockets]]