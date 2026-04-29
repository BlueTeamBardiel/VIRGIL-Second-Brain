# reverse shell

## What it is
Imagine a locked door where you can't knock from outside — so instead, you trick someone inside to open it and call *you*. A reverse shell is a remote access technique where the *victim* machine initiates the outbound connection back to the attacker's listener, rather than the attacker connecting inward. This bypasses inbound firewall rules because the traffic looks like normal outbound traffic originating from inside the network.

## Why it matters
During the 2021 Log4Shell exploitation wave, attackers used the Log4j vulnerability to force vulnerable servers to execute a reverse shell payload, phoning home to attacker-controlled infrastructure on port 443 (HTTPS) to blend in with legitimate traffic. Defenders had to analyze outbound connections and look for unusual processes (like `java.exe` spawning `cmd.exe` or `bash`) to detect the compromise, since perimeter firewalls saw nothing suspicious inbound.

## Key facts
- Reverse shells exploit the asymmetry of firewall rules: outbound traffic is typically less restricted than inbound traffic
- Common implementation languages/tools: Netcat (`nc -e /bin/bash`), Python one-liners, Metasploit's `meterpreter`, and PowerShell
- Attackers frequently use ports 80, 443, or 53 to disguise reverse shell traffic as HTTP, HTTPS, or DNS
- Detection relies on behavioral indicators: unexpected parent-child process relationships (e.g., `apache` spawning `bash`) and anomalous outbound connection patterns
- Bind shells are the inverse — the victim listens and the attacker connects inward — making them easier to block at the firewall

## Related concepts
[[bind shell]] [[command and control (C2)]] [[payload delivery]] [[network egress filtering]] [[process hollowing]]