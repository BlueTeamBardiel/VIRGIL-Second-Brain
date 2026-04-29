# Hildegard

## What it is
Like a squatter who breaks into an empty apartment, sets up a cryptocurrency mining operation, and hides behind the walls to avoid detection, Hildegard is a malware campaign that targets misconfigured Kubernetes clusters. Specifically, it exploits exposed kubelets (the node-level Kubernetes agents) to deploy cryptomining containers while evading detection using TeamTNT tooling and techniques.

## Why it matters
In 2021, security researchers at Palo Alto Unit 42 documented Hildegard actively scanning for Kubernetes clusters with anonymous authentication enabled on the kubelet API port (10250). Once inside, it deployed XMRig (a Monero miner), established IRC-based C2 communication, and used tmate for reverse shell persistence — demonstrating how cloud-native misconfigurations translate directly into financial loss and resource theft for organizations running workloads on Kubernetes.

## Key facts
- **Initial access vector:** Unauthenticated kubelet API (port 10250) with `--anonymous-auth=true` misconfiguration — a default that should always be disabled
- **Attributed to:** TeamTNT, the same threat group behind attacks on Docker and AWS credential theft campaigns
- **Payload:** XMRig cryptominer targeting Monero (XMR) due to its privacy features and CPU-mineable design
- **Evasion techniques:** Malicious code hidden inside legitimate Linux processes, use of `tmate` for encrypted reverse shells, and DNS-over-HTTPS to obscure C2 traffic
- **Detection signal:** Anomalous CPU spikes in container workloads, unexpected outbound DNS queries, and unauthorized container creation events in Kubernetes audit logs

## Related concepts
[[Cryptojacking]] [[Kubernetes Security]] [[Container Escape]] [[TeamTNT]] [[Misconfiguration Attacks]]