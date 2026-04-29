# BMC Control-M

## What it is
Think of it as an air traffic controller for enterprise IT jobs — instead of planes, it sequences thousands of automated batch processes, data transfers, and scripts across hybrid infrastructure. BMC Control-M is an enterprise workload automation (WA) platform that schedules, monitors, and orchestrates jobs across on-premises, cloud, and mainframe environments from a centralized interface.

## Why it matters
In 2023, researchers disclosed critical vulnerabilities in Control-M's API and web interface (CVE-2023-4771 and related CVEs) that allowed unauthenticated remote code execution — meaning an attacker who reached the management server could hijack every automated job in the enterprise. Because Control-M often runs with elevated privileges and touches financial batch processing, payroll, and backup jobs, compromise means an attacker can exfiltrate data, sabotage operations, or plant persistent backdoors inside trusted scheduled workflows without raising immediate alarms.

## Key facts
- Control-M operates over default ports including **8443** (HTTPS GUI) and **7005** (agent communication), which defenders should monitor and restrict at the network perimeter
- It uses an **agent-server architecture**: a central Control-M Server issues instructions to lightweight agents installed on target hosts, making the server a high-value single point of compromise
- Credentials for connecting to downstream systems (databases, FTP servers, cloud APIs) are stored as **connection profiles** — a goldmine for lateral movement if the server is breached
- Control-M jobs run under **service accounts**, which frequently have excessive privileges; attackers exploit this for privilege escalation
- It supports **API-based job submission**, meaning stolen API tokens can be used to inject malicious jobs silently without touching the GUI

## Related concepts
[[Workload Automation Security]] [[Privileged Access Management]] [[Lateral Movement]] [[Service Account Abuse]] [[Scheduled Task Persistence]]