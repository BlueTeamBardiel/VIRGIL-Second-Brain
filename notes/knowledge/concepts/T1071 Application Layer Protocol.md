# T1071 Application Layer Protocol

## What it is
Imagine a spy sending secret messages hidden inside ordinary postcards — the postal system delivers them without suspicion because postcards are expected. Application Layer Protocol abuse works the same way: attackers tunnel malicious command-and-control (C2) traffic through legitimate protocols like HTTP, HTTPS, DNS, or SMTP so it blends invisibly into normal network traffic.

## Why it matters
The APT group APT29 (Cozy Bear) famously used HTTPS-based C2 communications during the SolarWinds compromise, routing beacon traffic through legitimate-looking web requests that bypassed perimeter firewalls entirely. Defenders countering this technique rely on behavioral baselines — flagging unusual volumes of DNS queries or HTTP POSTs to unknown external domains rather than trying to block the protocol itself.

## Key facts
- **Sub-techniques include:** T1071.001 (Web Protocols/HTTP/HTTPS), T1071.002 (File Transfer Protocols/FTP), T1071.003 (Mail Protocols/SMTP), T1071.004 (DNS)
- **DNS is particularly dangerous** because many organizations allow outbound DNS without deep inspection, making DNS tunneling (e.g., using tools like dnscat2) highly effective
- **Detection relies on anomaly detection**, not signature matching — look for abnormal beacon intervals, high query frequency, or unusually long DNS hostnames
- **Firewall rules alone don't stop it** — traffic uses allowed ports (80, 443, 53), so application-layer inspection (DPI) or proxy enforcement is required
- **MITRE ATT&CK maps this to the Command and Control tactic**, making it a core concept for CySA+ threat-hunting scenarios

## Related concepts
[[DNS Tunneling]] [[Command and Control]] [[Network Traffic Analysis]] [[Deep Packet Inspection]] [[T1572 Protocol Tunneling]]