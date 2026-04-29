# Siloscape

## What it is
Imagine a prisoner who escapes not just their cell, but the entire prison building — Siloscape is malware that breaks out of Windows containers to compromise the underlying Kubernetes cluster host. It is the first known malware specifically designed to escape Windows Server containers by abusing Windows named pipes and misconfigured Kubernetes clusters to gain node-level access.

## Why it matters
In a real-world scenario, an attacker compromises a vulnerable web application running inside a Windows container (e.g., an IIS or SQL Server workload). Siloscape exploits the container's privileged access to Windows named pipes, escapes to the host node, then deploys a Tor-based C2 backdoor and spreads laterally across the entire Kubernetes cluster — potentially compromising every workload running in it.

## Key facts
- Discovered in 2021 by Palo Alto Networks Unit 42; targets Windows Server Containers (not Hyper-V isolated containers, which provide stronger kernel isolation)
- Exploits multiple known CVEs in web servers and databases as the initial entry point into the container
- Uses Windows named pipe impersonation to escape the container and gain SYSTEM-level privileges on the host node
- Communicates via Tor to a C2 server, making traffic analysis and attribution significantly harder
- Hyper-V containers were NOT vulnerable because each gets its own isolated kernel — a critical architectural distinction for defense

## Related concepts
[[Container Escape]] [[Kubernetes Security]] [[Privilege Escalation]] [[Lateral Movement]] [[Command and Control (C2)]]