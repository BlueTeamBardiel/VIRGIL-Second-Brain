# Packet Capture Analysis

## What it is
Like intercepting every letter passing through a post office and reading the envelopes (and sometimes the contents), packet capture analysis is the practice of recording raw network traffic at the bit level and then dissecting it to understand what data moved between systems, when, and how. Analysts use tools like Wireshark or tcpdump to capture frames off a network interface and reconstruct conversations, protocols, and payloads.

## Why it matters
During a data exfiltration investigation, a SOC analyst might notice anomalous outbound traffic spikes to an unfamiliar IP. By pulling a PCAP from a network tap and filtering for that destination, they can reconstruct the exact bytes transferred — potentially revealing credentials, documents, or C2 beacon patterns that no log file would expose.

## Key facts
- **Full packet capture (FPC)** records entire payloads; **flow data (NetFlow)** records only metadata — FPC is richer but storage-intensive
- Wireshark's **display filters** (e.g., `http.request.method == "POST"`) differ from **capture filters** (BPF syntax); confusing them is a common exam trap
- **Promiscuous mode** must be enabled on the NIC to capture traffic not addressed to that host; on switched networks, a **port mirror (SPAN port)** or **network tap** is required
- TLS-encrypted traffic requires the session key or a man-in-the-middle proxy to decrypt payloads; analysts often rely on metadata (size, timing, SNI) instead
- **Protocol dissection** — Wireshark following a TCP stream to reconstruct an HTTP session — is a core CySA+ skill tested in performance-based questions

## Related concepts
[[Network Traffic Analysis]] [[Intrusion Detection Systems]] [[NetFlow Analysis]] [[Wireshark]] [[Man-in-the-Middle Attack]]