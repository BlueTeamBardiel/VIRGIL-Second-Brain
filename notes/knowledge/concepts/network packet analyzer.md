# network packet analyzer

## What it is
Like a postal inspector who opens every envelope passing through a sorting facility and reads the contents, a network packet analyzer (also called a sniffer) captures raw network traffic at the frame level and decodes it into human-readable form. Tools like Wireshark reassemble TCP streams, decode protocols, and display payloads, headers, and timing data for every packet traversing a network interface.

## Why it matters
During a credential-harvesting attack on an unencrypted HTTP login portal, an attacker with access to the same network segment can run tcpdump or Wireshark in promiscuous mode and capture plaintext usernames and passwords as they transit the wire. Defenders use the same technique to reconstruct attack timelines, identify C2 beaconing patterns, or prove that sensitive data was exfiltrated without encryption.

## Key facts
- **Promiscuous mode** allows a NIC to capture all packets on a segment, not just those addressed to it — required for passive sniffing
- Wireshark's **display filters** (e.g., `http.request.method == "POST"`) differ from **capture filters** (BPF syntax like `port 80`) — a common exam distinction
- On switched networks, sniffing is limited to your own port unless you use **ARP poisoning**, a **SPAN/mirror port**, or a **network tap**
- **Protocol analyzers** can reassemble application-layer data (files, emails, credentials) from fragmented TCP streams using stream following
- Packet capture files use the `.pcap` or `.pcapng` format and are admissible as forensic evidence when chain of custody is maintained

## Related concepts
[[ARP poisoning]] [[promiscuous mode]] [[network tap]] [[traffic analysis]] [[intrusion detection system]]